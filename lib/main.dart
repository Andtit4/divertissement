import 'package:divertissement/screens/splaschscreen.dart';
import 'package:divertissement/services/getCategories.dart';
import 'package:divertissement/services/score_controller.dart';
import 'package:divertissement/services/seconds.binding.dart';
import 'package:divertissement/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Map<String, dynamic> cinemaData = await fetchCinemaData();
  List<dynamic> categories = cinemaData['trivia_categories'];
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: SecondBinding(),
      debugShowCheckedModeBanner: false,
      title: 'Divertissement',
      theme: ThemeData(
        textTheme: defaultTextTheme,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: GetBuilder<ScoreController>(
        init: ScoreController(),
        builder: (_) => MyHomePage(title: '',),
      ),
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
  // ScoreController scoreController = Get.put(ScoreController());

  @override
  Widget build(BuildContext context) {
    return SplashScreen();
  }
}
