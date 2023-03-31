import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants.dart';
import '../model/event_model.dart';

class EventTabController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void onInit() {
    super.onInit();
    controller = TabController(vsync: this, length: 3);
    controller.index = 0;
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }
}

class EventController extends GetxController {
  final Rx<List<List<Event>>> _eventList = Rx<List<List<Event>>>([]);
  final Rx<List<Map<String, dynamic>>> _comments = Rx<List<Map<String, dynamic>>>([]);

  // Rx<String> sortCriteria = "participants".obs;
  final user = authController.user;
  late Rx<File?> _pickedImage;
  File? get eventPhoto => _pickedImage.value;

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
          List<Event> allEvents = [];
          List<Event> myEvents = [];
          List<Event> joinedUpcomingEvents = [];
          List<Event> joinedPastEvents = [];
          List<Event> urgentEvents = [];
          DateTime now = DateTime.now();
          for (var element in query.docs) {
            Event event = Event.fromSnap(element);
            DateTime eventdate = event.eventDate.toDate();
            allEvents.add(event);
            if (event.uid == user.uid) {
              myEvents.add(event);
            }
            if (event.participants.any((element) => element["uid"] == user.uid)) {
              if (eventdate.isAfter(now)) {
                joinedUpcomingEvents.add(event);
              } else {
                joinedPastEvents.add(event);
                user.participatedProjects.add(event.id);
              }
            }
            if (eventdate.isBefore(now.add(Duration(days: 7)))) {
              urgentEvents.add(event);
            }
          }
          retValue.add(allEvents);
          retValue.add(myEvents);
          retValue.add(joinedUpcomingEvents);
          retValue.add(joinedPastEvents);
          retValue.add(urgentEvents);
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

  Future pickImageGallery() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      Get.snackbar(
        "Item Picture",
        "You have successfully selected the item picture",
        backgroundColor: Colors.grey,
      );
    }
    _pickedImage = Rx<File?>(File(pickedImage!.path));
  }

  // upload to firebase storage
  Future<String> _uploadToStorage(File image, String itemName) async {
    Reference ref = firebaseStorage.ref().child("event_pictures").child(user.uid).child(itemName);

    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  // create event
  Future<bool> createEvent(String eventName, String eventDetail, List eventLocation, List goals, List activities,
      List categories, File? eventPhoto, DateTime eventDate) async {
    try {
      if (eventName.isNotEmpty &&
          eventDetail.isNotEmpty &&
          eventLocation.isNotEmpty &&
          goals.isNotEmpty &&
          activities.isNotEmpty &&
          categories.isNotEmpty &&
          eventPhoto != null) {
        String uid = firebaseAuth.currentUser!.uid;
        DocumentSnapshot userDoc = await firestore.collection("users").doc(uid).get();
        // get id
        var allDocs = await firestore.collection("events").get();
        int len = allDocs.docs.length;
        var id = uuid.v1();

        String downloadUrl = await _uploadToStorage(eventPhoto, eventName);

        Event event = Event(
          username: user.name,
          uid: uid,
          id: id,
          participants: [],
          eventName: eventName,
          eventDetail: eventDetail,
          eventPhoto: downloadUrl,
          goals: goals,
          activities: activities,
          categories: categories,
          isLocked: false,
          comments: [],
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

  joinEvent(String id) async {
    var uid = user.uid;
    DocumentSnapshot doc = await firestore.collection("events").doc(id).get();
    bool isParticipant = false;
    var map = doc.data()! as Map<String, dynamic>;
    for (int i = 0; i < map["participants"].length; i++) {
      if (map["participants"][i]["uid"] == user.uid) {
        isParticipant = true;
        break;
      }
    }
    if (isParticipant) {
      Get.snackbar(
        "Error Joining The Event",
        "You are already a participant in this event",
        backgroundColor: Colors.grey,
      );
    } else {
      Map<String, dynamic> uidNamePhotoScore = {
        "uid": uid,
        "name": user.name,
        "profilePhoto": user.profilePhoto,
        "score": user.score,
      };
      await firestore.collection("events").doc(id).update(
        {
          "participants": FieldValue.arrayUnion([uidNamePhotoScore])
        },
      );
      await firestore.collection("users").doc(uid).update(
        {"joinedEventCount": FieldValue.increment(1)},
      );
      Get.snackbar(
        "Event Joined",
        "You have successfully joined the event.",
        backgroundColor: Colors.grey,
      );
    }
  }

  leaveEvent(String id) async {
    var uid = user.uid;
    DocumentSnapshot doc = await firestore.collection("events").doc(id).get();
    bool isParticipant = false;
    int participantIndex = 0;
    var map = doc.data()! as Map<String, dynamic>;
    for (int i = 0; i < map["participants"].length; i++) {
      if (map["participants"][i]["uid"] == user.uid) {
        isParticipant = true;
        participantIndex = i;
        break;
      }
    }
    if (isParticipant) {
      print(participantIndex);
      await firestore.collection("events").doc(id).update(
        {
          "participants": FieldValue.arrayRemove([map["participants"][participantIndex]])
        },
      );
      Get.snackbar(
        "Event Left",
        "You have successfully left the event.",
        backgroundColor: Colors.grey,
      );
      await firestore.collection("users").doc(uid).update(
        {"joinedEventCount": FieldValue.increment(-1)},
      );
    } else {
      Get.snackbar(
        "Error Leaving The Event",
        "You are not a participant in this event",
        backgroundColor: Colors.grey,
      );
    }
  }

  lockEvent(String id) async {
    await firestore.collection("events").doc(id).update(
      {
        "isLocked": true,
      },
    );
    Get.snackbar(
      "Event Locked",
      "You have successfully locked the event.",
      backgroundColor: Colors.grey,
    );
  }

  unlockEvent(String id) async {
    await firestore.collection("events").doc(id).update(
      {
        "isLocked": false,
      },
    );
    Get.snackbar(
      "Event Unlocked",
      "You have successfully unlocked the event.",
      backgroundColor: Colors.grey,
    );
  }

  Future<bool> isCreator(String id) async {
    var uid = authController.user.uid;
    DocumentSnapshot doc = await firestore.collection("events").doc(id).get();
    if ((doc.data()! as dynamic)["uid"] == uid) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> isEventActive(String id) async {
    DocumentSnapshot doc = await firestore.collection("events").doc(id).get();
    DateTime eventDate = (doc.data()! as dynamic)["eventDate"].toDate();
    DateTime now = DateTime.now();
    if (eventDate.isAfter(now)) {
      return true;
    } else {
      return false;
    }
  }
}
