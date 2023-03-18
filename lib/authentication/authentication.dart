import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:gdsc_metu2023/authentication/login_screen.dart';
import 'package:gdsc_metu2023/mainpage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'user_model.dart' as model;
import '../constants.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> _user;
  late Rx<File?> _pickedImage;
  late Rx<String> _profilePhotoUrl;

  File? get profilePhoto => _pickedImage.value;
  String get profilePhotoUrl => _profilePhotoUrl.value;
  User get user => _user.value!;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());
    ever(_user, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => LoginPage());
    } else {
      Get.offAll(() => MainPage());
    }
  }

  void pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      Get.snackbar("Profile Picture",
          "You have successfully selected your profile picture");
    }
    _pickedImage = Rx<File?>(File(pickedImage!.path));
    _profilePhotoUrl = Rx<String>(pickedImage.path);
  }

  // upload to firebase storage
  Future<String> _uploadToStorage(File image) async {
    Reference ref = firebaseStorage
        .ref()
        .child("profilePics")
        .child(firebaseAuth.currentUser!.uid);

    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  // registering the user
  void registerUser(
      String username, String email, String password, File? image) async {
    try {
      if (username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        List<String> emailSplit = email.split("@");
        String emailExtension = emailSplit[1];
        if (emailExtension != "metu.edu.tr") {
          Get.snackbar(
              "Error Creating User", "Please Enter A Metu Email Address");
          return;
        }
        // save our user to our auth and firebase firestore
        UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        String downloadUrl = await _uploadToStorage(image);
        model.User user = model.User(
          name: username,
          profilePhoto: downloadUrl,
          email: email,
          uid: cred.user!.uid,
          eventPosts: [],
          activeEventCount: 0,
          joinedEventCount: 0,
        );
        await firestore
            .collection("users")
            .doc(cred.user!.uid)
            .set(user.toJson());
      } else {
        Get.snackbar(
          "Error Creating User",
          "Please Enter All The Fields",
        );
      }
    } catch (e) {
      Get.snackbar("Error Creating User", e.toString());
    }
  }

  void loginUser(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        print("log success");
      } else {
        Get.snackbar(
          "Error Logging In",
          "Please Enter All The Fields",
        );
      }
    } catch (e) {
      Get.snackbar("Error Logging In", e.toString());
    }
  }

  void signOut() async {
    await firebaseAuth.signOut();
  }
}
