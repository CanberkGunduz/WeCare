import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/calendar.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Calendar(),
      ),
    );
  }
}
