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
  List skills;
  String countryName;
  String countryPhone;
  String countryFlagEmoji;
  String phoneNumber;
  String profession;
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
    required this.skills,
    required this.countryName,
    required this.countryPhone,
    required this.countryFlagEmoji,
    required this.phoneNumber,
    required this.profession,
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
        "skills": skills,
        "countryName": countryName,
        "countryPhone": countryPhone,
        "countryFlagEmoji": countryFlagEmoji,
        "phoneNumber": phoneNumber,
        "profession": profession,
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
      skills: snapshot["skills"],
      countryName: snapshot["countryName"],
      countryPhone: snapshot["countryPhone"],
      countryFlagEmoji: snapshot["countryFlagEmoji"],
      phoneNumber: snapshot["phoneNumber"],
      profession: snapshot["profession"],
      activeEventCount: snapshot["activeEventCount"],
      joinedEventCount: snapshot["joinedEventCount"],
    );
  }
}
