import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  String username;
  String eventName;
  String eventDetail;
  String eventLocation;
  List comments;
  final datePublished;
  var eventDate;
  List participants;
  String profilePhoto;
  String uid;
  String id;

  Event({
    required this.username,
    required this.eventName,
    required this.eventDetail,
    required this.eventLocation,
    required this.comments,
    required this.datePublished,
    required this.eventDate,
    required this.participants,
    required this.profilePhoto,
    required this.uid,
    required this.id,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "eventName": eventName,
        "eventDetail": eventDetail,
        "eventLocation": eventLocation,
        "comments": comments,
        "datePublished": datePublished,
        "eventDate": eventDate,
        "participants": participants,
        "profilePhoto": profilePhoto,
        "uid": uid,
        "id": id,
      };

  static Event fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Event(
      username: snapshot["username"],
      eventName: snapshot["eventName"],
      eventDetail: snapshot["eventDetail"],
      eventLocation: snapshot["eventLocation"],
      comments: snapshot["comments"],
      datePublished: snapshot["datePublished"],
      eventDate: snapshot["eventDate"],
      participants: snapshot["participants"],
      profilePhoto: snapshot["profilePhoto"],
      uid: snapshot["uid"],
      id: snapshot["id"],
    );
  }
}
