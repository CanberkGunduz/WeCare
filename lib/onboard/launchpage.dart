import 'package:flutter/material.dart';
import 'package:gdsc_metu2023/constants.dart';
import 'package:get/get.dart';

class LaunchPage extends StatelessWidget {
  LaunchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(width: Get.width, child: Image.asset("assets/onboard.png")),
        ),
      ),
    );
  }
}
