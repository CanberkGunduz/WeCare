import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String name;
  String biography;
  String profilePhoto;
  String email;
  String uid;
  String gender;
  int score;
  var dateOfBirth;
  List eventPosts;
  List friends;
  List participatedProjects;
  List interests;
  List ableToTeach;
  int activeEventCount;
  int joinedEventCount;

  User({
    required this.name,
    required this.biography,
    required this.profilePhoto,
    required this.email,
    required this.uid,
    required this.gender,
    required this.score,
    required this.dateOfBirth,
    required this.eventPosts,
    required this.friends,
    required this.participatedProjects,
    required this.interests,
    required this.ableToTeach,
    required this.activeEventCount,
    required this.joinedEventCount,
  });

  Map<String, dynamic> toJson() => {
        "name": name,
        "biography": biography,
        "profilePhoto": profilePhoto,
        "email": email,
        "uid": uid,
        "gender": gender,
        "score": score,
        "dateOfBirth": dateOfBirth,
        "eventPosts": eventPosts,
        "friends": friends,
        "participatedProjects": participatedProjects,
        "interests": interests,
        "ableToTeach": ableToTeach,
        "activeEventCount": activeEventCount,
        "joinedEventCount": joinedEventCount,
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
      name: snapshot["name"],
      biography: snapshot["biography"],
      email: snapshot["email"],
      profilePhoto: snapshot["profilePhoto"],
      uid: snapshot["uid"],
      gender: snapshot["gender"],
      score: snapshot["score"],
      dateOfBirth: snapshot["dateOfBirth"],
      eventPosts: snapshot["eventPosts"],
      friends: snapshot["friends"],
      participatedProjects: snapshot["participatedProjects"],
      interests: snapshot["interests"],
      ableToTeach: snapshot["ableToTeach"],
      activeEventCount: snapshot["activeEventCount"],
      joinedEventCount: snapshot["joinedEventCount"],
    );
  }
}
