import 'package:divertissement/utils/constants.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MeilleurScore extends StatefulWidget {
  const MeilleurScore({super.key});

  @override
  State<MeilleurScore> createState() => _MeilleurScoreState();
}

class _MeilleurScoreState extends State<MeilleurScore> {
  String highScore = '';
  setScore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      highScore = prefs.getString('score').toString();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setScore();
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
              FluImage(
                'assets/sport.jpg',
                imageSource: ImageSources.asset,
              ),
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
              Positioned(
                  top: screenHeight(context) * .6,
                  left: screenWidth(context) * .3,
                  child: Text(
                    'Meilleur score',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24),
                  )),
              Positioned(
                  top: screenHeight(context) * .65,
                  left: screenWidth(context) * .45,
                  child: Text(
                    highScore.toString(),
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
