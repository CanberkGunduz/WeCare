import 'dart:io';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:gdsc_metu2023/authentication/controllers/register_tab_controller.dart';
import 'package:get/get.dart';

import '../constants.dart';
import 'login_screen.dart';
import '../widgets/text_input_field.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final RegisterTabController _registerTabController = Get.put(RegisterTabController());
  final RxString pickedImageUrl = "".obs;
  final RxString countryName = "Turkey".obs;
  final RxString countryPhone = "90".obs;
  final RxString countryFlagEmoji = "🇹🇷".obs;
  final RxString gender = "Gender".obs;
  final Rx dateOfBirth = DateTime.now().obs;
  final RxList interests = [].obs;
  final RxList skills = [].obs;
  final RxList languages = [].obs;
  final RxString profession = "".obs;
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: TabBarView(
          controller: _registerTabController.controller,
          // physics: const NeverScrollableScrollPhysics(),
          children: [
            SignCredentialsPage1(
                nameController: _nameController,
                lastnameController: _lastnameController,
                emailController: _emailController,
                passwordController: _passwordController,
                confirmPasswordController: _confirmPasswordController,
                registerTabController: _registerTabController),
            SignCredentialsPage2(
                gender: gender,
                dateOfBirth: dateOfBirth,
                phoneController: _phoneController,
                registerTabController: _registerTabController,
                countryName: countryName,
                countryPhone: countryPhone,
                countryFlagEmoji: countryFlagEmoji),
            SignCredentialsPage3(
                nameController: _nameController,
                lastnameController: _lastnameController,
                pickedImageUrl: pickedImageUrl,
                interestsList: interestsList,
                interests: interests,
                skillsList: skillsList,
                skills: skills,
                registerTabController: _registerTabController,
                emailController: _emailController,
                passwordController: _passwordController,
                gender: gender,
                dateOfBirth: dateOfBirth,
                countryName: countryName,
                countryPhone: countryPhone,
                countryFlagEmoji: countryFlagEmoji,
                phoneController: _phoneController,
                profession: profession),
          ],
        ),
      ),
    );
  }
}

class SignCredentialsPage3 extends StatelessWidget {
  SignCredentialsPage3({
    super.key,
    required TextEditingController nameController,
    required TextEditingController lastnameController,
    required this.pickedImageUrl,
    required this.interestsList,
    required this.interests,
    required this.skillsList,
    required this.skills,
    required RegisterTabController registerTabController,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required this.gender,
    required this.dateOfBirth,
    required this.countryName,
    required this.countryPhone,
    required this.countryFlagEmoji,
    required TextEditingController phoneController,
    required this.profession,
  })  : _nameController = nameController,
        _lastnameController = lastnameController,
        _registerTabController = registerTabController,
        _emailController = emailController,
        _passwordController = passwordController,
        _phoneController = phoneController;

  final TextEditingController _nameController;
  final TextEditingController _lastnameController;
  final RxString pickedImageUrl;
  final List interestsList;
  final RxList interests;
  final List skillsList;
  final RxList skills;
  final RegisterTabController _registerTabController;
  final TextEditingController _emailController;
  final TextEditingController _passwordController;
  final RxString gender;
  final Rx dateOfBirth;
  final RxString countryName;
  final RxString countryPhone;
  final RxString countryFlagEmoji;
  final TextEditingController _phoneController;
  final RxString profession;
  final RxBool canProceed = false.obs;

