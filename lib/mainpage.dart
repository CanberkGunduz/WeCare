import 'package:flutter/material.dart';
import 'package:gdsc_metu2023/events/screens/events_feed.dart';
import 'package:get/get.dart';
import 'calendar/screens/calendarpage.dart';
import 'events/screens/events_main.dart';
import 'home/screens/homepage.dart';

class MainPage extends StatelessWidget {
  MainPage({Key? key}) : super(key: key);
  RxInt _currentIndex = 0.obs;

  final pages = [Homepage(), EventFeed(), EventMainPage()];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: pages[_currentIndex.value],
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            onTap: (value) {
              _currentIndex.value = value;
            },
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Events',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.people),
                label: 'Community',
              ),
            ],
            currentIndex: _currentIndex.value,
            selectedItemColor: Colors.amber[800],
          ),
        ),
      ),
    );
  }
}
