import 'package:shared_preferences/shared_preferences.dart';

link(route, endpoint) {
  String hostLink = "";
  hostLink = "https://divertissement.rekou.net/api" + "/" + route;
  return hostLink;
}

register(pseudo, nom, prenom) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('pseudo', pseudo);
  prefs.setString('nom', nom);
  prefs.setString('prenom', prenom);
}
