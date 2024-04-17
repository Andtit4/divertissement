import 'dart:convert';

import 'package:divertissement/model/user_model.dart';
import 'package:divertissement/partials/bottom_nav_bar.dart';
import 'package:get/get.dart';
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

logout() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('pseudo');
}

getHighScore() async {
  String apiLink = link('user/high', '');
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

getAuth(email, mot_de_passe) async {
  String apiLink =
      link('/user/auth?email=${email}&mot_de_passe=${mot_de_passe}', '');
  var reponse = await http.get(Uri.parse(apiLink));
  if (reponse.statusCode == 200) {
    var jsonData = json.decode(reponse.body);
    if (jsonData[0]['nom'] == '') {
      print('Email ou mot de passe incorrect');
    } else {
      print('Auth ${jsonData[0]['nom']}');
      register(
          jsonData[0]['pseudo'], jsonData[0]['nom'], jsonData[0]['email'], '0');
      Get.offAll(() => BottomNavBar(),
          transition: Transition.leftToRight,
          duration: const Duration(seconds: 3));
    }
    return jsonData;
  } else {
    print('An error occured getting highscore ${reponse.statusCode}');
  }
}

createAccount(nom, pseudo, email, mot_de_passe, score) async {
  String apiLink = link('user', '');

  var response = await http.post(Uri.parse(apiLink), body: {
    'nom': nom,
    'pseudo': pseudo,
    'email': email,
    'mot_de_passe': mot_de_passe,
    'score': score
  });

  if (response.statusCode == 200) {
    register(pseudo, nom, email, '0');
    Get.offAll(() => BottomNavBar(),
        transition: Transition.leftToRight,
        duration: const Duration(seconds: 3));
  } else {
    print('An error occured creating user ${response.statusCode}');
  }
}

setNewScore(score, email) async {
  String apiLink = link('user?score=${score}&email=${email}', '');

  var response = await http.put(Uri.parse(apiLink));

  if (response.statusCode == 200) {
    print('New score st');
    // Navigator.pop(context);
    Get.back();
    Get.offAll(() => BottomNavBar());
  } else {
    print('An error occured setting score ${response.statusCode}');
  }
}
