import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  String username;
  String comment;
  final datePublished;
  List likedUsers;
  List dislikedUsers;
  String profilePhoto;
  String uid;
  String id;
  int replyCount = 0;

  Comment({
    required this.username,
    required this.comment,
    required this.datePublished,
    required this.likedUsers,
    required this.dislikedUsers,
    required this.profilePhoto,
    required this.uid,
    required this.id,
    required this.replyCount,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "comment": comment,
        "datePublished": datePublished,
        "likedUsers": likedUsers,
        "dislikedUsers": dislikedUsers,
        "profilePhoto": profilePhoto,
        "uid": uid,
        "id": id,
        "replyCount": replyCount,
      };

  static Comment fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Comment(
      username: snapshot["username"],
      comment: snapshot["comment"],
      datePublished: snapshot["datePublished"],
      likedUsers: snapshot["likedUsers"],
      dislikedUsers: snapshot["dislikedUsers"],
      profilePhoto: snapshot["profilePhoto"],
      uid: snapshot["uid"],
      id: snapshot["id"],
      replyCount: snapshot["replyCount"],
    );
  }
}
