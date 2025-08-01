import 'package:flutter_tts/flutter_tts.dart';

class TtsService {
  final FlutterTts _flutterTts = FlutterTts();
  List<dynamic> _voices = [];
  List<Map<String, String>> _filteredVoices = [];
  int _currentVoiceIndex = 0;

  Future<void> init() async {
    await _flutterTts.setVolume(1.0);
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.setPitch(1.0);
    _voices = await _flutterTts.getVoices;
  }

  Future<List<Map<String, String>>> getVoicesForLang(String lang) async {
    _filteredVoices = _voices
        .where((voice) =>
            voice is Map &&
            voice.containsKey('locale') &&
            voice['locale'].toString().startsWith(lang))
        .map<Map<String, String>>((voice) => {
              'name': voice['name'].toString(),
              'locale': voice['locale'].toString(),
            })
        .toList();

    if (_filteredVoices.isEmpty) {
      throw Exception("Language not supported on this device.");
    }

    _currentVoiceIndex = 0;
    return _filteredVoices;
  }

  Future<void> speak(String text) async {
    if (_filteredVoices.isNotEmpty) {
      final selectedVoice = _filteredVoices[_currentVoiceIndex];
      await _flutterTts.setVoice(selectedVoice);
    }
    await _flutterTts.speak(text);
  }

  Future<void> stop() async {
    await _flutterTts.stop();
  }

  bool toggleVoice() {
    if (_filteredVoices.length <= 1) return false;
    _currentVoiceIndex = (_currentVoiceIndex + 1) % _filteredVoices.length;
    return true;
  }

  String get currentVoiceName =>
      _filteredVoices.isNotEmpty ? _filteredVoices[_currentVoiceIndex]['name']! : 'Default';
}
