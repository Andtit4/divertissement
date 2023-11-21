import 'dart:convert';

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

  Future<void> fetchCinemaData() async {
    final response = await http.get(Uri.parse(widget.link));

    if (response.statusCode == 200) {
      Map<String, dynamic> cinemaData = json.decode(response.body);
      questions = cinemaData['results'];
    } else {
      throw Exception('Erreur de chargement des données de la question');
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
      backgroundColor: primaryColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: screenHeight * .04,
            ),
            SizedBox(
              width: screenWidth,
              height: screenHeight * .7,
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
                        'An error occured ${snapshot.error}',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  } else {
                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: questions?.length ?? 0,
                        itemBuilder: (context, index) {
                          return Center(
                            child: Container(
                              width: screenWidth * .9,
                              height: screenHeight * .7,
                              margin: EdgeInsets.all(20),
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  color: btnColor.withOpacity(.5),
                                  border:
                                      Border.all(width: 1, color: borderColor),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'True / False',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      ),
                                      Text(
                                        questions?[index]['difficulty'] ?? '',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    questions?[index]['question'] ?? '',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  pressed == true
                                      ? Container(
                                          width: double.infinity,
                                          height: screenHeight * .08,
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
                                      

                                          if (questions?[index]
                                                  ['correct_answer'] ==
                                              'True') {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                              content: Text('Bonne Réponse !'),
                                              backgroundColor: Colors.green,
                                            ));
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                              content: Text(
                                                  'Mauvaise réponse'),
                                              backgroundColor: Colors.red,
                                            ));
                                          }

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
                                                .showSnackBar(const SnackBar(
                                              content: Text('Bonne Réponse !'),
                                              backgroundColor: Colors.green,
                                            ));
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                              content: Text(
                                                  'Mauvaise réponse'),
                                              backgroundColor: Colors.red,
                                            ));
                                          }
                                          // if (questions?[index]
                                          //         ['correct_answer'] ==
                                          //     'False') {
                                          //   setState(() {
                                          //     borderColor == Colors.green;
                                          //   });
                                          // } else {
                                          //   setState(() {
                                          //     borderColor == Colors.red;
                                          //   });
                                          // }
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
            )
          ],
        ),
      ),
    );
  }
}
