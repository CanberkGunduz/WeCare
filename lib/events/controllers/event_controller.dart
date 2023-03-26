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
  final Rx<List<Event>> _eventList = Rx<List<Event>>([]);
  Rx<String> sortCriteria = "participants".obs;

  List<Event> get eventList => _eventList.value;
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
          List<Event> retValue = [];
          for (var element in query.docs) {
            retValue.add(Event.fromSnap(element));
          }
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
  createEvent(String eventName, String eventDetail, String eventLocation,
      DateTime eventDate) async {
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
          // username: (userDoc.data()! as Map<String, dynamic>)["name"],
          // uid: uid,
          // id: id,
          // participants: [],
          eventName: eventName,
          // eventDetail: eventDetail,
          // profilePhoto:
          //     (userDoc.data()! as Map<String, dynamic>)["profilePhoto"],
          // datePublished: DateTime.now(),
          // eventDate: eventDate,
          // eventLocation: eventLocation,
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
      } else {
        Get.back();
        Get.snackbar(
          backgroundColor: Colors.grey,
          "Error Creating Event",
          "Please Enter All The Fields",
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error Creating Event",
        e.toString(),
        backgroundColor: Colors.grey,
      );
    }
  }
}
