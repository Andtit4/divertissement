import 'dart:async';
import 'dart:convert';
import 'package:divertissement/model/question_model.dart';
import 'package:divertissement/model/response_model.dart';
import 'package:divertissement/partials/bottom_nav_bar.dart';
import 'package:divertissement/services/local.dart';
import 'package:divertissement/services/score_controller.dart';
import 'package:get/get.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:divertissement/partials/loading.dart';
import 'package:divertissement/utils/constants.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Quizz extends StatefulWidget {
  final String link;
  const Quizz({super.key, required this.link});

  @override
  State<Quizz> createState() => _QuizzState();
}

class _QuizzState extends State<Quizz> {
  final ScoreController scoreController = Get.put(ScoreController());

  List<dynamic>? questions;
  Color borderColor = Colors.transparent;
  Color colorResponse = Colors.red;
  bool pressed = false;
  PageController controller = PageController();
  int currentPage = 1;
  String highScore = '';
  Timer? _timer;
  int _seconds = 0;

  setScore(score) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('score', score);
  }

  getScore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      highScore = prefs.getString('score').toString();
    });
  }

  fetchCinemaData() async {
    final response = await http.post(Uri.parse(widget.link));
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      print('Link: ${widget.link}');
      print('questions: $jsonData');
      var questions = (jsonData as List<dynamic>)
          .map((json) => QuestionModel.fromJson(json))
          .toList();
      return questions;
      /*   Map<String, dynamic> cinemaData = json.decode(response.body);
      questions = cinemaData['results']; */
    } else {
      throw Exception('Erreur de chargement des données de la question');
    }
  }

  fetchResponses(id_question) async {
    String apiLink =
        link('getReponseByQuestion.php?id_question=$id_question', '');
    final response = await http.get(Uri.parse(apiLink));
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      var responses = (jsonData as List<dynamic>)
          .map((json) => ResponseModel.fromJson(json))
          .toList();
      return responses;
    } else {
      throw Exception('Erreur de chargement de la réponse');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchCinemaData();
    getScore();
    // _startTimer();
    scoreController.increment();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: primaryColor,
      body: SingleChildScrollView(
        child: SizedBox(
          width: screenWidth(context),
          height: screenHeight(context),
          child: Stack(
            children: [
              SizedBox(
                  width: screenWidth(context),
                  height: screenHeight(context),
                  child: FluImage(
                    'assets/cinema.jpg',
                    imageSource: ImageSources.asset,
                  )),
              SizedBox(
                height: screenHeight(context) * .04,
              ),
              Positioned(
                top: screenHeight(context) * .04,
                child: SizedBox(
                  width: screenWidth(context),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          FluButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              backgroundColor: Colors.transparent,
                              child: FluIcon(
                                FluIcons.closeCircle,
                                color: Colors.white,
                                style: FluIconStyles.bulk,
                              )),
                          Obx(() => Text(
                              'Score: ${scoreController.score} points',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))),
                        ],
                      ),
                      Obx(() => Text(
                          'Secondes : ${scoreController.seconds.value}',
                          style: TextStyle(fontSize: 18, color: Colors.white)))
                    ],
                  ),
                ),
              ),
              Positioned(
                top: screenHeight(context) * .15,
                child: SizedBox(
                  width: screenWidth(context),
                  height: screenHeight(context) * .7,
                  child: FutureBuilder(
                    future: fetchCinemaData(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: TiLoading(),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            'Oups ${snapshot.error}',
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      } else {
                        List<QuestionModel> data = snapshot.data ?? [];

                        return PageView.builder(
                            controller: controller,
                            scrollDirection: Axis.horizontal,
                            physics: NeverScrollableScrollPhysics(),
                            onPageChanged: (page) {
                              currentPage == page;
                            },
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              Timer.periodic(Duration(seconds: 10), (timer) {
                                if (currentPage < data.length - 1) {
                                  controller.nextPage(
                                      duration: Duration(milliseconds: 500),
                                      curve: Curves.ease);
                                  currentPage++;
                                  // scoreController.reinit();
                                } else {
                                  _timer?.cancel();
                                  Navigator.pop(context);
                                  /* Get.dialog(
                                    AlertDialog(
                                      title: Text('Fin des pages'),
                                      content: Text('Il n\'y a plus de page.'),
                                    ),
                                  ); */
                                }
                              });
                              return Center(
                                child: Container(
                                  width: screenWidth(context) * .9,
                                  height: screenHeight(context) * .7,
                                  margin: EdgeInsets.all(20),
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                      color: Colors.orange.withOpacity(.5),
                                      border: Border.all(
                                          width: 1, color: borderColor),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            data[index].categorie,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        data[index].question,
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      SizedBox(
                                        height: screenHeight(context) * .02,
                                      ),
                                      Text(
                                        'Réponse: ',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: screenWidth(context) * .8,
                                        height: screenHeight(context) * .3,
                                        child: FutureBuilder(
                                            future:
                                                fetchResponses(data[index].id),
                                            builder: (BuildContext context,
                                                AsyncSnapshot snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return TiLoading();
                                              } else if (snapshot.hasError) {
                                                return Center(
                                                  child: Text(
                                                    'Oups response part ${snapshot.error}',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                );
                                              } else {
                                                List<ResponseModel> response =
                                                    snapshot.data ?? [];
                                                if (response.length == 0) {
                                                  return Center(
                                                    child: Text(
                                                      'Aucune réponse ajoutée pour cette question',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  );
                                                }
                                                return ListView.builder(
                                                  itemCount: response.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return FluButton(
                                                        onPressed: () async {
                                                          if (response[index]
                                                                  .type ==
                                                              'bonne reponse') {
                                                            scoreController
                                                                .score += 5;
                                                            controller.nextPage(
                                                                duration:
                                                                    Duration(
                                                                        seconds:
                                                                            1),
                                                                curve: Curves
                                                                    .easeIn);
                                                            scoreController
                                                                .reinit();

                                                            if (controller
                                                                    .page ==
                                                                data.length -
                                                                    1) {
                                                              if (int.parse(
                                                                      highScore) >=
                                                                  scoreController
                                                                      .score
                                                                      .toInt()) {
                                                                Get.defaultDialog(
                                                                  title:
                                                                      "Fin de partie",
                                                                  middleText:
                                                                      "Votre score est de ${scoreController.score}.",
                                                                  actions: [
                                                                    ElevatedButton(
                                                                      onPressed:
                                                                          () {
                                                                        Get.offAll(() =>
                                                                            BottomNavBar());
                                                                      },
                                                                      child: Text(
                                                                          "OK"),
                                                                    ),
                                                                  ],
                                                                );
                                                              } else {
                                                                await setScore(
                                                                    scoreController
                                                                        .score);
                                                                Get.defaultDialog(
                                                                  title:
                                                                      "Meilleur score",
                                                                  middleText:
                                                                      "Votre score est de ${scoreController.score}.",
                                                                  actions: [
                                                                    ElevatedButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                        Get.offAll(() =>
                                                                            BottomNavBar());
                                                                      },
                                                                      child: Text(
                                                                          "OK"),
                                                                    ),
                                                                  ],
                                                                );
                                                              }
                                                            }
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    const SnackBar(
                                                              content: Text(
                                                                  'Bonne Réponse !'),
                                                              backgroundColor:
                                                                  Colors.green,
                                                            ));
                                                          } else {
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    const SnackBar(
                                                              content: Text(
                                                                  'Mauvaise réponse x'),
                                                              backgroundColor:
                                                                  Colors.red,
                                                            ));
                                                            scoreController
                                                                .reinit();

                                                            if (controller
                                                                    .page ==
                                                                data.length -
                                                                    1) {
                                                              if (int.parse(
                                                                      highScore) >=
                                                                  scoreController
                                                                      .score
                                                                      .toInt()) {
                                                                Get.defaultDialog(
                                                                  title:
                                                                      "Fin de partie",
                                                                  middleText:
                                                                      "Votre score est de ${scoreController.score}.",
                                                                  actions: [
                                                                    ElevatedButton(
                                                                      onPressed:
                                                                          () {
                                                                            Navigator.pop(
                                                                            context);
                                                                        Get.offAll(() =>
                                                                            BottomNavBar());
                                                                      },
                                                                      child: Text(
                                                                          "OK"),
                                                                    ),
                                                                  ],
                                                                );
                                                              } else {
                                                                setScore(
                                                                    scoreController
                                                                        .score);
                                                                Get.defaultDialog(
                                                                  title:
                                                                      "Meilleur score",
                                                                  middleText:
                                                                      "Votre score est de ${scoreController.score}.",
                                                                  actions: [
                                                                    ElevatedButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child: Text(
                                                                          "OK"),
                                                                    ),
                                                                  ],
                                                                );
                                                              }
                                                            }

                                                            controller.nextPage(
                                                                duration:
                                                                    Duration(
                                                                        seconds:
                                                                            1),
                                                                curve: Curves
                                                                    .easeIn);
                                                          }
                                                        },
                                                        child: Text(
                                                          response[index]
                                                              .reponse,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black),
                                                        ));
                                                  },
                                                );
                                              }
                                            }),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            });
                      }
                    },
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: new LinearProgressBar(
                    maxSteps: 10,
                    progressType: LinearProgressBar
                        .progressTypeLinear, // Use Linear progress
                    currentStep: 1,
                    progressColor: Colors.white,
                    backgroundColor: Colors.grey,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
