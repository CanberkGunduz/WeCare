import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:gdsc_metu2023/authentication/login_screen.dart';
import 'package:gdsc_metu2023/mainpage.dart';
import 'package:gdsc_metu2023/onboard/new_welcome.dart';
import 'package:gdsc_metu2023/onboard/user_welcome.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'user_model.dart' as model;
import '../constants.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<model.User> _user;
  late Rx<model.User> _foundUser;
  late Rx<User?> _firebaseuser;
  late Rx<File?> _pickedImage;
  late Rx<String> _profilePhotoUrl;

  File? get profilePhoto => _pickedImage.value;
  String get profilePhotoUrl => _profilePhotoUrl.value;
  User get firebaseuser => _firebaseuser.value!;
  model.User get user => _user.value;
  model.User get finduser => _foundUser.value;

  // @override
  // void onInit() async {
  //   super.onInit();
  //   await setUserData();
  // }

  @override
  void onReady() {
    super.onReady();
    _firebaseuser = Rx<User?>(firebaseAuth.currentUser);
    _firebaseuser.bindStream(firebaseAuth.authStateChanges());
    ever(_firebaseuser, _setInitialScreen);
  }

  _setInitialScreen(User? user) async {
    await Future.delayed(Duration(seconds: 2));
    if (user == null) {
      Get.offAll(() => NewUserWelcomePage(), transition: Transition.fadeIn, duration: Duration(milliseconds: 500));
    } else {
      await setUserData();
      Get.offAll(() => UserWelcomePage(), transition: Transition.fadeIn, duration: Duration(milliseconds: 500));
      await Future.delayed(Duration(seconds: 2));
      Get.offAll(() => MainPage(), transition: Transition.fadeIn, duration: Duration(milliseconds: 500));
    }
  }

  setUserData() async {
    String uid = firebaseAuth.currentUser!.uid;
    DocumentSnapshot userDoc = await firestore.collection("users").doc(uid).get();
    _user = Rx<model.User>(model.User.fromSnap(userDoc));
  }

  Future pickImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      Get.snackbar("Profile Picture", "You have successfully selected your profile picture");
    }
    _pickedImage = Rx<File?>(File(pickedImage!.path));
    _profilePhotoUrl = Rx<String>(pickedImage.path);
  }

  Future pickImageCamera() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      Get.snackbar("Profile Picture", "You have successfully selected your profile picture");
    }
    _pickedImage = Rx<File?>(File(pickedImage!.path));
    _profilePhotoUrl = Rx<String>(pickedImage.path);
  }

  findUser(String uid) async {
    DocumentSnapshot userDoc = await firestore.collection("users").doc(uid).get();
    _foundUser = Rx<model.User>(model.User.fromSnap(userDoc));
  }

  // upload to firebase storage
  Future<String> _uploadToStorage(File image) async {
    Reference ref = firebaseStorage.ref().child("profilePics").child(firebaseAuth.currentUser!.uid);

    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  // registering the user
  Future<bool> registerUser(
      String username,
      String email,
      String password,
      String gender,
      DateTime dateOfBirth,
      File? image,
      List interests,
      List skills,
      String countryName,
      String countryPhone,
      String countryFlagEmoji,
      String phoneNumber,
      String profession) async {
    try {
      if (username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          gender.isNotEmpty &&
          dateOfBirth != null &&
          image != null) {
        List<String> emailSplit = email.split("@");
        String emailExtension = emailSplit[1];
        // if (emailExtension != "metu.edu.tr") {
        //   Get.snackbar(
        //       "Error Creating User", "Please Enter A Metu Email Address");
        //   return;
        // }
        // save our user to our auth and firebase firestore
        UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        print("cred");
        String downloadUrl = await _uploadToStorage(image);
        model.User user = model.User(
          name: username,
          biography: "",
          profilePhoto: downloadUrl,
          email: email,
          uid: cred.user!.uid,
          gender: gender,
          score: 0,
          dateOfBirth: dateOfBirth,
          eventPosts: [],
          friends: [],
          participatedProjects: [],
          interests: interests,
          skills: skills,
          countryName: countryName,
          countryPhone: countryPhone,
          countryFlagEmoji: countryFlagEmoji,
          phoneNumber: phoneNumber,
          profession: profession,
          activeEventCount: 0,
          joinedEventCount: 0,
        );
        await firestore.collection("users").doc(cred.user!.uid).set(user.toJson());
        await Future.delayed(Duration(seconds: 1));
        await setUserData();
        print("set user");
        loginUser(email, password);
        return true;
      } else {
        Get.snackbar(
          "Error Creating User",
          "Please Enter All The Fields",
        );
        return false;
      }
    } catch (e) {
      Get.snackbar("Error Creating User", e.toString());
      return false;
    }
  }

  void loginUser(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
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
