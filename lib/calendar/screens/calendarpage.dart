import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/calendar.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: Text("Calendar", style: TextStyle(color: Colors.orange)),
            backgroundColor: Colors.white,
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.orange,
              ),
            )),
        body: Calendar(),
      ),
    );
  }
}
