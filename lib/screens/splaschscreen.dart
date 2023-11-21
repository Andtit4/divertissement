import 'dart:async';

import 'package:divertissement/pages/register.dart';
import 'package:divertissement/partials/loading.dart';
import 'package:divertissement/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4), () {
      Get.offAll(() => const RegisterPage(),
          transition: Transition.leftToRightWithFade,
          duration: const Duration(seconds: 1));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        children: [
          const Spacer(),
          Center(
            child: Hero(
              tag: '_title',
              child: Text(
                appName,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 10,),
         const TiLoading(),
          // Spacer(),
          SizedBox(height: screenHeight * .06,)
        ],
      ),
    );
  }
}