import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants.dart';
import '../model/event_comment_model.dart';

class EventCommentController extends GetxController {
  final Rx<List<Comment>> _comments = Rx<List<Comment>>([]);
  final Rx<List<Comment>> _replies = Rx<List<Comment>>([]);

  final user = authController.user;

  Rx<String> sortCriteria = "likes".obs;

  List<Comment> get comments => _comments.value;

  // List<Comment> get comments {
  //   if (sortCriteria.value == "newest") {
  //     sortByNewest();
  //   } else if (sortCriteria.value == "likes") {
  //     sortByLikes();
  //   } else if (sortCriteria.value == "oldest") {
  //     sortByOldest();
  //   }
  //   return _comments.value;
  // }

  List<Comment> get replies => _replies.value;

  String _eventId = "";

  updateEventId(String id) {
    _eventId = id;
    getComment();
  }

  getComment() async {
    _comments.bindStream(
      firestore.collection("events").doc(_eventId).collection("comments").snapshots().map(
        (QuerySnapshot query) {
          List<Comment> retValue = [];
          for (var element in query.docs) {
            retValue.add(Comment.fromSnap(element));
          }
          return retValue;
        },
      ),
    );
  }

  getReply(String id) async {
    _replies.bindStream(
      firestore.collection("events").doc(_eventId).collection("comments").doc(id).collection("replies").snapshots().map(
        (QuerySnapshot query) {
          List<Comment> retValue = [];
          for (var element in query.docs) {
            retValue.add(Comment.fromSnap(element));
          }
          return retValue;
        },
      ),
    );
  }

  void sortByLikes() {
    final sortedList = _comments.value
      ..sort((a, b) {
        var b_likes = b.likedUsers.length - b.dislikedUsers.length;
        var a_likes = a.likedUsers.length - a.dislikedUsers.length;
        return b_likes.compareTo(a_likes);
      });
    _comments.value = sortedList;
  }

  void sortByNewest() {
    final sortedList = _comments.value..sort((a, b) => b.datePublished.compareTo(a.datePublished));
    _comments.value = sortedList;
  }

  void sortByOldest() {
    final sortedList = _comments.value..sort((a, b) => a.datePublished.compareTo(b.datePublished));
    _comments.value = sortedList;
  }

  likeComment(String id) async {
    var uid = authController.user.uid;
    DocumentSnapshot doc = await firestore.collection("events").doc(_eventId).collection("comments").doc(id).get();
    if ((doc.data()! as dynamic)["likedUsers"].contains(uid)) {
      await firestore.collection("events").doc(_eventId).collection("comments").doc(id).update(
        {
          "likedUsers": FieldValue.arrayRemove([uid])
        },
      );
    } else {
      await firestore.collection("events").doc(_eventId).collection("comments").doc(id).update(
        {
          "likedUsers": FieldValue.arrayUnion([uid])
        },
      );
    }
  }

  neutralizeComment(String id) async {
    var uid = authController.user.uid;
    DocumentSnapshot doc = await firestore.collection("events").doc(_eventId).collection("comments").doc(id).get();
    if ((doc.data()! as dynamic)["likedUsers"].contains(uid)) {
      await firestore.collection("events").doc(_eventId).collection("comments").doc(id).update(
        {
          "likedUsers": FieldValue.arrayRemove([uid])
        },
      );
    } else if ((doc.data()! as dynamic)["dislikedUsers"].contains(uid)) {
      await firestore.collection("events").doc(_eventId).collection("comments").doc(id).update(
        {
          "dislikedUsers": FieldValue.arrayRemove([uid])
        },
      );
    }
  }

  dislikeComment(String id) async {
    var uid = authController.user.uid;
    DocumentSnapshot doc = await firestore.collection("events").doc(_eventId).collection("comments").doc(id).get();
    if ((doc.data()! as dynamic)["dislikedUsers"].contains(uid)) {
      await firestore.collection("events").doc(_eventId).collection("comments").doc(id).update(
        {
          "dislikedUsers": FieldValue.arrayRemove([uid])
        },
      );
    } else {
      await firestore.collection("events").doc(_eventId).collection("comments").doc(id).update(
        {
          "dislikedUsers": FieldValue.arrayUnion([uid])
        },
      );
    }
  }