  @override
  Widget build(BuildContext context) {
    if (pickedImageUrl.value == "") {
      canProceed.value = false;
    } else {
      canProceed.value = true;
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        children: [
          SizedBox(
            height: Get.height * 0.1,
          ),
          Text(
            "Welcome to WeCare",
            style: TextStyle(fontSize: 32, color: Colors.orange[900], fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: Get.height * 0.005,
          ),
          Text(
            "${_nameController.text} ${_lastnameController.text}",
            style: TextStyle(fontSize: 24, color: Colors.black),
          ),
          SizedBox(
            height: Get.height * 0.03,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text(
                    "Upload your profile picture",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: Get.height * 0.001,
                  ),
                  Row(
                    children: [
                      TextButton(
                          onPressed: () async {
                            await authController.pickImage();
                            pickedImageUrl.value = authController.profilePhotoUrl;
                          },
                          child: Text(
                            "Gallery",
                            style: TextStyle(
                              color: Colors.orange[900],
                            ),
                          )),
                      SizedBox(
                        width: Get.width * 0.03,
                      ),
                      TextButton(
                          onPressed: () async {
                            await authController.pickImageCamera();
                            pickedImageUrl.value = authController.profilePhotoUrl;
                          },
                          child: Text(
                            "Camera",
                            style: TextStyle(
                              color: Colors.orange[900],
                            ),
                          )),
                    ],
                  ),
                ],
              ),
              SizedBox(
                width: Get.width * 0.01,
              ),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Obx(
                  () => ClipOval(
                    child: CircleAvatar(
                        radius: 56,
                        backgroundColor: Colors.grey[300],
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: pickedImageUrl == ""
                              ? Image.asset("assets/logo.png")
                              : Image.file(authController.profilePhoto!),
                        )),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: Get.height * 0.005,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
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
                                    InterestCard(interests: interests, interest: interest, isSelected: false.obs)
                                ],
                              ),
                            ],
                          ),
                        ),
                      ));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  width: Get.width * 0.45,
                  child: Text("Choose your interests"),
                ),
              ),
            ],
          ),
          SizedBox(
            height: Get.height * 0.012,
          ),
          SizedBox(
            width: Get.size.width,
            height: Get.size.height * 0.115,
            child: Obx(
              () => Wrap(
                alignment: WrapAlignment.start,
                children: [
                  for (var interest in interests)
                    FittedBox(
                      fit: BoxFit.contain,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        color: Colors.orange[900],
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
                ],
              ),
            ),
          ),
          SizedBox(height: Get.height * 0.06),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Get.defaultDialog(
                      title: "Personal Skills",
                      content: SizedBox(
                        height: Get.height * 0.7,
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
                      ));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  width: Get.width * 0.45,
                  child: Text("Choose your skills"),
                ),
              ),
            ],
          ),
          SizedBox(
            height: Get.height * 0.012,
          ),
          SizedBox(
            width: Get.size.width,
            height: Get.size.height * 0.1,
            child: Obx(
              () => Wrap(
                alignment: WrapAlignment.start,
                children: [
                  for (var skill in skills)
                    FittedBox(
                      fit: BoxFit.contain,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        color: Colors.orange[900],
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
                ],
              ),
            ),
          ),
          SizedBox(height: Get.height * 0.135),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () {
                    _registerTabController.controller.index = 1;
                  },
                  child: Text(
                    "Back",
                    style: TextStyle(color: Colors.orange[900], fontSize: 20),
                  )),
              SizedBox(
                width: 20,
              ),
              TextButton(
                  onPressed: () {
                    canProceed.value
                        ? authController.registerUser(
                            "${_nameController.text.trim()} ${_lastnameController.text.trim()}",
                            _emailController.text.trim(),
                            _passwordController.text.trim(),
                            gender.value,
                            dateOfBirth.value,
                            authController.profilePhoto,
                            interests.value,
                            skills.value,
                            countryName.value,
                            countryPhone.value,
                            countryFlagEmoji.value,
                            _phoneController.text.trim(),
                            profession.value,
                          )
                        : null;
                  },
                  child: Obx(
                    () => Text(
                      "Done",
                      style: TextStyle(color: canProceed.value ? Colors.orange[900] : Colors.grey, fontSize: 20),
                    ),
                  )),
            ],
          ),
        ],
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

class SignCredentialsPage1 extends StatelessWidget {
  SignCredentialsPage1({
    super.key,
    required TextEditingController nameController,
    required TextEditingController lastnameController,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required TextEditingController confirmPasswordController,
    required RegisterTabController registerTabController,
  })  : _nameController = nameController,
        _lastnameController = lastnameController,
        _emailController = emailController,
        _passwordController = passwordController,
        _confirmPasswordController = confirmPasswordController,
        _registerTabController = registerTabController;

  final TextEditingController _nameController;
  final TextEditingController _lastnameController;
  final TextEditingController _emailController;
  final TextEditingController _passwordController;
  final TextEditingController _confirmPasswordController;
  final RegisterTabController _registerTabController;
  final RxBool canProceed = false.obs;

