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
                // SizedBox(height: 10,),
                ListView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: eventController.eventList[1].length,
                  itemBuilder: (context, index) {
                    final event = eventController.eventList[1][index];
                    return InkWell(
                        onTap: () => Get.to(() => EventsDetailsPage(event: event)),
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
