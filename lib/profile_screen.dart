import 'package:flutter/material.dart';
import 'package:gdsc_metu2023/constants.dart';
import 'package:get/get.dart';

import 'authentication/user_model.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({required this.user, super.key});

  final User user;

  final List<String> _options = [
    "Add Institution",
    "Add Profession",
    "Notification Settings",
    "Change Password",
    "Logout"
  ];
  final RxString _selectedOption = RxString('');

  @override
  Widget build(BuildContext context) {
    final RxList skills = user.skills.obs;
    final RxList interests = user.interests.obs;
    DateTime date = user.dateOfBirth.toDate();
    String birthdayText =
        'Birthday: ${date.day.toString().padLeft(2, "0")}/${date.month.toString().padLeft(2, "0")}/${date.year}';
    return Scaffold(
      appBar: AppBar(
        title: const Text('WeCare', style: TextStyle(color: Colors.orange)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.orange),
          onPressed: () {
            Get.back();
          },
        ),
        backgroundColor: Colors.white,
        elevation: 3,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.black,
            ),
            onPressed: () {
              showMenu(
                context: context,
                position: RelativeRect.fromLTRB(Get.size.width, 0, 0, 0),
                items: _options.map((String option) {
                  return PopupMenuItem<String>(
                    value: option,
                    child: Text(option),
                  );
                }).toList(),
              ).then((selectedValue) {
                if (selectedValue != null) {
                  _selectedOption.value = selectedValue;
                  // do something with the selected value
                  if (selectedValue == "Logout") {
                    authController.signOut();
                  }
                }
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipOval(
                    child: CircleAvatar(
                      backgroundColor: Colors.grey[300],
                      radius: 80,
                      child: Image.network(
                        user.profilePhoto,
                        fit: BoxFit.contain,
                        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20),
                          Text(
                            user.name,
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                birthdayText,
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                              ),
                              SizedBox(width: 8),
                              Text(
                                user.gender,
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Score: ${user.score}',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                            margin: EdgeInsets.all(4),
                            elevation: 3,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                              child: Text(
                                "${user.friends.length} Friends",
                                style: TextStyle(color: Colors.orange, fontSize: 15, fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                          Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                            margin: EdgeInsets.all(4),
                            elevation: 3,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                              child: Text(
                                "Participated Projects: ${user.participatedProjects.length}",
                                style: TextStyle(color: Colors.orange, fontSize: 15, fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("About", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: Colors.black)),
                    SizedBox(height: 10),
                    Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod, nunc ut aliquam tincidunt, nunc nisl aliquam nisl, eget aliquam nunc nisl eget nunc.",
                      style: TextStyle(height: 1.5, fontSize: 15),
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Interests",
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: Colors.black)),
                        InkWell(
                          onTap: () {
                            // add more interest
                          },
                          child: Text(
                            "Add more",
                            style: TextStyle(color: Colors.orange, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Obx(
                      () => GridView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: interests.length,
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 1,
                          mainAxisSpacing: 1,
                          childAspectRatio: 2,
                        ),
                        itemBuilder: (context, index) {
                          return GridTile(
                            child: Card(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              color: Colors.white,
                              elevation: 3,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          interests[index],
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      radius: 16,
                                      onTap: () {
                                        // show dialog to confirm deleting interest
                                        Get.defaultDialog(
                                          title: "Remove Interest",
                                          middleText: "Are you sure you want to remove this interest?",
                                          textConfirm: "Yes",
                                          textCancel: "No",
                                          confirmTextColor: Colors.white,
                                          cancelTextColor: Colors.orange,
                                          buttonColor: Colors.orange,
                                          onConfirm: () {
                                            Get.back();
                                            interests.removeAt(index);
                                          },
                                        );
                                      },
                                      child: Icon(Icons.close),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Skills",
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: Colors.black)),
                        InkWell(
                          onTap: () {
                            // add more interest
                          },
                          child: Text(
                            "Add more",
                            style: TextStyle(color: Colors.orange, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Obx(
                      () => ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: skills.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            color: Colors.white,
                            elevation: 3,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      skills[index],
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  InkWell(
                                    radius: 16,
                                    onTap: () {
                                      // show dialog to confirm deleting interest
                                      Get.defaultDialog(
                                        title: "Remove Skill",
                                        middleText: "Are you sure you want to remove this skill?",
                                        textConfirm: "Yes",
                                        textCancel: "No",
                                        confirmTextColor: Colors.white,
                                        cancelTextColor: Colors.orange,
                                        buttonColor: Colors.orange,
                                        onConfirm: () {
                                          Get.back();
                                          skills.removeAt(index);
                                        },
                                      );
                                    },
                                    child: Icon(Icons.close),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileScreenVisitor extends StatelessWidget {
  ProfileScreenVisitor({required this.user, super.key});

  final User user;

  final List<String> _options = [
    "Add Friend",
    "Block User",
    "Report User",
  ];
  final RxString _selectedOption = RxString('');

  @override
  Widget build(BuildContext context) {
    RxList interests = user.interests.obs;
    RxList skills = user.skills.obs;
    DateTime date = user.dateOfBirth.toDate();
    String birthdayText =
        'Birthday: ${date.day.toString().padLeft(2, "0")}/${date.month.toString().padLeft(2, "0")}/${date.year}';
    return Scaffold(
      appBar: AppBar(
        title: const Text('WeCare', style: TextStyle(color: Colors.orange)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.orange),
          onPressed: () {
            Get.back();
          },
        ),
        backgroundColor: Colors.white,
        elevation: 3,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.black,
            ),
            onPressed: () {
              showMenu(
                context: context,
                position: RelativeRect.fromLTRB(Get.size.width, 0, 0, 0),
                items: _options.map((String option) {
                  return PopupMenuItem<String>(
                    value: option,
                    child: Text(option),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipOval(
                    child: CircleAvatar(
                      backgroundColor: Colors.grey[300],
                      radius: 80,
                      child: Image.network(
                        user.profilePhoto,
                        fit: BoxFit.contain,
                        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20),
                          Text(
                            user.name,
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                birthdayText,
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                              ),
                              SizedBox(width: 8),
                              Text(
                                user.gender,
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Score: ${user.score}',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                            margin: EdgeInsets.all(4),
                            elevation: 3,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                              child: Text(
                                "${user.friends.length} Friends",
                                style: TextStyle(color: Colors.orange, fontSize: 15, fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                          Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                            margin: EdgeInsets.all(4),
                            elevation: 3,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                              child: Text(
                                "Participated Projects: ${user.participatedProjects.length}",
                                style: TextStyle(color: Colors.orange, fontSize: 15, fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("About", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: Colors.black)),
                    SizedBox(height: 10),
                    Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed euismod, nunc ut aliquam tincidunt, nunc nisl aliquam nisl, eget aliquam nunc nisl eget nunc.",
                      style: TextStyle(height: 1.5, fontSize: 15),
                    ),
                    SizedBox(height: 30),
                    Text("Interests", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: Colors.black)),
                    SizedBox(height: 10),
                    Obx(
                      () => GridView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: interests.length,
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 1,
                          mainAxisSpacing: 1,
                          childAspectRatio: 2,
                        ),
                        itemBuilder: (context, index) {
                          return GridTile(
                            child: Card(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              color: Colors.white,
                              elevation: 3,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                          interests[index],
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 30),
                    Text("Skills", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: Colors.black)),
                    SizedBox(height: 10),
                    Obx(
                      () => ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: skills.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            color: Colors.white,
                            elevation: 3,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      skills[index],
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
