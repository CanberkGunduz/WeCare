import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterTabController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void onInit() {
    super.onInit();
    controller = TabController(vsync: this, length: 3);
    controller.index = 0;
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }
}
