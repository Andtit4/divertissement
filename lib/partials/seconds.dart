import 'package:divertissement/services/score_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SecondsDisplay extends StatefulWidget {
  const SecondsDisplay({super.key});

  @override
  State<SecondsDisplay> createState() => _SecondsDisplayState();
}

class _SecondsDisplayState extends State<SecondsDisplay> {
  ScoreController scoreController = Get.put(ScoreController());
  @override
  Widget build(BuildContext context) {
    return Obx(() => Text('Score: ${scoreController.score} points',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)));
  }
}
