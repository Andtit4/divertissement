class QuestionModel {
  String question;
  String categorie;

  QuestionModel({required this.question, required this.categorie});

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
        question: json['question'], categorie: json['categorie']);
  }
}
