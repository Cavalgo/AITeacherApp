import 'dart:developer';

import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechToTextService {
  late bool isSpeechEnable;
  String? detectedWords;
  String language;
  final SpeechToText speechToText = SpeechToText();

  SpeechToTextService({this.language = 'en-US'});

  Future<void> initializeSpeechTT() async {
    isSpeechEnable = await speechToText.initialize();
  }

  Future<void> startListening() async {
    detectedWords = null;
    await speechToText.listen(
      pauseFor: const Duration(seconds: 5),
      localeId: language,
      onResult: (SpeechRecognitionResult result) {
        log('detected words');
        log(result.recognizedWords);
        detectedWords = result.recognizedWords;
        return;
      },
    );
  }

  Future<bool> stopListening() async {
    //This will cause a final result to be sent
    try {
      await speechToText.stop();
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<void> cancelListening() async {
    speechToText.cancel();
  }
}
