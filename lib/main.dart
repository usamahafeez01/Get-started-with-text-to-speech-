import 'package:flutter/material.dart';

import 'package:speech_to_text/ui/screens/tts_view.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, 

      title: 'TTS Multilingual',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const TextToSpeechView(),
    );
  }
}

