import 'package:flutter/material.dart';
import 'package:gdsc_metu2023/constants.dart';
import 'package:get/get.dart';

import 'authentication/user_model.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final List<String> _options = [
    "Add Institution",
    "Add Profession",
    "Notification Settings",
    "Change Password",
    "Logout"
  ];
  final List interestsList = [
    "Disaster alerts and response",
    "Volunteer opportunities",
    "Donations",
    "Community resources",
    "Medical assistance",
    "Shelter and housing assistance",
    "Employment and job training",
    "Education and literacy resources",
    "Mental health support",
    "Transportation assistance",
    "Family and child services",
    "Clean water and sanitation",
    "Food assistance",
    "Animal Rights",
    "Criminal Justice Reform",
    "Disability Rights",
    "Elderly Care",
    "Emergency Relief",
    "Environmental Protection",
    "Healthcare and Mental Health Support",
    "Humanitarian Aid",
    "Immigrant Rights",
    "LGBTQ+ Rights",
    "Mental Health Awareness",
    "Poverty Alleviation",
    "Racial Justice",
    "Social Justice",
    "Women's Rights",
  ];
  final List skillsList = [
    "Foreign languages (e.g. Spanish, French, Arabic, Mandarin)",
    "First aid and emergency response",
    "Community organizing and activism",
    "Social media and digital marketing",
    "Grant writing and fundraising",
    "Counseling and mental health support",
    "Teaching and tutoring",
    "Conflict resolution and mediation",
    "Project management",
    "Creative skills (e.g. writing, graphic design, photography)",
    "Leadership and team management",
    "Public speaking and presentation skills",
    "Event planning and coordination",
    "Wilderness survival and outdoor skills",
  ];
  final RxList interests = [].obs;
  final RxList skills = [].obs;
  final RxString _selectedOption = RxString('');
  final TextEditingController _bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    User user = authController.user;
    final RxList skills = user.skills.obs;
    final RxList interests = user.interests.obs;
    DateTime date = user.dateOfBirth.toDate();
    String birthdayText =
        'Birthday: ${date.day.toString().padLeft(2, "0")}/${date.month.toString().padLeft(2, "0")}/${date.year}';
    RxBool isEditing = false.obs;
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          "assets/WeCare.png",
          width: Get.width * 0.4,
        ),
        centerTitle: true,
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
                                style: TextStyle(color: Colors.orange[900], fontSize: 15, fontWeight: FontWeight.w400),
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
                                style: TextStyle(color: Colors.orange[900], fontSize: 15, fontWeight: FontWeight.w400),
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
                child: Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("About",
                              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: Colors.black)),
                          TextButton(
                              onPressed: () {
                                isEditing.value = !isEditing.value;
                                user.biography = _bioController.text;
                              },
                              child: Text(
                                "Edit",
                                style: TextStyle(color: Colors.orange[900]),
                              )),
                        ],
                      ),
                      SizedBox(height: 10),
                      !isEditing.value
                          ? Text(
                              user.biography,
                              style: TextStyle(height: 1.5, fontSize: 15),
                            )
                          : TextFormField(
                              controller: _bioController,
                              maxLines: 3,
                              decoration: InputDecoration(
                                hintText: "Write something about yourself",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.grey[300]!),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.grey[300]!),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.grey[300]!),
                                ),
                              ),
                              onEditingComplete: () => {
                                user.biography = _bioController.text,
                                isEditing.value = !isEditing.value,
                                // userController.updateUser(user),
                              },
                            ),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Interests",
                              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: Colors.black)),
                          InkWell(
                            onTap: () {
                              Get.defaultDialog(
                                title: "Interests",
                                content: SizedBox(
                                  height: Get.height * 0.7,
                                  child: SingleChildScrollView(
                                    physics: BouncingScrollPhysics(),
                                    child: Column(
                                      children: [
                                        Wrap(
                                          alignment: WrapAlignment.center,
                                          children: [
                                            for (var interest in interestsList)
                                              InterestCard(
                                                  interests: interests, interest: interest, isSelected: false.obs)
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                barrierDismissible: false,
                                textConfirm: "Done",
                                textCancel: "Cancel",
                                confirmTextColor: Colors.white,
                                cancelTextColor: Colors.orange[900],
                                buttonColor: Colors.orange[900],
                                onConfirm: () {
                                  user.interests = interests;
                                  Get.back();
                                },
                                onCancel: () {
                                  Get.back();
                                },
                              );
                            },
                            child: Text(
                              "Add more",
                              style: TextStyle(color: Colors.orange[900], fontWeight: FontWeight.w500),
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
                                            cancelTextColor: Colors.orange[900],
                                            buttonColor: Colors.orange[900],
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
                              Get.defaultDialog(
                                title: "Personal Skills",
                                content: SizedBox(
                                  height: Get.height * 0.6,
                                  child: SingleChildScrollView(
                                    physics: BouncingScrollPhysics(),
                                    child: Column(
                                      children: [
                                        Wrap(
                                          alignment: WrapAlignment.center,
                                          children: [
                                            for (var skill in skillsList)
                                              SkillCard(skills: skills, skill: skill, isSelected: false.obs)
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                barrierDismissible: false,
                                textConfirm: "Done",
                                textCancel: "Cancel",
                                confirmTextColor: Colors.white,
                                cancelTextColor: Colors.orange[900],
                                buttonColor: Colors.orange[900],
                                onConfirm: () {
                                  user.skills = skills;
                                  Get.back();
                                },
                                onCancel: () {
                                  Get.back();
                                },
                              );
                            },
                            child: Text(
                              "Add more",
                              style: TextStyle(color: Colors.orange[900], fontWeight: FontWeight.w500),
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
                                          cancelTextColor: Colors.orange[900],
                                          buttonColor: Colors.orange[900],
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
        title: Text('WeCare', style: TextStyle(color: Colors.orange[900])),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.orange[900]),
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
                                style: TextStyle(color: Colors.orange[900], fontSize: 15, fontWeight: FontWeight.w400),
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
                                style: TextStyle(color: Colors.orange[900], fontSize: 15, fontWeight: FontWeight.w400),
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

class InterestCard extends StatelessWidget {
  const InterestCard({
    super.key,
    required this.interests,
    required this.interest,
    required this.isSelected,
  });

  final RxList interests;
  final String interest;
  final RxBool isSelected;

  @override
  Widget build(BuildContext context) {
    isSelected.value = interests.contains(interest);
    return InkWell(
      onTap: () {
        if (interests.length >= 4 && !interests.contains(interest)) {
          Get.snackbar("Error", "You can only choose 4 interests");
          return;
        }
        interests.contains(interest) ? interests.remove(interest) : interests.add(interest);
        isSelected.value = !isSelected.value;
      },
      child: FittedBox(
        fit: BoxFit.contain,
        child: Obx(
          () => Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            color: isSelected.value ? Colors.orange : Colors.grey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Text(
                interest,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SkillCard extends StatelessWidget {
  const SkillCard({
    super.key,
    required this.skills,
    required this.skill,
    required this.isSelected,
  });

  final RxList skills;
  final String skill;
  final RxBool isSelected;

  @override
  Widget build(BuildContext context) {
    isSelected.value = skills.contains(skill);
    return InkWell(
      onTap: () {
        if (skills.length >= 4 && !skills.contains(skill)) {
          Get.snackbar("Error", "You can only choose 4 skills");
          return;
        }
        skills.contains(skill) ? skills.remove(skill) : skills.add(skill);
        isSelected.value = !isSelected.value;
      },
      child: FittedBox(
        fit: BoxFit.contain,
        child: Obx(
          () => Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            color: isSelected.value ? Colors.orange : Colors.grey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Text(
                skill,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
