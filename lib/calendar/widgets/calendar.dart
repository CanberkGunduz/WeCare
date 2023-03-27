import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import '../controllers/calendar_controller.dart';

class Calendar extends StatelessWidget {
  Calendar({super.key});

  final CalendarController _calendarController = Get.put(CalendarController());
  final calendarFormat = CalendarFormat.month.obs;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TableCalendar(
        focusedDay: _calendarController.focusedDay,
        firstDay: DateTime.utc(2022, 01, 01),
        lastDay: DateTime.utc(2030, 12, 31),
        availableGestures: AvailableGestures.all,
        selectedDayPredicate: (day) =>
            isSameDay(_calendarController.focusedDay, day),
        onDaySelected: (selectedDay, focusedDay) {
          _calendarController.onDateSelected(selectedDay);
        },
        onFormatChanged: (format) => calendarFormat.value = format,
        calendarFormat: calendarFormat.value,
      ),
    );
  }
}
