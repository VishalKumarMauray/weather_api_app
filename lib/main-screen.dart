import 'package:flutter/material.dart';
import 'package:weather_api/constant.dart';
import 'package:weather_api/home.screen.dart';
import 'package:weather_api/search-screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int navIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      HomeScreen(),
      SearchScreen(),
      const CircularProgressIndicator(),
    ];
    return SafeArea(
      child: Scaffold(
        body: screens.elementAt(navIndex),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: navIndex,
          backgroundColor: darkBlue,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: pink,
          unselectedItemColor: grey,
          onTap: (value) {
            setState(() {
              navIndex = value;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_rounded,
                size: 32,
              ),
              label: 'home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.search_rounded,
                size: 32,
              ),
              label: 'search',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.settings_rounded,
                size: 32,
              ),
              label: 'setting',
            ),
          ],
        ),
      ),
    );
  }
}
