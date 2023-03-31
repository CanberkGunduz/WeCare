import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:gdsc_metu2023/authentication/login_screen.dart';
import 'package:get/get.dart';

class NewUserWelcomePage extends StatelessWidget {
  NewUserWelcomePage({super.key});

  WelcomeTabController welcomeTabController = Get.put(WelcomeTabController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        SizedBox(
          height: Get.height * 0.92,
          child: TabBarView(
              controller: welcomeTabController.controller,
              // physics: NeverScrollableScrollPhysics(),
              children: [
                IntroductionPage1(welcomeTabController: welcomeTabController),
                IntroductionPage2(welcomeTabController: welcomeTabController),
                IntroductionPage3(welcomeTabController: welcomeTabController),
                IntroductionPage4(welcomeTabController: welcomeTabController),
              ]),
        ),
        SizedBox(
          height: Get.height * 0.05,
          child: TabPageSelector(
            controller: welcomeTabController.controller,
            selectedColor: Colors.orange[900],
            color: Colors.white,
          ),
        ),
      ],
    ));
  }
}

class IntroductionPage1 extends StatelessWidget {
  const IntroductionPage1({
    super.key,
    required this.welcomeTabController,
  });

  final WelcomeTabController welcomeTabController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          SizedBox(
            height: Get.height * 0.2,
          ),
          Image.asset(
            "assets/logo.png",
            width: Get.width,
          ),
          SizedBox(
            height: Get.height * 0.01,
          ),
          Text("Welcome", style: TextStyle(fontSize: 28, color: Colors.grey[800], fontWeight: FontWeight.w400)),
          SizedBox(
            height: Get.height * 0.03,
          ),
          Text(
            "Make a difference through volunteer projects",
            style: TextStyle(fontSize: 16, color: Colors.grey[800], fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: Get.height * 0.01,
          ),
          Text("Join projects, earn points, and become a leader!",
              style: TextStyle(fontSize: 16, color: Colors.grey[800], fontWeight: FontWeight.w400)),
          SizedBox(
            height: Get.height * 0.199,
          ),
          TextButton(
            onPressed: () {
              welcomeTabController.controller.animateTo(1, duration: Duration(milliseconds: 500), curve: Curves.easeIn);
            },
            child: Text(
              "Next",
              style: TextStyle(color: Colors.orange[900], fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}

class IntroductionPage2 extends StatelessWidget {
  const IntroductionPage2({
    super.key,
    required this.welcomeTabController,
  });

  final WelcomeTabController welcomeTabController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          SizedBox(
            height: Get.height * 0.15,
          ),
          Image.asset(
            "assets/intro2.png",
            width: Get.width,
          ),
          SizedBox(
            height: Get.height * 0.01,
          ),
          Text("Join Projects", style: TextStyle(fontSize: 28, color: Colors.grey[800], fontWeight: FontWeight.w400)),
          SizedBox(
            height: Get.height * 0.03,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Browse through our many volunteer projects, filter them based on your interests and location, and start making a difference",
              style: TextStyle(fontSize: 15, color: Colors.grey[800], fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: Get.height * 0.12,
          ),
          TextButton(
            onPressed: () {
              welcomeTabController.controller.animateTo(2, duration: Duration(milliseconds: 500), curve: Curves.easeIn);
            },
            child: Text(
              "Next",
              style: TextStyle(color: Colors.orange[900], fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}

class IntroductionPage3 extends StatelessWidget {
  const IntroductionPage3({
    super.key,
    required this.welcomeTabController,
  });

  final WelcomeTabController welcomeTabController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          SizedBox(
            height: Get.height * 0.14,
          ),
          Image.asset(
            "assets/intro3.png",
            width: Get.width,
          ),
          SizedBox(
            height: Get.height * 0.002,
          ),
          Text("Interact with Friends",
              style: TextStyle(fontSize: 28, color: Colors.grey[800], fontWeight: FontWeight.w400)),
          SizedBox(
            height: Get.height * 0.03,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Connect with friends, chat, and share projects. Keep track of your schedule with the calendar",
              style: TextStyle(fontSize: 15, color: Colors.grey[800], fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: Get.height * 0.141,
          ),
          TextButton(
            onPressed: () {
              welcomeTabController.controller.animateTo(3, duration: Duration(milliseconds: 500), curve: Curves.easeIn);
            },
            child: Text(
              "Next",
              style: TextStyle(color: Colors.orange[900], fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}

class IntroductionPage4 extends StatelessWidget {
  const IntroductionPage4({
    super.key,
    required this.welcomeTabController,
  });

  final WelcomeTabController welcomeTabController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          SizedBox(
            height: Get.height * 0.14,
          ),
          Image.asset(
            "assets/intro4.png",
            width: Get.width,
          ),
          SizedBox(
            height: Get.height * 0.004,
          ),
          Text("Create Your Projects",
              style: TextStyle(fontSize: 28, color: Colors.grey[800], fontWeight: FontWeight.w400)),
          SizedBox(
            height: Get.height * 0.03,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Gain points and become a trusted project leader, and receive rewards from our sponsors",
              style: TextStyle(fontSize: 15, color: Colors.grey[800], fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: Get.height * 0.142,
          ),
          TextButton(
            onPressed: () {
              Get.offAll(() => LoginPage(), transition: Transition.fade, duration: Duration(milliseconds: 500));
            },
            child: Text(
              "Let’s make the world better together!",
              style: TextStyle(color: Colors.orange[900], fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}

class WelcomeTabController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void onInit() {
    super.onInit();
    controller = TabController(vsync: this, length: 4);
    controller.index = 0;
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }
}
