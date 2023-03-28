import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants.dart';
import '../model/event_model.dart';

class EventTabController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void onInit() {
    super.onInit();
    controller = TabController(vsync: this, length: 3);
    controller.index = 1;
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }
}

class EventController extends GetxController {
  final Rx<List<List<Event>>> _eventList = Rx<List<List<Event>>>([]);
  // Rx<String> sortCriteria = "participants".obs;
  final user = authController.user;

  List<List<Event>> get eventList => _eventList.value;
  // List<Event> get eventList {
  //   if (sortCriteria.value == "newest") {
  //     sortByNewest();
  //   } else if (sortCriteria.value == "participants") {
  //     sortByParticipants();
  //   } else if (sortCriteria.value == "oldest") {
  //     sortByOldest();
  //   }
  //   return _eventList.value;
  // }

  @override
  void onInit() {
    super.onInit();
    _eventList.bindStream(
      firestore.collection("events").snapshots().map(
        (QuerySnapshot query) {
          List<List<Event>> retValue = [];
          List<Event> futureEvents = [];
          List<Event> pastEvents = [];
          DateTime now = DateTime.now();
          for (var element in query.docs) {
            Event event = Event.fromSnap(element);
            DateTime eventdate = event.eventDate.toDate();
            if (eventdate.isAfter(now)) {
              futureEvents.add(event);
            } else {
              pastEvents.add(event);
            }
          }
          retValue.add(futureEvents);
          retValue.add(pastEvents);
          return retValue;
        },
      ),
    );
  }

  // void sortByParticipants() {
  //   final sortedList = _eventList.value
  //     ..sort((a, b) {
  //       var b_participants = b.participants.length;
  //       var a_participants = a.participants.length;
  //       return b_participants.compareTo(a_participants);
  //     });
  //   _eventList.value = sortedList;
  // }

  // void sortByNewest() {
  //   final sortedList = _eventList.value
  //     ..sort((a, b) => b.datePublished.compareTo(a.datePublished));
  //   _eventList.value = sortedList;
  // }

  // void sortByOldest() {
  //   final sortedList = _eventList.value
  //     ..sort((a, b) => a.datePublished.compareTo(b.datePublished));
  //   _eventList.value = sortedList;
  // }

  // create event
  Future<bool> createEvent(String eventName, String eventDetail,
      String eventLocation, DateTime eventDate) async {
    try {
      if (eventName.isNotEmpty &&
          eventDetail.isNotEmpty &&
          eventLocation.isNotEmpty) {
        String uid = firebaseAuth.currentUser!.uid;
        DocumentSnapshot userDoc =
            await firestore.collection("users").doc(uid).get();
        // get id
        var allDocs = await firestore.collection("events").get();
        int len = allDocs.docs.length;
        var id = uuid.v1();

        Event event = Event(
          username: user.name,
          uid: uid,
          id: id,
          participants: [],
          eventName: eventName,
          eventDetail: eventDetail,
          profilePhoto: user.profilePhoto,
          datePublished: DateTime.now(),
          eventDate: eventDate,
          eventLocation: eventLocation,
        );
        Map<String, dynamic> id_date = {
          "id": id,
          "date": DateTime.now(),
        };

        await firestore.collection("events").doc(id).set(
              event.toJson(),
            );

        await firestore.collection("users").doc(uid).update(
          {
            "eventPosts": FieldValue.arrayUnion([id_date])
          },
        );
        await firestore.collection("users").doc(uid).update(
          {"activeEventCount": FieldValue.increment(1)},
        );

        Get.snackbar(
          "Event Created",
          "You have successfully created an event",
          backgroundColor: Colors.grey,
        );
        Get.back();
        return true;
      } else {
        Get.back();
        Get.snackbar(
          backgroundColor: Colors.grey,
          "Error Creating Event",
          "Please Enter All The Fields",
        );
        return false;
      }
    } catch (e) {
      Get.snackbar(
        "Error Creating Event",
        e.toString(),
        backgroundColor: Colors.grey,
      );
      return false;
    }
  }
}
