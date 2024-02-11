import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:divertissement/pages/quizz.dart';
import 'package:divertissement/partials/image.dart';
import 'package:divertissement/partials/loading.dart';
import 'package:divertissement/services/getCategories.dart';
import 'package:divertissement/services/local.dart';
import 'package:divertissement/services/sound.dart';
import 'package:divertissement/utils/constants.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String nom = '';
  late String prenom = '';
  late String pseudo = '';
  List<dynamic>? categories;

  getInfos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      pseudo = prefs.getString('pseudo')!;
      nom = prefs.getString('nom')!;
      prenom = prefs.getString('prenom')!;
    });

    // print(pseudo);
  }

  Future<void> fetchCinemaData() async {
    final response =
        await http.get(Uri.parse('https://opentdb.com/api_category.php'));

    if (response.statusCode == 200) {
      Map<String, dynamic> cinemaData = json.decode(response.body);
      categories = cinemaData['trivia_categories'];
    } else {
      throw Exception('Erreur de chargement des données de cinéma');
    }
  }

  @override
  void initState() {
    super.initState();
    getInfos();
    fetchCinemaData();
    jouerSon();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: screenWidth(context),
          height: screenHeight(context),
          child: Stack(
            fit: StackFit.expand,
            children: [
              SizedBox(
                  width: screenWidth(context),
                  height: screenHeight(context),
                  child: FluImage(
                    'assets/cinema.jpg',
                    imageSource: ImageSources.asset,
                  )),
              Positioned(
                  top: 0,
                  child: SizedBox(
                    width: screenWidth(context),
                    height: screenHeight(context) * .4,
                    child: FluImage(
                      'assets/logo.jpg',
                      imageSource: ImageSources.asset,
                    ),
                  )),
              SizedBox(
                height: screenHeight(context) * .03,
              ),

              Positioned(
                  top: screenHeight(context) * .55,
                  left: screenWidth(context) * .25,
                  child: SizedBox(
                    width: screenWidth(context),
                    height: screenHeight(context) * .35,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            /* Get.to(
                                () => Quizz(
                                    link:
                                        "https://opentdb.com/api.php?amount=10&category=11&type=boolean"),
                                transition: Transition.rightToLeft,
                                duration: Duration(seconds: 2)); */
                                Get.to(
                                () => Quizz(
                                    link: link('getQuestionByCategory.php?categorie=CINEMA', '')
                                        /* "http://192.168.100.156/quizz/api/getQuestionByCategory.php?categorie=SPORT" */),
                                transition: Transition.rightToLeft,
                                duration: Duration(seconds: 2));
                          },
                          child: Container(
                            width: screenWidth(context) * .5,
                            height: screenHeight(context) * .08,
                            margin: EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            child: Center(
                              child: Text(
                                'CINEMA',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(
                                () => Quizz(
                                    link: link('getQuestionByCategory.php?categorie=MUSIQUE', '')
                                        /* "http://192.168.100.156/quizz/api/getQuestionByCategory.php?categorie=SPORT" */),
                                transition: Transition.rightToLeft,
                                duration: Duration(seconds: 2));
                          },
                          child: Container(
                            width: screenWidth(context) * .5,
                            height: screenHeight(context) * .08,
                            margin: EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            child: Center(
                              child: Text(
                                'MUSIQUE',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                          
                            Get.to(
                                () => Quizz(
                                    link: link('getQuestionByCategory.php?categorie=SPORT', '')
                                        /* "http://192.168.100.156/quizz/api/getQuestionByCategory.php?categorie=SPORT" */),
                                transition: Transition.rightToLeft,
                                duration: Duration(seconds: 2));
                          },
                          child: Container(
                            width: screenWidth(context) * .5,
                            height: screenHeight(context) * .08,
                            margin: EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            child: Center(
                              child: Text(
                                'SPORT',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ))
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Row(
              //       children: [
              //         const FluAvatar(
              //           defaultAvatarType: FluAvatarTypes.memojis,
              //         ),
              //         const SizedBox(
              //           width: 10,
              //         ),
              //         Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Text(
              //               '$nom $prenom',
              //               style: const TextStyle(
              //                   color: Colors.white,
              //                   fontWeight: FontWeight.w700),
              //             ),
              //             Text(
              //               '$pseudo',
              //               style: const TextStyle(
              //                 fontSize: 10,
              //                 color: Color.fromARGB(95, 255, 255, 255),
              //               ),
              //             )
              //           ],
              //         ),
              //       ],
              //     ),
              //     // FluButton.icon(
              //     //   FluIcons.musicCircle,
              //     //   onPressed: () {
              //     //     print("objec");
              //     //     final player = AudioPlayer();
              //     //     player.pause();
              //     //     // stopAudio();
              //     //   },
              //     //   size: 50,
              //     // )
              //   ],
              // ),
              // const SizedBox(
              //   height: 10,
              // ),
              // // Container(
              // //   width: double.infinity,
              // //   height: screenHeight(context) * .25,
              // //   padding: const EdgeInsets.all(15),
              // //   decoration: BoxDecoration(
              // //       color: Colors.black,
              // //       borderRadius: BorderRadius.circular(25)),
              // //   child: Row(children: [
              // //     SizedBox(
              // //       width: screenWidth(context) * .5,
              // //       child: const Text(
              // //         'Play & Win\n Lorem ipsum dolor emet iset astdrea dkyes',
              // //         style: TextStyle(
              // //           fontSize: 10,
              // //           color: Color.fromARGB(95, 255, 255, 255),
              // //         ),
              // //       ),
              // //     ),
              // //     FluImage(

              // //             'https://cdn-icons-png.flaticon.com/512/4752/4752630.png'),
              // //   ]),
              // // ),
              // const SizedBox(
              //   height: 20,
              // ),
              // // const Row(
              // //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // //   children: [
              // //     Text(
              // //       'Categories',
              // //       style: TextStyle(
              // //           color: Colors.white, fontWeight: FontWeight.w700),
              // //     ),
              // //     FluIcon(
              // //       FluIcons.arrowRight,
              // //       style: FluIconStyles.bulk,
              // //       color: Colors.white,
              // //     )
              // //   ],
              // // ),
              // const SizedBox(
              //   height: 10,
              // ),
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     GestureDetector(
              //       onTap: () {
              //         Get.to(
              //             () => Quizz(
              //                 link:
              //                     "https://opentdb.com/api.php?amount=10&category=11&type=boolean"),
              //             transition: Transition.rightToLeft,
              //             duration: Duration(seconds: 2));
              //       },
              //       child: Container(
              //         width: double.infinity,
              //         height: screenHeight(context) * .2,
              //         margin: EdgeInsets.only(bottom: 10),
              //         decoration: BoxDecoration(
              //             color: btnColor,
              //             borderRadius: BorderRadius.all(Radius.circular(15))),
              //         child: Center(
              //           child: Row(
              //             children: [
              //               SizedBox(
              //                 width: screenWidth(context) * .2,
              //               ),
              //               Padding(
              //                 padding: const EdgeInsets.all(35.0),
              //                 child: FluImage(
              //                     'https://archive.org/download/cinema-hd-logo_202103/cinema%20hd%20logo.png'),
              //               ),
              //               Text(
              //                 'CINEMA',
              //                 style: TextStyle(
              //                     color: Colors.white,
              //                     fontWeight: FontWeight.w700),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //     ),
              //     GestureDetector(
              //       onTap: () {
              //         Get.to(
              //             () => Quizz(
              //                 link:
              //                     "https://opentdb.com/api.php?amount=10&category=12&type=boolean"),
              //             transition: Transition.rightToLeft,
              //             duration: Duration(seconds: 2));
              //       },
              //       child: Container(
              //         width: double.infinity,
              //         height: screenHeight(context) * .2,
              //         margin: EdgeInsets.only(bottom: 10),
              //         decoration: BoxDecoration(
              //             color: btnColor,
              //             borderRadius: BorderRadius.all(Radius.circular(15))),
              //         child: Center(
              //           child: Row(
              //             children: [
              //               SizedBox(
              //                 width: screenWidth(context) * .2,
              //               ),
              //               Padding(
              //                 padding: const EdgeInsets.all(35.0),
              //                 child: FluImage(
              //                     'https://cdn.icon-icons.com/icons2/2201/PNG/512/apple_music_logo_square_icon_134020.png'),
              //               ),
              //               Text(
              //                 'MUSIQUE',
              //                 style: TextStyle(
              //                     color: Colors.white,
              //                     fontWeight: FontWeight.w700),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //     ),
              //     GestureDetector(
              //       onTap: () {
              //         Get.to(
              //             () => Quizz(
              //                 link:
              //                     "https://opentdb.com/api.php?amount=10&category=21&type=boolean"),
              //             transition: Transition.rightToLeft,
              //             duration: Duration(seconds: 2));
              //       },
              //       child: Container(
              //         width: double.infinity,
              //         height: screenHeight(context) * .2,
              //         margin: EdgeInsets.only(bottom: 10),
              //         decoration: BoxDecoration(
              //             color: btnColor,
              //             borderRadius: BorderRadius.all(Radius.circular(15))),
              //         child: Center(
              //           child: Row(
              //             children: [
              //               SizedBox(
              //                 width: screenWidth(context) * .2,
              //               ),
              //               Padding(
              //                 padding: const EdgeInsets.all(35.0),
              //                 child: FluImage(
              //                     'https://static.vecteezy.com/system/resources/previews/013/923/534/non_2x/sports-black-car-logo-png.png'),
              //               ),
              //               Text(
              //                 'SPORT',
              //                 style: TextStyle(
              //                     color: Colors.white,
              //                     fontWeight: FontWeight.w700),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //     ),
              //   ],
              // )
              // SizedBox(
              //   width: screenWidth(context),
              //   height: screenHeight(context) * .5,
              //   child: FutureBuilder(
              //     future: fetchCinemaData(),
              //     builder: (BuildContext context, AsyncSnapshot snapshot) {
              //       if (snapshot.connectionState == ConnectionState.waiting) {
              //         return Center(
              //           child: TiLoading(),
              //         );
              //       } else if (snapshot.hasError) {
              //         return Center(
              //           child: Text('An error occued ${snapshot.error}'),
              //         );
              //       } else {
              //         return ListView.builder(
              //           itemCount: categories?.length ?? 0,
              //           itemBuilder: (context, index) {
              //             return FluButton(
              //               onPressed: () {
              //                 Get.to(
              //                     () => Quizz(
              //                         link:
              //                             "https://opentdb.com/api.php?amount=10&category=${categories?[index]['id']}&type=boolean"),
              //                     transition: Transition.rightToLeft,
              //                     duration: Duration(seconds: 2));
              //               },
              //               backgroundColor: Colors.transparent,
              //               child: Container(
              //                 width: double.infinity,
              //                 height: screenHeight(context) * .08,
              //                 margin: EdgeInsets.only(bottom: 10),
              //                 decoration: BoxDecoration(
              //                     color: btnColor,
              //                     borderRadius:
              //                         BorderRadius.all(Radius.circular(15))),
              //                 child: Row(
              //                   mainAxisAlignment: MainAxisAlignment.center,
              //                   children: [
              //                     Text(
              //                       categories?[index]['name'] ?? '',
              //                       style: TextStyle(
              //                           color: Colors.white,
              //                           fontSize: 10,
              //                           fontWeight: FontWeight.w700),
              //                     ),
              //                     FluIcon(
              //                       FluIcons.arrowRight,
              //                       style: FluIconStyles.bulk,
              //                       color: Colors.white,
              //                     )
              //                   ],
              //                 ),
              //               ),
              //             );
              //           },
              //         );
              //       }
              //     },
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