  postComment(String commentText) async {
    try {
      if (commentText.isNotEmpty) {
        if (commentText.length >= 200) {
          Get.snackbar(
            "Error",
            "Comment is too long",
            backgroundColor: Colors.grey,
          );
        } else {
          var allDocs = await firestore.collection("events").doc(_eventId).collection("comments").get();
          var id = uuid.v1();

          Comment comment = Comment(
            username: user.name,
            comment: commentText.trim(),
            datePublished: DateTime.now(),
            likedUsers: [],
            dislikedUsers: [],
            profilePhoto: user.profilePhoto,
            uid: authController.user.uid,
            id: id,
            replyCount: 0,
          );
          await firestore.collection("events").doc(_eventId).collection("comments").doc(id).set(comment.toJson());
          await firestore.collection("events").doc(_eventId).update({
            "commentCount": FieldValue.increment(1),
          });
          Get.snackbar("Success", "Comment Posted", backgroundColor: Colors.grey);
        }
      }
    } catch (e) {
      Get.snackbar(
        "Error While Commenting",
        e.toString(),
        backgroundColor: Colors.grey,
      );
    }
  }

  deleteComment(String id) async {
    try {
      await firestore.collection("events").doc(_eventId).collection("comments").doc(id).delete();
      await firestore.collection("events").doc(_eventId).update({
        "commentCount": FieldValue.increment(-1),
      });
    } catch (e) {
      Get.snackbar(
        "Error While Deleting Comment",
        e.toString(),
        backgroundColor: Colors.grey,
      );
    }
  }

  reportComment(String id, String reason) async {
    try {
      final userId = authController.user.uid;

      final doc = firestore.collection("events").doc(_eventId).collection("comments").doc(id);

      final snapshot = await doc.get();

      if (snapshot.exists) {
        final data = snapshot.data()! as dynamic;
        if (data["reportedBy"] != null) {
          bool alreadyReported = false;
          final Map<String, dynamic> reportedByMap = data["reportedBy"];
          reportedByMap.forEach((key, value) {
            if (value["uid"] == userId) {
              alreadyReported = true;
            }
          });
          if (alreadyReported) {
            Get.snackbar(
              "Already Reported",
              "You have already reported this comment",
              backgroundColor: Colors.grey,
            );
            return;
          }
        }
        final Map<String, dynamic> reportedBy = data["reportedBy"] ?? {};
        reportedBy[DateTime.now().toIso8601String()] = {"uid": userId, "reason": reason};
        final totalReportCount = (data["totalReportCount"] ?? 0) + 1;

        await doc.update({
          "reportedBy": reportedBy,
          "totalReportCount": totalReportCount,
        });
        Get.snackbar(
          "Reported",
          "Comment has been reported",
          backgroundColor: Colors.grey,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error While Reporting Comment",
        e.toString(),
        backgroundColor: Colors.grey,
      );
    }
  }

  replyComment(String commentText, String id) async {
    try {
      if (commentText.isNotEmpty) {
        var allDocs = await firestore
            .collection("events")
            .doc(_eventId)
            .collection("comments")
            .doc(id)
            .collection("replies")
            .get();
        int len = allDocs.docs.length;
        var replyId = uuid.v1();

        Comment comment = Comment(
          username: user.name,
          comment: commentText.trim(),
          datePublished: DateTime.now(),
          likedUsers: [],
          dislikedUsers: [],
          profilePhoto: user.profilePhoto,
          uid: authController.user.uid,
          id: replyId,
          replyCount: 0,
        );
        await firestore
            .collection("events")
            .doc(_eventId)
            .collection("comments")
            .doc(id)
            .collection("replies")
            .doc(replyId)
            .set(comment.toJson());
        await firestore.collection("events").doc(_eventId).update({
          "commentCount": FieldValue.increment(1),
        });
        await firestore.collection("events").doc(_eventId).collection("comments").doc(id).update({
          "replyCount": FieldValue.increment(1),
        });
      }
    } catch (e) {
      Get.snackbar(
        "Error While Replying",
        e.toString(),
        backgroundColor: Colors.grey,
      );
    }
  }
}
