import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../controllers/homepage_controller.dart';

class Homepage extends StatelessWidget {
  final LatLng _center = const LatLng(45.521563, -122.677433);
  final HomeController _homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(backgroundColor: Colors.grey[200],),
        Row(children: [
      Column(
        children: [
          Container(width: Get.size.width*0.8,height: Get.size.height*0.1,),
        ],
      ),
      Column(
        children: [
          Container(width: Get.size.width*0.2,height: Get.size.height*0.1,child: Image.asset("assets/placeholder.png",fit: BoxFit.contain,),
      )]
      ),
    ],)],);
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
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
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
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
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
                      Text("Name Surname",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400)),
                      Text("Birth Date",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400)),
                      SizedBox(height: 16),
                      Text("Score:",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400)),
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
                  Text("12 Friends",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
                ],
              ),
              SizedBox(height: 16),
              Text("Interests",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
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
              Text("Able To Teach",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
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
        title: const Text("GDSC 2023",
            style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.w400)),
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
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
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
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
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
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
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
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
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
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
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
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
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
