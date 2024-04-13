import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class ScoreController extends GetxController {
  var score = 0.obs;
  var seconds = 0.obs;
  late Timer timer;
  RxInt currentPageIndex = 0.obs;
  RxBool pageIsChange = false.obs;
  RxBool show = false.obs;

// New
  late PageController _pageController;
  int _currentPage = 0;
  int _timerValue = 0;
  Timer? _timer;

  PageController get pageController => _pageController;
  int get currentPage => _currentPage;
  int get timerValue => _timerValue;

  @override
  void onInit() {
    _pageController = PageController(initialPage: 0);
    _startTimer();
    super.onInit();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _timerValue++;
      if (_timerValue % 10 == 0) {
        _currentPage = (_currentPage + 1) % 6;
        _timerValue = 0;
        /* _pageController.animateToPage(_currentPage,
            duration: Duration(milliseconds: 300), curve: Curves.easeInOut); */
        update();
      }
    });
  }

  @override
  void onClose() {
    _timer?.cancel();
    _pageController.dispose();
    super.onClose();
  }

  // PageController controller = PageController();

  void showResponse() {
    show.value = true;
  }

  void unShowResponse() {
    show.value = false;
  }

  void incrementPageindex() {
    currentPageIndex.value++;
  }

  void increment() async {
    if (seconds.value > 0) {
      seconds.value = 0;
    } else {
      timer = Timer.periodic(Duration(seconds: 1), (timer) async {
        seconds.value++;
        // print(seconds.value);
        if (seconds.value == 10) {
          timer.cancel();
        }
      });
    }

    /* if (seconds == 11) {
      print('\n\nReinit second');
      reinit();
    } */
  }

/*   Future<void> ChangePage() async {
    seconds.value = 0;

    if (pageIsChange.value == true) {
      print('object');
      currentPageIndex.value++;
      controller.animateToPage(currentPageIndex.value,
          duration: Duration(seconds: 1), curve: Curves.ease);
      pageIsChange.value = false;
    }
  } */

  void restartSecond() {
    print('restart init');
    print('1');
    reinit();
    print('2');
    increment();
    print('exit');
  }

  void reinit() {
    print('\n\n Reinit second');
    seconds.value = 0;
    print('\n\n Restart increment ${seconds.value}');
  }
}
