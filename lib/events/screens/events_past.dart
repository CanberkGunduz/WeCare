import 'package:flutter/material.dart';
import 'package:gdsc_metu2023/events/controllers/event_controller.dart';
import 'package:gdsc_metu2023/events/screens/events_create.dart';
import 'package:gdsc_metu2023/events/tiles/event_tile.dart';
import 'package:get/get.dart';

import '../model/event_model.dart';
import 'events_details.dart';

class EventsPastPage extends StatelessWidget {
  EventsPastPage({super.key});

  EventController eventController = Get.put(EventController());

  @override
  Widget build(BuildContext context) {
    final events_past = eventController.eventList[1];
    return GestureDetector(
      child: Stack(
        children: [
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 25,
                    ),
                    Text(
                      "Past",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                // SizedBox(height: 10,),
                ListView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: events_past.length,
                  itemBuilder: (context, index) {
                    final event = events_past[index];
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
    );
  }
}
