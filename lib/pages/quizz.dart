import 'dart:async';
import 'dart:convert';
import 'package:divertissement/model/question_model.dart';
import 'package:divertissement/model/response_model.dart';
import 'package:divertissement/partials/bottom_nav_bar.dart';
import 'package:divertissement/partials/seconds.dart';
import 'package:divertissement/services/local.dart';
import 'package:divertissement/services/plug.dart';
import 'package:divertissement/services/score_controller.dart';
import 'package:get/get.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:divertissement/partials/loading.dart';
import 'package:divertissement/utils/constants.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Quizz extends StatefulWidget {
  final String link;
  const Quizz({super.key, required this.link});

  @override
  State<Quizz> createState() => _QuizzState();
}

class _QuizzState extends State<Quizz> {
  // final ScoreController scoreController = Get.put(ScoreController());
  final scoreController = Get.find<ScoreController>();

  List<dynamic>? questions;
  Color borderColor = Colors.transparent;
  Color colorResponse = Colors.red;
  bool pressed = false;
  PageController controller = PageController();
  int currentPage = 1;
  String highScore = '';
  // late Timer _timer;
  int _seconds = 0;
  late Duration timer = Duration(seconds: 10);
  late bool show = false;

  setScore(RxInt score) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('score', score.value);
  }

  getScore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      highScore = prefs.getInt('score').toString();
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
        link('reponse/search?id_question=$id_question', '');
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

  reinitSecond() {
    timer = Timer.periodic(Duration(seconds: 10), (timer) {
      scoreController.reinit();
    }) as Duration;
  }

  @override
  void initState() {
    super.initState();
    fetchCinemaData();
    getScore();

    Future.delayed(Duration.zero).then((value) {
      Provider.of(context, listen: false).callMethod();
    });
    // _startTimer();
    // scoreController.increment();
    // reinitSecond();
  }

  @override
  void dispose() {
    // _timer.cancel();
    // timer.d();
    controller.dispose();
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
                          SecondsDisplay()
                        ],
                      ),
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

                        return GetBuilder<ScoreController>(
                          builder: (controller) {
                            return PageView.builder(
                                controller: controller.pageController,
                                scrollDirection: Axis.horizontal,
                                physics: NeverScrollableScrollPhysics(),
                                onPageChanged: (page) {
                                  scoreController.currentPageIndex == page;
                                },
                                itemCount: data.length,
                                itemBuilder: (context, index) {
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
                                          borderRadius:
                                              BorderRadius.circular(15)),
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
                                                future: fetchResponses(
                                                    data[index].id),
                                                builder: (BuildContext context,
                                                    AsyncSnapshot snapshot) {
                                                  if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.waiting) {
                                                    return TiLoading();
                                                  } else if (snapshot
                                                      .hasError) {
                                                    return Center(
                                                      child: Text(
                                                        'Oups response part ${snapshot.error}',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    );
                                                  } else {
                                                    List<ResponseModel>
                                                        response =
                                                        snapshot.data ?? [];
                                                    if (response.length == 0) {
                                                      return Center(
                                                        child: Text(
                                                          'Aucune réponse ajoutée pour cette question',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      );
                                                    } else {
                                                      scoreController
                                                          .increment();
                                                      Timer.periodic(
                                                          Duration(seconds: 10),
                                                          (timer) {
                                                        setState(() {
                                                          show = true;
                                                        });
                                                      });

                                                      // reinitSecond();
                                                      /* Timer.periodic(
                                                        Duration(seconds: 9),
                                                        (timer) {
                                                      setState(() {
                                                        currentPage++;
                                                      });
                                                    }); */

                                                      /* Timer.periodic(
                                                        Duration(seconds: 10),
                                                        (timer) {
                                                      // scoreController.restartSecond();
                                                      if (currentPage <
                                                          data.length) {
                                                        controller.nextPage(
                                                            duration: Duration(
                                                                milliseconds:
                                                                    200),
                                                            curve:
                                                                Curves.easeInOut);
                                                      } else {
                                                        controller.dispose();
                                                      }
                                                    }); */

                                                      /* Timer.periodic(
                                                        Duration(seconds: 10),
                                                        (timer) {
                                                      scoreController.increment();
                          
                                                      if (scoreController
                                                              .seconds.value ==
                                                          9) {
                                                        print('\n\n change ');
                                                      }
                                                    }); */
                                                      /* Timer.periodic(
                                                        Duration(seconds: 10),
                                                        (timer) async {
                                                      if (currentPage <
                                                          data.length - 1) {
                                                        controller.nextPage(
                                                            duration: Duration(
                                                                milliseconds:
                                                                    500),
                                                            curve: Curves.ease);
                                                        currentPage++;
                          
                                                        // reinitSecond();
                          
                                                        // scoreController.reinit();
                                                      } else if (currentPage ==
                                                          data.length - 1) {
                                                        /* _timer?.cancel();
                                    Navigator.pop(context); */
                                                        /* if (int.parse(
                                                                highScore) >=
                                                            scoreController.score
                                                                .toInt()) {
                                                          Get.defaultDialog(
                                                            title:
                                                                "Fin de partie",
                                                            middleText:
                                                                "Votre score est de ${scoreController.score}.",
                                                            actions: [
                                                              ElevatedButton(
                                                                onPressed: () {
                                                                  Get.back();
                                                                  Get.offAll(() =>
                                                                      BottomNavBar());
                                                                },
                                                                child: Text("OK"),
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
                                                                onPressed: () {
                                                                  Get.back();
                                                                  Get.offAll(() =>
                                                                      BottomNavBar());
                                                                },
                                                                child: Text("OK"),
                                                              ),
                                                            ],
                                                          );
                                                        } */
                                                      }
                                                    }); */
                                                    }

                                                    return ListView.builder(
                                                      itemCount:
                                                          response.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return FluButton(
                                                            backgroundColor: show ==
                                                                    true
                                                                ? response[index]
                                                                            .type ==
                                                                        'bonne reponse'
                                                                    ? Colors
                                                                        .green
                                                                    : Colors.red
                                                                : Colors.white,
                                                            onPressed:
                                                                () async {
                                                              if (response[
                                                                          index]
                                                                      .type ==
                                                                  'bonne reponse') {
                                                                scoreController
                                                                    .score += 5;
                                                                controller.pageController.nextPage(
                                                                    duration: Duration(
                                                                        seconds:
                                                                            1),
                                                                    curve: Curves
                                                                        .easeIn);
                                                                scoreController
                                                                    .reinit();

                                                                if (controller.pageController
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
                                                                          child:
                                                                              Text("OK"),
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
                                                                            Navigator.pop(context);
                                                                            Get.offAll(() =>
                                                                                BottomNavBar());
                                                                          },
                                                                          child:
                                                                              Text("OK"),
                                                                        ),
                                                                      ],
                                                                    );
                                                                  }
                                                                }
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                        const SnackBar(
                                                                  content: Text(
                                                                      'Bonne Réponse !'),
                                                                  backgroundColor:
                                                                      Colors
                                                                          .green,
                                                                ));
                                                              } else {
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                        const SnackBar(
                                                                  content: Text(
                                                                      'Mauvaise réponse x'),
                                                                  backgroundColor:
                                                                      Colors
                                                                          .red,
                                                                ));
                                                                scoreController
                                                                    .reinit();

                                                                if (controller.pageController
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
                                                                            Navigator.pop(context);
                                                                            Get.offAll(() =>
                                                                                BottomNavBar());
                                                                          },
                                                                          child:
                                                                              Text("OK"),
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
                                                                            Navigator.pop(context);
                                                                          },
                                                                          child:
                                                                              Text("OK"),
                                                                        ),
                                                                      ],
                                                                    );
                                                                  }
                                                                }

                                                                controller.pageController.nextPage(
                                                                    duration: Duration(
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
                                                                  color: Colors
                                                                      .black),
                                                            ));
                                                      },
                                                    );
                                                  }
                                                }),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              show == true
                                                  ? FluButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          show = false;
                                                          currentPage++;
                                                          controller.pageController.animateToPage(
                                                              currentPage,
                                                              duration: Duration(
                                                                  milliseconds:
                                                                      200),
                                                              curve: Curves
                                                                  .easeInOut);
                                                        });
                                                        /* controller.nextPage(
                                                          duration: Duration(
                                                              milliseconds: 200),
                                                          curve:
                                                              Curves.easeInOut); */
                                                        /* scoreController
                                                          .unShowResponse();
                                                      scoreController.reinit();
                                                      scoreController.increment(); */
                                                      },
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      margin: EdgeInsets.only(
                                                          bottom: 20),
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                              'Question Suivante'),
                                                          FluIcon(FluIcons
                                                              .arrowRight),
                                                        ],
                                                      ))
                                                  : SizedBox()
                                              /*  Obx(() => scoreController.show == true
                                                ? FluButton(
                                                    onPressed: () {
                                                      controller.nextPage(
                                                          duration: Duration(
                                                              milliseconds: 200),
                                                          curve:
                                                              Curves.easeInOut);
                                                      scoreController
                                                          .unShowResponse();
                                                      scoreController.reinit();
                                                      scoreController.increment();
                                                    },
                                                    padding: EdgeInsets.all(10),
                                                    margin: EdgeInsets.only(
                                                        bottom: 20),
                                                    child: Row(
                                                      children: [
                                                        Text('Question Suivante'),
                                                        FluIcon(
                                                            FluIcons.arrowRight),
                                                      ],
                                                    ))
                                                : SizedBox()), */
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          },
                        );
                      }
                    },
                  ),
                ),
              ),
              /* Positioned(
                  bottom: screenHeight(context) * .1,
                  left: 10,
                  child: Obx(() =>
                      FluButton(onPressed: () {}, child: Text('Suivant')))), */
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
