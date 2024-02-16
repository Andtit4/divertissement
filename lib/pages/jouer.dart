import 'package:divertissement/pages/meilleur_score.dart';
import 'package:divertissement/pages/type_game.dart';
import 'package:divertissement/utils/constants.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JouerScreen extends StatefulWidget {
  const JouerScreen({super.key});

  @override
  State<JouerScreen> createState() => _JouerScreenState();
}

class _JouerScreenState extends State<JouerScreen> {
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
                left: 20,
                child: FluButton(
                    width: screenWidth(context) * .9,
                    height: screenHeight(context) * .065,
                    backgroundColor: Colors.amber,
                    onPressed: () {
                      Get.to(() => const TypeGame(),
                          transition: Transition.leftToRightWithFade,
                          duration: const Duration(seconds: 1));
                    },
                    child: Text(
                      'Jouer maintenant',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24),
                    )),
              ),
              Positioned(
                top: screenHeight(context) * .7,
                left: 20,
                child: FluButton(
                    width: screenWidth(context) * .9,
                    height: screenHeight(context) * .065,
                    backgroundColor: Colors.amber,
                    onPressed: () {
                      Get.to(() => const MeilleurScore(),
                          transition: Transition.leftToRightWithFade,
                          duration: const Duration(seconds: 1));
                    },
                    child: Text(
                      'Meilleur score',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
