import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'calendarpage.dart';
import 'events/screens/events_main.dart';
import 'home/screens/homepage.dart';

class MainPage extends StatelessWidget {
  MainPage({Key? key}) : super(key: key);
  RxInt _currentIndex = 0.obs;

  final pages = [Homepage(), CalendarPage(), EventMainPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => pages[_currentIndex.value]),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          onTap: (value) => _currentIndex.value = value,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month),
              label: 'Calendar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: _currentIndex.value,
          selectedItemColor: Colors.amber[800],
        ),
      ),
    );
  }
}
