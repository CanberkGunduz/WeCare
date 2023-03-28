import 'package:flutter/material.dart';
import 'package:gdsc_metu2023/events/controllers/event_details_controller.dart';
import 'package:get/get.dart';
import '../model/event_model.dart';

class EventsDetailsPage extends StatelessWidget {
  Event event;
  EventsDetailsPage({Key? key, required this.event}) : super(key: key);

  EventDetailsTabController myTabController =
      Get.put(EventDetailsTabController());

  @override
  Widget build(BuildContext context) {
    DateTime date = event.eventDate.toDate();
    String dateStr =
        "${date.day.toString().padLeft(2, "0")}/${date.month.toString().padLeft(2, "0")}/${date.year.toString().padLeft(2, "0")}";
    String timeStr =
        "${date.hour.toString().padLeft(2, "0")}:${date.minute.toString().padLeft(2, "0")}";
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.grey[200],
          centerTitle: true,
          title: Text(
            event.eventName,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () => Get.back(),
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: Get.size.height * 0.23,
                  // width: Get.size.width,
                  child: Image.asset(
                    "assets/placeholder.png",
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      timeStr,
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    SizedBox(height: 15),
                    Text(dateStr,
                        style: TextStyle(fontSize: 16, color: Colors.black)),
                    SizedBox(height: 15),
                    Text(event.eventLocation,
                        style: TextStyle(fontSize: 16, color: Colors.black)),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            TabBar(controller: myTabController.controller, tabs: [
              Tab(
                child: Text(
                  "Description",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  "Comments",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  "Participants",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ]),
            SizedBox(height: 10),
            Expanded(
              child:
                  TabBarView(controller: myTabController.controller, children: [
                Text(event.eventDetail),
                Text("Comments"),
                Text("Participants"),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
