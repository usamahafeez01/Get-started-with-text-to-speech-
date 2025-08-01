import 'package:flutter/material.dart';
import 'package:speech_to_text/core/constant/app_strings.dart';
import 'package:speech_to_text/core/constant/languges.dart';

class LanguageDropdown extends StatelessWidget {
  final String selectedLang;
  final Function(String) onChanged;

  const LanguageDropdown({
    super.key,
    required this.selectedLang,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedLang,
      decoration: const InputDecoration(labelText: AppStrings.selectLanguage),
      items: supportedLanguages.entries.map((entry) {
        return DropdownMenuItem(value: entry.value, child: Text(entry.key));
      }).toList(),
      onChanged: (val) => onChanged(val!),
    );
  }
}
