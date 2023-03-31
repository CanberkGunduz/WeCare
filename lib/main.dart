import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gdsc_metu2023/constants.dart';
import 'package:gdsc_metu2023/events/controllers/event_controller.dart';
import 'package:gdsc_metu2023/onboard/launchpage.dart';
import 'package:gdsc_metu2023/onboard/new_welcome.dart';
import 'package:get/get.dart';
import 'authentication/authentication.dart';
import 'mainpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) async {
    Get.put(AuthController());

    try {
      await authController.setUserData();
    } catch (e) {
      authController.signOut();
    }
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "GDSC 2023",
      home: LaunchPage(),
    );
  }
}
