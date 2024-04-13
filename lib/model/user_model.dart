class UserModel {
  int id;
  String nom;
  String pseudo;
  String email;
  String mot_de_passe;
  int score;

  UserModel(
      {required this.email,
      required this.id,
      required this.mot_de_passe,
      required this.nom,
      required this.pseudo,
      required this.score});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        email: json['email'],
        id: json['id'],
        mot_de_passe: json['mot_de_passe'],
        nom: json['nom'],
        pseudo: json['pseudo'],
        score: json['score']);
  }
}
