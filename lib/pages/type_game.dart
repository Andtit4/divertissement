import 'package:divertissement/partials/bottom_nav_bar.dart';
import 'package:divertissement/utils/constants.dart';
import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TypeGame extends StatefulWidget {
  const TypeGame({super.key});

  @override
  State<TypeGame> createState() => _TypeGameState();
}

class _TypeGameState extends State<TypeGame> {
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
                      Get.offAll(() => const BottomNavBar(),
                          transition: Transition.leftToRightWithFade,
                          duration: const Duration(seconds: 1));
                    },
                    child: Text(
                      'Jouer seul',
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
                    backgroundColor: Colors.grey,
                    onPressed: () {
                      Get.snackbar(
                          'Divertissement', 'Pas disponible pour le moment',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.amber);
                    },
                    child: Text(
                      'MultiJoueur',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
