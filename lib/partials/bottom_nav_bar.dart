import 'package:divertissement/pages/home.dart';
import 'package:divertissement/pages/meilleur_score.dart';
import 'package:divertissement/pages/settings.dart';
import 'package:divertissement/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  // ShapeBorder? bottomBarShape = const RoundedRectangleBorder(
  //   borderRadius: BorderRadius.all(Radius.circular(25)),
  // );

  SnakeBarBehaviour snakeBarStyle = SnakeBarBehaviour.pinned;
  EdgeInsets padding = const EdgeInsets.all(12);
  int _selectedItemPosition = 0;
  SnakeShape snakeShape = SnakeShape.circle;
  Color selectedColor = Colors.blue;
  Color unselectedColor = Colors.blueGrey;
  bool showSelectedLabels = false;
  bool showUnselectedLabels = false;

  int _index = 0;
  PageController _controller = PageController();
  late int currentpage = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: currentpage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _controller,
        onPageChanged: (index) {
          setState(() {
            currentpage = index;
          });
        },
        children: const [
          HomePage(),
          MeilleurScore(),
          SettingPage(),
        ],
      ),
      bottomNavigationBar: SnakeNavigationBar.color(
        backgroundColor: primaryColor,
        behaviour: snakeBarStyle,
        snakeShape: snakeShape,
        // shape: bottomBarShape,

        snakeViewColor: Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : Colors.black,
        selectedItemColor:
            snakeShape == SnakeShape.indicator ? selectedColor : null,
        unselectedItemColor: unselectedColor,
        showUnselectedLabels: showUnselectedLabels,
        showSelectedLabels: showSelectedLabels,
        currentIndex: _selectedItemPosition,
        onTap: (index) {
          // Vibration.vibrate(amplitude: 30, duration: 30);
          setState(() => _selectedItemPosition = index);
          setState(() => currentpage = index);
          _controller.animateToPage(currentpage,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOutQuad);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.score), label: 'Meilleur Scrore'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Activités'),
        ],
        selectedLabelStyle: const TextStyle(fontSize: 14),
        unselectedLabelStyle: const TextStyle(fontSize: 10),
      ),
    );
  }
}
