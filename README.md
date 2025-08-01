# 🗣️ Flutter Text-to-Speech App

A professional Flutter application that converts user-input text into spoken words using the `flutter_tts` package. The app supports multiple languages and allows users to switch between available voices (if supported). Designed with accessibility and user experience in mind.

---

## 📲 Features

- ✅ Multilingual text-to-speech support
- 🔁 Voice switching for supported languages
- 📝 Clean and minimalistic UI
- 📋 Real-time feedback with custom snackbars
- 📱 Responsive layout across different screen sizes

---

## 🚀 Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (version 3.0 or higher)
- Android Studio / VS Code
- A physical/emulated device (Android/iOS)

### Installation Steps

1. **Clone the repository**
   ```bash
   Install dependencies

2.
flutter pub get
Run the application
3.
flutter run

📤 Submission Summary
Apk link to download: https://github.com/yourusername/flutter-tts-app

Demo Video: https://your-demo-link.com

⚠️ Known Limitations & Assumptions
Some languages may not have voice support depending on the platform (Android/iOS).

Voice switching is only available when multiple voices exist for the selected language.

App UI is optimized for portrait mode.

Internet may be required for voice loading depending on the device.

📁 Project Structure

lib/
├── core/
│   ├── constant/
│   │   ├── app_colors.dart
│   │   ├── app_strings.dart
│   │   └── languages.dart
│   └── utils/
│       └── custom_snackbar.dart
├── services/
│   └── tts_services.dart
├── views/
│   └── text_to_speech_view.dart
└── main.dart



   git clone https://github.com/yourusername/flutter-tts-app.git
   cd flutter-tts-app
