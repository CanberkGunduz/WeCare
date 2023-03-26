import 'package:flutter/material.dart';

import '../model/event_model.dart';

class EventTile extends StatelessWidget {
  Event event;
  EventTile({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        height: size.height * 0.15,
        // width: size.width * 0.9,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
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
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage("assets/placeholder.png"),
                  fit: BoxFit.cover,
                ),
              ),
              // child: Image.asset(
              //   "assets/placeholder.png",
                
                width: size.width * 0.3,
                
              // ),
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
                  Row(children: [
                    Icon(
                      Icons.calendar_today,
                      color: Colors.grey,
                      size: 16,
                    ),
                    SizedBox(width: 5),
                    Text(
                      event.eventDate,
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],)
                  ],
              ),
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
