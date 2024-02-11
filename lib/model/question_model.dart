class QuestionModel {
  int id;
  String question;
  String categorie;

  QuestionModel(
      {required this.question, required this.categorie, required this.id});

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
        id: json['id'],
        question: json['question'],
        categorie: json['categorie']);
  }
}
