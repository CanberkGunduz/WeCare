import 'package:flutter/material.dart';

import '../model/event_model.dart';

class EventTile extends StatelessWidget {
  Event event;
  EventTile({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        height: size.height * 0.15,
        // width: size.width * 0.9,
        decoration: BoxDecoration(
          color: Colors.white,
          // borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 5,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: Row(
          children: [
            Image.asset(
              "assets/placeholder.png",
              width: size.width * 0.3,
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 7),
                  Text(
                    event.eventName,
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  SizedBox(height: 5),
                  Text("Description",
                      style: TextStyle(fontSize: 14, color: Colors.black)),
                ],
              ),
            ),
            SizedBox(width: 20),
            Column(
              children: [
                Text("Date"),
                Text("Time"),
              ],
            ),
            SizedBox(
              width: 10,
            )
          ],
        ),
      ),
    );
  }
}
