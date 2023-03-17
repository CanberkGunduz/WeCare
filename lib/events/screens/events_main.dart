import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/event_controller.dart';
import 'events_created.dart';
import 'events_past.dart';
import 'events_upcoming.dart';

class EventMainPage extends StatelessWidget {
  EventMainPage({Key? key}) : super(key: key);

  final EventTabController myTabController = Get.put(EventTabController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        title: TabBar(
          controller: myTabController.controller,
          tabs: [
          Tab(
            child: Text(
              "Past",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
          Tab(
            child: Text(
              "Upcoming",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ),
          Tab(
            child: Text(
              "Created",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          )
        ]),
      ),
      body: TabBarView(
        controller: myTabController.controller,
        children: [
          EventsPastPage(),
          EventsUpcomingPage(),
          EventsCreatedPage(),
        ],
      ),
    );
  }
}
