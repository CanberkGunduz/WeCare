import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants.dart';

class EventParticipantController extends GetxController {
  final user = authController.user;
  final Rx<List<Map<String, dynamic>>> _participants = Rx<List<Map<String, dynamic>>>([]);

  List<Map<String, dynamic>> get participants => _participants.value;

  String _eventId = "";

  updateEventId(String id) {
    _eventId = id;
    getParticipant();
  }

  getParticipant() async {
    _participants.bindStream(
      firestore.collection("events").doc(_eventId).snapshots().map((DocumentSnapshot doc) {
        List<Map<String, dynamic>> retValue = [];
        for (var element in (doc.data() as Map<String, dynamic>)["participants"]) {
          retValue.add(element);
        }
        return retValue;
      }),
    );
  }

  addParticipant() async {
    if (await isParticipant()) {
      Get.snackbar("Error Joining", "You are already a participant in this event");
      return;
    }
    await firestore.collection("events").doc(_eventId).collection("participants").doc(user.uid).set({
      "name": user.name,
      "photo": user.profilePhoto,
      "uid": user.uid,
      "timestamp": DateTime.now().millisecondsSinceEpoch,
    });
    Get.snackbar("Successfully Joined", "You are now a participant in this event");
  }

  removeParticipant() async {
    if (!(await isParticipant())) {
      Get.snackbar("Error Leaving", "You are not a participant in this event");
      return;
    }
    await firestore.collection("events").doc(_eventId).collection("participants").doc(user.uid).delete();
    Get.snackbar("Successfully Left", "You are no longer a participant in this event");
  }

  isParticipant() async {
    var doc = await firestore.collection("events").doc(_eventId).collection("participants").doc(user.uid).get();
    return doc.exists;
  }
}
