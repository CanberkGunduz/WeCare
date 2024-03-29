import 'package:flutter/material.dart';
import 'package:gdsc_metu2023/calendar/screens/calendarpage.dart';
import 'package:gdsc_metu2023/constants.dart';
import 'package:gdsc_metu2023/events/screens/events_feed.dart';
import 'package:gdsc_metu2023/map/map.dart';
import 'package:gdsc_metu2023/profile_screen.dart';
import 'package:get/get.dart';
import '../../authentication/user_model.dart';
import '../controllers/homepage_controller.dart';

class Homepage extends StatelessWidget {
  final HomeController _homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    // authController.setUserData();
    User user = authController.user;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Image.asset(
            "assets/WeCare.png",
            width: Get.width * 0.4,
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          // actions: [
          //   IconButton(
          //       onPressed: () {},
          //       icon: Icon(
          //         Icons.person,
          //         color: Colors.orange[900],
          //         size: 42,
          //       )),
          //   SizedBox(
          //     width: 10,
          //   ),
          // ],
        ),
        body: Stack(
          children: [
            MapWidget(),
            // Positioned(
            //   child: Container(
            //     decoration: BoxDecoration(
            //       color: Color.fromARGB(255, 247, 247, 247),
            //       borderRadius: BorderRadius.circular(64),
            //       // shape: BoxShape.circle,
            //       border: Border.all(
            //         color: Colors.orange,
            //         width: 2,
            //       ),
            //     ),
            //     child: ClipOval(
            //       child: Image.asset(
            //         "assets/logo.png",
            //         width: Get.width * 0.15,
            //       ),
            //     ),
            //   ),
            //   top: Get.height * 0.01,
            //   left: Get.width * 0.02,
            // ),
            // Row(
            //   children: [
            //     Padding(
            //       padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            //       child: InkWell(
            //           onTap: () => Get.to(() => ProfileScreen(
            //                 user: user,
            //               )),
            //           child: Container(
            //             decoration: BoxDecoration(
            //               shape: BoxShape.circle,
            //               border: Border.all(
            //                 color: Colors.orange,
            //                 width: 2,
            //               ),
            //             ),
            //             child: ClipOval(
            //               child: CircleAvatar(
            //                 backgroundColor: Colors.grey[300],
            //                 radius: 36,
            //                 child: Image.network(
            //                   user.profilePhoto,
            //                   fit: BoxFit.contain,
            //                   loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
            //                     if (loadingProgress == null) return child;
            //                     return Center(
            //                       child: CircularProgressIndicator(
            //                         value: loadingProgress.expectedTotalBytes != null
            //                             ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
            //                             : null,
            //                       ),
            //                     );
            //                   },
            //                 ),
            //               ),
            //             ),
            //           )),
            //     ),
            //     Image.asset(
            //       "assets/WeCare.png",
            //       width: Get.width * 0.6,
            //     ),
            //   ],
            // ),
            Positioned(
              bottom: Get.size.height * 0.13,
              right: Get.size.width * 0.02,
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    color: Color.fromARGB(255, 239, 108, 0),
                    width: 2,
                  ),
                ),
                child: IconButton(
                  onPressed: () {
                    Get.to(() => CalendarPage(),
                        duration: Duration(milliseconds: 500), transition: Transition.topLevel);
                  },
                  icon: Icon(
                    Icons.edit_calendar_rounded,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class notif_messages_view extends StatelessWidget {
  const notif_messages_view({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 30,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.black),
                      ),
                    ),
                    child: Text(
                      "Messages",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                    ),
                  ),
                  Container(
                    height: 30,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.black),
                      ),
                    ),
                    child: Text(
                      "Notifications",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32),
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Container(
                      height: 60,
                      width: Get.width * 0.85,
                      color: Colors.grey[300],
                    ),
                    SizedBox(height: 32),
                    Container(
                      height: 60,
                      width: Get.width * 0.85,
                      color: Colors.grey[300],
                    ),
                    SizedBox(height: 32),
                    Container(
                      height: 60,
                      width: Get.width * 0.85,
                      color: Colors.grey[300],
                    ),
                    SizedBox(height: 32),
                    Container(
                      height: 60,
                      width: Get.width * 0.85,
                      color: Colors.grey[300],
                    ),
                    SizedBox(height: 32),
                    Container(
                      height: 60,
                      width: Get.width * 0.85,
                      color: Colors.grey[300],
                    ),
                    SizedBox(height: 32),
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

class profile_view extends StatelessWidget {
  const profile_view({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 0, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.grey[400],
                    backgroundImage: AssetImage("assets/placeholder.png"),
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Name Surname", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
                      Text("Birth Date", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
                      SizedBox(height: 16),
                      Text("Score:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
                    ],
                  ),
                  SizedBox(width: 36),
                  Column(
                    children: [
                      IconButton(onPressed: () {}, icon: Icon(Icons.close)),
                      SizedBox(height: 72),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  SizedBox(width: 16),
                  Text("12 Friends", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
                ],
              ),
              SizedBox(height: 16),
              Text("Interests", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
              SizedBox(height: 16),
              Container(
                height: Get.height * 0.18,
                width: Get.width * 0.28,
                child: Column(
                  children: [
                    Card(
                      color: Colors.grey[200],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Container(
                          height: 35,
                          width: 110,
                          child: Center(
                              child: Text(
                            "Interest 1",
                            style: TextStyle(fontSize: 16),
                          ))),
                    ),
                    Card(
                      color: Colors.grey[200],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Container(
                          height: 35,
                          width: 110,
                          child: Center(
                              child: Text(
                            "Interest 2",
                            style: TextStyle(fontSize: 16),
                          ))),
                    ),
                    Card(
                      color: Colors.grey[200],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Container(
                          height: 35,
                          width: 110,
                          child: Center(
                              child: Text(
                            "Interest 3",
                            style: TextStyle(fontSize: 16),
                          ))),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Text("Able To Teach", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
              SizedBox(height: 16),
              Container(
                height: Get.height * 0.3,
                width: Get.width * 0.28,
                child: Column(
                  children: [
                    Card(
                      color: Colors.grey[200],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Container(
                          height: 35,
                          width: 110,
                          child: Center(
                              child: Text(
                            "Topic 1",
                            style: TextStyle(fontSize: 16),
                          ))),
                    ),
                    Card(
                      color: Colors.grey[200],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Container(
                          height: 35,
                          width: 110,
                          child: Center(
                              child: Text(
                            "Topic 2",
                            style: TextStyle(fontSize: 16),
                          ))),
                    ),
                    Card(
                      color: Colors.grey[200],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Container(
                          height: 35,
                          width: 110,
                          child: Center(
                              child: Text(
                            "Topic 3",
                            style: TextStyle(fontSize: 16),
                          ))),
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

class main_home_view extends StatelessWidget {
  const main_home_view({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          color: Colors.grey,
          icon: const Icon(
            Icons.person,
            size: 36,
          ),
          onPressed: () {},
        ),
        centerTitle: true,
        title:
            const Text("GDSC 2023", style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.w400)),
        actions: [
          IconButton(
            color: Colors.grey,
            icon: const Icon(
              Icons.mail,
              size: 36,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[400],
                //  boxShadow: [
                //    BoxShadow(
                //      color: Colors.grey.withOpacity(0.5),
                //      spreadRadius: 5,
                //      blurRadius: 7,
                //      offset: const Offset(0, 3), // changes position of shadow
                //    ),
                //  ],
              ),
              height: Get.size.height * 0.25,
              width: Get.size.width,
              child: Center(
                  child: Text(
                "Welcome, Username",
                style: TextStyle(fontSize: 20, color: Colors.black),
              )),
            ),
            Container(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 70,
                          width: 110,
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                          ),
                          child: Center(
                            child: Text(
                              "Rest Home",
                              style: TextStyle(fontSize: 20, color: Colors.black),
                            ),
                          ),
                        ),
                        Container(
                          height: 70,
                          width: 110,
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                          ),
                          child: Center(
                            child: Text(
                              "Shelter",
                              style: TextStyle(fontSize: 20, color: Colors.black),
                            ),
                          ),
                        ),
                        Container(
                          height: 70,
                          width: 110,
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                          ),
                          child: Center(
                            child: Text(
                              "Garbage",
                              style: TextStyle(fontSize: 20, color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 70,
                          width: 110,
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                          ),
                          child: Center(
                            child: Text(
                              "Rest Home",
                              style: TextStyle(fontSize: 20, color: Colors.black),
                            ),
                          ),
                        ),
                        Container(
                          height: 70,
                          width: 110,
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                          ),
                          child: Center(
                            child: Text(
                              "Rest Home",
                              style: TextStyle(fontSize: 20, color: Colors.black),
                            ),
                          ),
                        ),
                        Container(
                          height: 70,
                          width: 110,
                          decoration: BoxDecoration(
                            color: Colors.grey[400],
                          ),
                          child: Center(
                            child: Text(
                              "Rest Home",
                              style: TextStyle(fontSize: 20, color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
