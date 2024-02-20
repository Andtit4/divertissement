import 'dart:async';

import 'package:get/get.dart';

class ScoreController extends GetxController {
  var score = 0.obs;
  var seconds = 0.obs;
  late Timer timer;
  void increment() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      seconds++;
    });

    if (seconds.value == 11) {
      reinit();
    }
  }

  void reinit() {
    seconds.value = 0;
  }

  @override
  void onClose() {
    timer.cancel();
    super.onClose();
  }
}
