import 'package:flutter/material.dart';
import 'package:gdsc_metu2023/events/controllers/event_controller.dart';
import 'package:gdsc_metu2023/events/screens/events_create.dart';
import 'package:gdsc_metu2023/events/tiles/event_tile.dart';
import 'package:get/get.dart';

import '../model/event_model.dart';
import 'events_details.dart';

class EventsParticipatedPage extends StatelessWidget {
  EventsParticipatedPage({super.key});

  EventController eventController = Get.put(EventController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Obx(
        () => Stack(
          children: [
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  // Row(
                  //   children: [
                  //     SizedBox(
                  //       width: 25,
                  //     ),
                  //     Text(
                  //       "Upcoming",
                  //       style: TextStyle(
                  //           fontSize: 18, fontWeight: FontWeight.w500),
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(height: 10,),
                  ListView.builder(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: eventController.eventList[0].length,
                    itemBuilder: (context, index) {
                      final event = eventController.eventList[0][index];
                      return InkWell(
                          onTap: () =>
                              Get.to(() => EventsDetailsPage(event: event)),
                          child: EventTile(
                            event: event,
                          ));
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
