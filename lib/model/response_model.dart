class ResponseModel {
  String id;
  String reponse;
  String type;
  String id_question;

  ResponseModel(
      {required this.id,
      required this.reponse,
      required this.id_question,
      required this.type});

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
        id: json['id'],
        reponse: json['reponse'],
        id_question: json['id_question'],
        type: json['type']);
  }
}