  @override
  Widget build(BuildContext context) {
    if (_nameController.text.isNotEmpty &&
        _lastnameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _confirmPasswordController.text.isNotEmpty &&
        _passwordController.text == _confirmPasswordController.text) {
      canProceed.value = true;
    } else {
      canProceed.value = false;
    }
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: Get.height * 0.25,
            ),
            Image.asset(
              "assets/WeCare.png",
              width: Get.width * 0.7,
            ),
            SizedBox(
              height: Get.height * 0.15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: Get.height * 0.08,
                  width: Get.width * 0.42,
                  child: TextFormField(
                    controller: _nameController,
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      hintText: "Name",
                      hintStyle: TextStyle(
                        fontSize: 18,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(24)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.orange,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(24)),
                      ),
                      contentPadding: EdgeInsets.fromLTRB(Get.width * 0.05, Get.height * 0.015, 0, Get.height * 0.015),
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.08,
                  width: Get.width * 0.42,
                  child: TextFormField(
                    controller: _lastnameController,
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(Get.width * 0.05, Get.height * 0.015, 0, Get.height * 0.015),
                      fillColor: Colors.white,
                      hintText: "Surname",
                      hintStyle: TextStyle(
                        fontSize: 18,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(24)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(24)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Get.height * 0.08,
              width: Get.width * 0.9,
              child: TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  fillColor: Colors.white,
                  hintText: "Email",
                  hintStyle: TextStyle(
                    fontSize: 18,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(24)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(24)),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            SizedBox(
              height: Get.height * 0.08,
              width: Get.width * 0.9,
              child: TextFormField(
                obscureText: true,
                controller: _passwordController,
                keyboardType: TextInputType.visiblePassword,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  fillColor: Colors.white,
                  hintText: "Password",
                  hintStyle: TextStyle(
                    fontSize: 18,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(24)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(24)),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            SizedBox(
              height: Get.height * 0.08,
              width: Get.width * 0.9,
              child: TextFormField(
                obscureText: true,
                controller: _confirmPasswordController,
                keyboardType: TextInputType.visiblePassword,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  fillColor: Colors.white,
                  hintText: "Confirm Password",
                  hintStyle: TextStyle(
                    fontSize: 18,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(24)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(24)),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              TextButton(
                  onPressed: () => Get.back(),
                  child: Text(
                    "Already have an account?\nLogin instead",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.orange[900], fontSize: 15),
                  )),
            ]),
            SizedBox(
              height: Get.height * 0.01,
            ),
            TextButton(
                onPressed: () {
                  canProceed.value ? _registerTabController.controller.index = 1 : null;
                },
                child: Obx(
                  () => Text(
                    "Next",
                    style: TextStyle(color: canProceed.value ? Colors.orange[900] : Colors.grey, fontSize: 20),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

class SignCredentialsPage2 extends StatelessWidget {
  SignCredentialsPage2({
    super.key,
    required RxString gender,
    required Rx dateOfBirth,
    required TextEditingController phoneController,
    required RegisterTabController registerTabController,
    required RxString countryName,
    required RxString countryPhone,
    required RxString countryFlagEmoji,
  })  : gender = gender,
        dateOfBirth = dateOfBirth,
        _phoneController = phoneController,
        _registerTabController = registerTabController,
        countryName = countryName,
        countryPhone = countryPhone,
        countryFlagEmoji = countryFlagEmoji;

  final RxString gender;
  final Rx dateOfBirth;
  final TextEditingController _phoneController;
  final RegisterTabController _registerTabController;
  final RxString countryName;
  final RxString countryPhone;
  final RxString countryFlagEmoji;
  final RxBool canProceed = false.obs;

  @override
  Widget build(BuildContext context) {
    if (gender.value != "Gender" &&
        DateTime.now().difference(dateOfBirth.value).inDays > 6570 &&
        _phoneController.text.isNotEmpty) {
      canProceed.value = true;
    } else {
      canProceed.value = false;
    }
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: Get.height * 0.25,
            ),
            Image.asset(
              "assets/WeCare.png",
              width: Get.width * 0.7,
            ),
            SizedBox(
              height: Get.height * 0.14,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  width: Get.width * 0.55,
                  child: InkWell(
                    onTap: () async {
                      dateOfBirth.value = await showDatePicker(
                        initialDatePickerMode: DatePickerMode.year,
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.utc(1900, 1, 1),
                        lastDate: DateTime.now(),
                      );
                    },
                    child: Container(
                      height: 50,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Text("Birth Date: ",
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              )),
                          Obx(
                            () => Text(
                                dateOfBirth.value.day.toString().padLeft(2, "0") +
                                    "/" +
                                    dateOfBirth.value.month.toString().padLeft(2, "0") +
                                    "/" +
                                    dateOfBirth.value.year.toString() +
                                    " ",
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                )),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  width: Get.width * 0.25,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Obx(
                      () => DropdownButton<String>(
                        borderRadius: BorderRadius.circular(10),
                        dropdownColor: Colors.white,
                        underline: Container(),
                        hint: Text("${gender.value}",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w400)),
                        items: <String>["Male", "Female", "Other"].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.w400)),
                          );
                        }).toList(),
                        onChanged: (value) {
                          gender.value = value!;
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        fit: BoxFit.contain,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: InkWell(
                            onTap: () {
                              showCountryPicker(
                                context: context,
                                showPhoneCode: true,
                                onSelect: (Country country) {
                                  countryName.value = country.name;
                                  countryPhone.value = country.phoneCode;
                                  countryFlagEmoji.value = country.flagEmoji;
                                },
                                showSearch: true,
                              );
                            },
                            child: Center(
                              child: Obx(
                                () => Text("Country: ${countryName.value}",
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                    )),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            Row(
              children: [
                FittedBox(
                  fit: BoxFit.contain,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Obx(
                      () => Text(
                        "${countryFlagEmoji.value} +${countryPhone.value}",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: Get.width * 0.03,
                ),
                SizedBox(
                  height: Get.height * 0.051,
                  width: Get.width * 0.6,
                  child: TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      hintText: "Phone Number",
                      hintStyle: TextStyle(
                        fontSize: 18,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.orange,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(0)),
                      ),
                      contentPadding: EdgeInsets.fromLTRB(Get.width * 0.05, Get.height * 0.015, 0, Get.height * 0.015),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: Get.height * 0.22),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {
                      _registerTabController.controller.index = 0;
                    },
                    child: Text(
                      "Back",
                      style: TextStyle(color: Colors.orange[900], fontSize: 20),
                    )),
                SizedBox(
                  width: 20,
                ),
                TextButton(
                    onPressed: () {
                      canProceed.value ? _registerTabController.controller.index = 2 : null;
                    },
                    child: Obx(
                      () => Text(
                        "Next",
                        style: TextStyle(color: canProceed.value ? Colors.orange[900] : Colors.grey, fontSize: 20),
                      ),
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
