class SpeechModal {
  final String name;
  final String speechId;
  final String speech;
  final String response;

  SpeechModal(
      {required this.name,
      required this.speech,
      required this.speechId,
      required this.response});
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'speechid': speechId,
      'speech': speech,
      'response': response
    };
  }

  factory SpeechModal.fromMap(
    Map<String, dynamic> map,
  ) {
    return SpeechModal(
      name: map['name'] ?? '',
      speechId: map['speechId'] ?? '',
      speech: map['speech'] ?? '',
      response: map['response'] ?? '',
    );
  }
}
