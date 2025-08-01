class TtsVoiceModel {
  final String name;
  final String locale;

  TtsVoiceModel({required this.name, required this.locale});

  factory TtsVoiceModel.fromMap(Map<String, dynamic> map) {
    return TtsVoiceModel(
      name: map['name'] ?? '',
      locale: map['locale'] ?? '',
    );
  }

  Map<String, String> toMap() {
    return {'name': name, 'locale': locale};
  }
}
