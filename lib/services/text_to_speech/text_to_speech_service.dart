import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeechService {
  final FlutterTts flutterTts = FlutterTts();
  String language;

  TextToSpeechService({this.language = 'en-US'});

  Future<void> initializeTextToSpeech() async {
    await flutterTts.awaitSpeakCompletion(true);
    await flutterTts.setSharedInstance(true);
    await flutterTts.setIosAudioCategory(
        IosTextToSpeechAudioCategory.playAndRecord,
        [IosTextToSpeechAudioCategoryOptions.defaultToSpeaker]);
    await flutterTts.setLanguage(language);
    await flutterTts.setVolume(1.0);
  }

  Future<void> systemSpeak(String content) async {
    await flutterTts.speak(content);
  }

  Future<void> systemStopSpeaking() async {
    await flutterTts.stop();
  }
}
