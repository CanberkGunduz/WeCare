import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants.dart';

class EventLockController extends GetxController {
  final user = authController.user;
  final Rx<List<bool>> _isLocked = Rx<List<bool>>([false]);

  List<bool> get isLocked => _isLocked.value;

  String _eventId = "";

  updateEventId(String id) {
    _eventId = id;
    getLockValue();
  }

  getLockValue() async {
    _isLocked.bindStream(
      firestore.collection("events").doc(_eventId).snapshots().map((DocumentSnapshot doc) {
        bool retValue = (doc.data() as Map<String, dynamic>)["isLocked"] == true;
        return [retValue];
      }),
    );
  }
}
