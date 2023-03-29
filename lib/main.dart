import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gdsc_metu2023/map/placepicker.dart';
import 'package:get/get.dart';
import 'authentication/authentication.dart';
import 'mainpage.dart';
import 'map/map.dart';
import 'map/placepicker.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) {
    //Get.put(AuthController())
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
      home: PlacePicker(),
    );
  }
}
