import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/event_controller.dart';
import 'events_created.dart';
import 'events_waiting.dart';
import 'events_participated.dart';

class EventMainPage extends StatelessWidget {
  EventMainPage({Key? key}) : super(key: key);

  final EventTabController myTabController = Get.put(EventTabController());
  final PageController pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    RxInt index = myTabController.controller.index.obs;
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        title: TabBar(
            indicator: BoxDecoration(
              // borderRadius: BorderRadius.circular(50),
              color: Colors.grey[600],
            ),
            onTap: (value) {
              myTabController.controller.index = value;
              pageController.animateToPage(value,
                  duration: Duration(milliseconds: 300), curve: Curves.ease);
            },
            controller: myTabController.controller,
            tabs: [
              Tab(
                child: Obx(
                  () => Text(
                    "Waiting",
                    style: index.value == 0
                        ? TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          )
                        : TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                  ),
                ),
              ),
              Tab(
                child: Obx(
                  () => Text(
                    "Participated",
                    style: index.value == 1
                        ? TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          )
                        : TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                  ),
                ),
              ),
              Tab(
                  child: Obx(
                () => Text(
                  "Created",
                  style: index.value == 2
                      ? TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        )
                      : TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                ),
              ))
            ]),
      ),
      body: Obx(
        () => PageView(
          controller: pageController,
          children: [
            EventsWaitingPage(),
            EventsParticipatedPage(),
            EventsCreatedPage(),
          ],
          onPageChanged: (value) {
            myTabController.controller.index = value;
            index.value = value;
          },
        ),
      ),
    );
  }
}
