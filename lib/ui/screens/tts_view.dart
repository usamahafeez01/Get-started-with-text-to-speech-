// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:speech_to_text/core/constant/app_colors.dart';
import 'package:speech_to_text/core/constant/app_strings.dart';
import 'package:speech_to_text/core/constant/languges.dart';
import 'package:speech_to_text/core/utlis/custom_snackbar.dart';
import 'package:speech_to_text/services/tts_services.dart';
import 'package:dropdown_button2/dropdown_button2.dart';


class TextToSpeechView extends StatefulWidget {
  const TextToSpeechView({super.key});

  @override
  State<TextToSpeechView> createState() => _TextToSpeechViewState();
}

class _TextToSpeechViewState extends State<TextToSpeechView> {
  final TtsService _ttsService = TtsService();
  final TextEditingController _controller = TextEditingController();

  String _selectedLang = supportedLanguages.values.first;
  bool _voicesLoaded = false;

  @override
  void initState() {
    super.initState();
    _ttsService.init().then((_) => _loadVoices());
  }

  Future<void> _loadVoices() async {
    try {
      final voices = await _ttsService.getVoicesForLang(_selectedLang);
      if (voices.isEmpty) {
        CustomizedSnackbar.show(context: context,label: AppStrings.alertText,message: AppStrings.notsupported);
      }
      setState(() => _voicesLoaded = true);
    } catch (e) {
              CustomizedSnackbar.show(context: context,label: AppStrings.alertText,message: AppStrings.wentwrongspeaking);

    }
  }

  void _playSpeech() async {
    if (_controller.text.trim().isEmpty) return;
    try {
      await _ttsService.speak(_controller.text);
    } catch (e) {
                    CustomizedSnackbar.show(context: context,label: AppStrings.alertText,message: AppStrings.wentwrongspeaking);

    }
  }

  void _switchVoice() async {
  try {
    final switched = _ttsService.toggleVoice();
    if (!switched) {
      CustomizedSnackbar.show(
        context: context,
        label: AppStrings.alertText,
        message: AppStrings.onlyOneVoiceAvailable,
      );
    } else {
      CustomizedSnackbar.show(
        context: context,
        label: AppStrings.alertText,
        message: AppStrings.voiceSwitchedSuccessfully,
      );
    }
  } catch (e) {
    CustomizedSnackbar.show(
      context: context,
      label: AppStrings.alertText,
      message: AppStrings.unableToSwitchVoice,
    );
  }
}
  
  @override
  void dispose() {
    _controller.dispose();
    _ttsService.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appTitle),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: AppColors.whiteColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                _buildLanguageDropdown(),
                const SizedBox(height: 20),
TextField(
  controller: _controller,
  decoration: InputDecoration(
    hintText: AppStrings.enterText,hintStyle: TextStyle(fontSize: 11,color: Colors.grey), 
    alignLabelWithHint: true, 
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    filled: true,
    fillColor: AppColors.whiteColor,
  ),
  minLines: 3,
  maxLines: 5,
),
 const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: _playSpeech,
                  icon: const Icon(Icons.volume_up),
                  label: const Text(AppStrings.speakText),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: AppColors.whiteColor,
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: _voicesLoaded ? _switchVoice : null,
                  icon: const Icon(Icons.voice_chat),
                  label: const Text(AppStrings.switchVoice),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    backgroundColor: AppColors.indigoColor,
                    foregroundColor: AppColors.whiteColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageDropdown() {
    final theme = Theme.of(context);

    return DropdownButtonFormField2<String>(
      value: _selectedLang,
      items: supportedLanguages.entries.map((entry) {
        return DropdownMenuItem<String>(
          value: entry.value,
          child: Text(entry.key, style: TextStyle(fontWeight: FontWeight.normal, fontSize: 11)),
        );
      }).toList(),
      onChanged: (val) async {
        if (val == null) return;
        setState(() {
          _selectedLang = val;
          _voicesLoaded = false;
        });
        try {
          final voices = await _ttsService.getVoicesForLang(val);
          if (voices.isEmpty) {
                          CustomizedSnackbar.show(context: context,label: AppStrings.alertText,message: AppStrings.languageNotSupported);

          }
          setState(() => _voicesLoaded = true);
        } catch (e) {
                                    CustomizedSnackbar.show(context: context,label: AppStrings.alertText,message: AppStrings.voiceLoadingFailed);

        }
      },
      decoration: InputDecoration(
        labelText: AppStrings.selectLanguage,
        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
