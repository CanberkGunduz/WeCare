import 'package:flutter/material.dart';
import 'package:gdsc_metu2023/events/controllers/event_controller.dart';
import 'package:gdsc_metu2023/events/screens/events_create.dart';
import 'package:gdsc_metu2023/events/tiles/event_tile.dart';
import 'package:get/get.dart';

import '../model/event_model.dart';
import 'events_details.dart';

class EventsCreatedPage extends StatelessWidget {
  EventsCreatedPage({super.key});

  EventController eventController = Get.put(EventController());

  @override
  Widget build(BuildContext context) {
    final events_upcoming = eventController.eventList[0];
    final events_previous = eventController.eventList[1];
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
                      "Upcoming",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                // SizedBox(height: 10,),
                ListView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: events_upcoming.length,
                  itemBuilder: (context, index) {
                    final event = events_upcoming[index];
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
                Row(
                  children: [
                    SizedBox(
                      width: 25,
                    ),
                    Text(
                      "Previous",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                // SizedBox(height: 10,),
                ListView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: events_previous.length,
                  itemBuilder: (context, index) {
                    final event = events_previous[index];
                    return InkWell(
                        onTap: () =>
                            Get.to(() => EventsDetailsPage(event: event)),
                        child: EventTile(
                          event: event,
                        ));
                  },
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
                backgroundColor: Colors.white,
                foregroundColor: Colors.orange,
                child: Icon(
                  Icons.add,
                  size: 36,
                ),
                onPressed: () => Get.to(() => EventCreateScreen())),
          ),
        ],
      ),
    );
  }
}
