import 'package:divertissement/services/score_controller.dart';
import 'package:get/get.dart';

class SecondBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ScoreController()); // Enregistrement du contrôleur du chronomètre
  }
}