import 'dart:convert';
import 'package:divertissement/model/question_model.dart';
import 'package:divertissement/model/response_model.dart';
import 'package:divertissement/services/local.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:divertissement/partials/loading.dart';
import 'package:divertissement/utils/constants.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Quizz extends StatefulWidget {
  final String link;
  const Quizz({super.key, required this.link});

  @override
  State<Quizz> createState() => _QuizzState();
}

class _QuizzState extends State<Quizz> {
  List<dynamic>? questions;
  Color borderColor = Colors.transparent;
  Color colorResponse = Colors.red;
  bool pressed = false;
  PageController controller = PageController();
  int currentPage = 1;

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

  fechResponses(id_question) async {
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
            // crossAxisAlignment: CrossAxisAlignment.start,
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
                child: FluButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    backgroundColor: Colors.transparent,
                    child: FluIcon(
                      FluIcons.closeCircle,
                      color: Colors.white,
                      style: FluIconStyles.bulk,
                    )),
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
                                            'True / False',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12),
                                          ),
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
                                      pressed == true
                                          ? Container(
                                              width: double.infinity,
                                              height:
                                                  screenHeight(context) * .08,
                                              decoration: BoxDecoration(
                                                  color: colorResponse),
                                            )
                                          : Spacer(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          FluButton(
                                            onPressed: () {
                                              /* if (questions?[index]
                                                      ['correct_answer'] ==
                                                  'True') {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                        const SnackBar(
                                                  content:
                                                      Text('Bonne Réponse !'),
                                                  backgroundColor: Colors.green,
                                                ));
                                                controller.nextPage(
                                                    duration:
                                                        Duration(seconds: 4),
                                                    curve: Curves.bounceIn);
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                        const SnackBar(
                                                  content:
                                                      Text('Mauvaise réponse'),
                                                  backgroundColor: Colors.red,
                                                ));
                                                controller.nextPage(
                                                    duration:
                                                        Duration(seconds: 4),
                                                    curve: Curves.bounceIn);
                                              } */

                                              // if (questions?[index]
                                              //         ['correct_answer'] ==
                                              //     'True') {
                                              //   setState(() {
                                              //     borderColor == Colors.green;
                                              //   });
                                              // } else {
                                              //   setState(() {
                                              //     borderColor == Colors.red;
                                              //   });
                                              // }
                                            },
                                            backgroundColor: Colors.green,
                                            child: Text(
                                              'True',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14),
                                            ),
                                          ),
                                          FluButton(
                                            onPressed: () {
                                              if (questions?[index]
                                                      ['correct_answer'] ==
                                                  'False') {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                        const SnackBar(
                                                  content:
                                                      Text('Bonne Réponse !'),
                                                  backgroundColor: Colors.green,
                                                ));
                                                controller.nextPage(
                                                    duration:
                                                        Duration(seconds: 4),
                                                    curve: Curves.bounceIn);
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                        const SnackBar(
                                                  content:
                                                      Text('Mauvaise réponse'),
                                                  backgroundColor: Colors.red,
                                                ));
                                                controller.nextPage(
                                                    duration:
                                                        Duration(seconds: 4),
                                                    curve: Curves.easeIn);
                                              }
                                            },
                                            backgroundColor: Colors.red,
                                            child: Text(
                                              'False',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14),
                                            ),
                                          ),
                                        ],
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
