import 'package:get/get.dart';

class CalendarController extends GetxController {
  final Rx<DateTime> _focusedDay = DateTime.now().obs;

  DateTime get focusedDay => _focusedDay.value;
  set focusedDay(DateTime value) => _focusedDay.value = value;
  void onDateSelected(DateTime date) {
    _focusedDay.value = date;
  }
}
