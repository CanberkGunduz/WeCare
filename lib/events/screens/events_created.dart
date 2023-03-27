import 'package:flutter/material.dart';
import 'package:gdsc_metu2023/events/screens/events_create.dart';
import 'package:gdsc_metu2023/events/tiles/event_tile.dart';
import 'package:get/get.dart';

import '../model/event_model.dart';
import 'events_details.dart';

class EventsCreatedPage extends StatelessWidget {
  const EventsCreatedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final events = [
      // Event(eventName: "Project 1"),
      // Event(eventName: "Project 2"),
      // Event(eventName: "Project 3"),
    ];
    final events_previous = [
      // Event(eventName: "Project 4"),
      // Event(eventName: "Project 5"),
      // Event(eventName: "Project 6"),
    ];
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
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    final event = events[index];
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
