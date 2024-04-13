import 'dart:convert';

import 'package:divertissement/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

List<UserModel> userModel = [];

link(route, endpoint) {
  String hostLink = "";
  hostLink = "https://div-prod.vercel.app" + "/" + route;
  return hostLink;
}

register(pseudo, nom, prenom, score) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('pseudo', pseudo);
  prefs.setString('nom', nom);
  prefs.setString('prenom', prenom);
  prefs.setString('score', score);
}

getHighScore() async {
  String apiLink =  link('user/high', '');
  var response = await http.get(Uri.parse(apiLink));
  if (response.statusCode == 200) {
    var jsonData = json.decode(response.body);
    print(jsonData);
    userModel = (jsonData as List<dynamic>)
        .map((json) => UserModel.fromJson(json))
        .toList();
    return userModel;
  } else {
    print('An error occured getting highscore ${response.statusCode}');
  }
}
