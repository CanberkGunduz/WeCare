import 'package:flutter/material.dart';
import 'package:gdsc_metu2023/events/controllers/event_details_controller.dart';
import 'package:get/get.dart';
import '../model/event_model.dart';

class EventsDetailsPage extends StatelessWidget {
  Event event;
  EventsDetailsPage({Key? key, required this.event}) : super(key: key);

  EventDetailsTabController myTabController = Get.put(EventDetailsTabController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        title: Text(
          event.eventName,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
      ),
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
                  child: Image.asset("assets/placeholder.png",fit: BoxFit.contain,),
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Time",
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    SizedBox(height: 15),
                    Text("Date",
                        style: TextStyle(fontSize: 16, color: Colors.black)),
                        SizedBox(height: 15),
                    Text("Location",
                        style: TextStyle(fontSize: 16, color: Colors.black)),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            TabBar(
              controller: myTabController.controller,
              tabs: [
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
              child: TabBarView(
                controller: myTabController.controller,
                children: [
                Text("Description"),
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
