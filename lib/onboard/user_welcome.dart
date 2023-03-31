import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:gdsc_metu2023/constants.dart';
import 'package:get/get.dart';

import '../authentication/user_model.dart';

class UserWelcomePage extends StatelessWidget {
  const UserWelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    User user = authController.user;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: Get.height * 0.25,
          ),
          Image.asset(
            "assets/logo.png",
            width: Get.width * 0.6,
          ),
          SizedBox(
            height: Get.height * 0.02,
          ),
          Image.asset("assets/slogan.png", width: Get.width),
          SizedBox(
            height: Get.height * 0.1,
          ),
          Text(
            "Welcome\n${user.name}",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
