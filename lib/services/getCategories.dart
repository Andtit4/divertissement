import 'dart:convert';

import 'package:http/http.dart' as http;

getCategories() async {
  String apiUrl = 'https://opentdb.com/api.php?amount=10';
  var response = await http.post(Uri.parse(apiUrl));

  if (response.statusCode == 200) {
    Map<String, dynamic> data = json.decode(response.body);
    print(data);
    return List<Map<String, dynamic>>.from(data['results']);
  } else {
    throw Exception('Erreur de chargement des questions de cinéma');
  }
}

Future<Map<String, dynamic>> fetchCinemaData() async {
  String apiUrl = 'https://opentdb.com/api_category.php';
  final response = await http.get(Uri.parse(apiUrl));

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Erreur de chargement des données de cinéma');
  }
}
