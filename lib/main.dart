import 'package:divertissement/screens/splaschscreen.dart';
import 'package:divertissement/services/getCategories.dart';
import 'package:divertissement/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Appelle la fonction pour obtenir les données de cinéma
  Map<String, dynamic> cinemaData = await fetchCinemaData();

  // Extrait la liste des catégories
  List<dynamic> categories = cinemaData['trivia_categories'];
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MyZik',
      theme: ThemeData(
        textTheme: defaultTextTheme,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return SplashScreen();
  }
}
