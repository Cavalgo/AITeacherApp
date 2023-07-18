import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:ai_chat_voice/secrets.dart';

class OpenAIService {
  List<Map<String, String>> listOFMesseges = [];
  late List<Map<String, String>> isArtPrompt = [];
  final myHeaders = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $openAiApiKey',
  };

//########################## CONSTRUCTOR #########################################
  OpenAIService({String systemRole = "You're a helpful assistant"}) {
    listOFMesseges.add({
      "role": "system",
      "content": systemRole,
    });
  }

  //########################## chatGPT #########################################
  Future<String> _sendMessageToChatGPT(
      {required List<Map<String, String>> message}) async {
    try {
      http.Response response = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: myHeaders,
        body: jsonEncode({
          'model': 'gpt-3.5-turbo',
          'messages': message,
        }),
      );
      if (response.statusCode == 200) {
        String responseBody = response.body;
        List<int> responseBytes = responseBody.codeUnits;
        String decodedResponse = utf8.decode(responseBytes);
        Map<String, dynamic> json = jsonDecode(decodedResponse);
        String content = json['choices'][0]['message']['content'];
        /*
        Map<String, dynamic> json = jsonDecode(response.body);
        String content = json['choices'][0]['message']['content'];
        */
        log(content.toString());
        return content;
      } else {
        return 'An internal error has occured';
      }
    } catch (e) {
      return e.toString();
    }
  }

//########################## DALL-E API #########################################

  Future<String> sendMessageToDallE(String prompt) async {
    http.Response response = await http.post(
        Uri.parse('https://api.openai.com/v1/images/generations'),
        headers: myHeaders,
        body: jsonEncode({
          "prompt": prompt,
          "n": 1,
          "size": "1024x1024",
        }));
    final json = jsonDecode(response.body);
    String url = json["data"][0]['url'];
    log(url);
    return 'dall-e';
  }

//########################## IS IT A PROMPT API? #########################################
  Future<String> sendMessageChatGPT(String prompt) async {
    if (listOFMesseges.length > 10) {
      listOFMesseges.removeAt(1);
      listOFMesseges.removeAt(1);
    }
    listOFMesseges.add({
      "role": "user",
      "content": prompt,
    });
    String chatGPTAnswer = await _sendMessageToChatGPT(
      message: listOFMesseges,
    );
    listOFMesseges.add({
      "role": "system",
      "content": chatGPTAnswer,
    });
    return chatGPTAnswer;
  }
}
