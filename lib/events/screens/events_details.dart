import 'package:flutter/material.dart';
import 'package:gdsc_metu2023/events/controllers/event_controller.dart';
import 'package:gdsc_metu2023/events/controllers/event_details_controller.dart';
import 'package:get/get.dart';
import '../controllers/event_comment_controller.dart';
import '../model/event_model.dart';

class EventsDetailsPage extends StatelessWidget {
  Event event;
  EventsDetailsPage({Key? key, required this.event}) : super(key: key);

  EventDetailsTabController myTabController = Get.put(EventDetailsTabController());
  EventController eventController = Get.put(EventController());
  EventCommentController commentController = Get.put(EventCommentController());
  TextEditingController _commentController = TextEditingController();
  TextEditingController _reportController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    commentController.updatePostId(event.id);
    List goals = [
      "To help atleast 100 children",
      "To increase the education and awareness levels of volunteers",
      "To carry out activities aimed at improving children's academic success"
    ];
    List activities = [
      "Playing with children and participating in their activities",
      "Meeting the daily needs of children (nutrition, hygiene, etc.)",
      "Working to improve children's academic success in school",
      "Organizing training to increase the education and awareness levels volunteers"
    ];
    List categories = [
      "About",
      "Speakers",
      "Location",
      "Scheduleeeeeeeeeeeeeeeeeee",
      "About",
      "Speakers",
      "Location",
      "Scheduleeeeeeeeeeeeeeeeeee",
    ];
    DateTime date = event.eventDate.toDate();
    String dateStr =
        "${date.day.toString().padLeft(2, "0")}/${date.month.toString().padLeft(2, "0")}/${date.year.toString().padLeft(2, "0")}";
    String timeStr = "${date.hour.toString().padLeft(2, "0")}:${date.minute.toString().padLeft(2, "0")}";
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.grey[200],
              centerTitle: true,
              title: Text(
                event.eventName,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: () => Get.back(),
              )),
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                        child: Column(
                          children: [
                            Container(
                              height: Get.size.height * 0.23,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  "assets/placeholder.png",
                                  fit: BoxFit.cover,
                                  // loadingBuilder: (BuildContext context, Widget child,
                                  //     ImageChunkEvent? loadingProgress) {
                                  //   if (loadingProgress == null) return child;
                                  //   return Center(
                                  //     child: CircularProgressIndicator(
                                  //       value: loadingProgress.expectedTotalBytes != null
                                  //           ? loadingProgress.cumulativeBytesLoaded /
                                  //               loadingProgress.expectedTotalBytes!
                                  //           : null,
                                  //     ),
                                  //   );
                                  // },
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(event.eventName,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                )),
                            SizedBox(height: 5),
                            Text(
                              "Project Owner: ${event.username}",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Categories",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    SizedBox(
                                      width: Get.size.width * 0.9,
                                      // height: Get.size.height * 0.13,
                                      child: Wrap(
                                        alignment: WrapAlignment.center,
                                        children: [
                                          for (var category in categories)
                                            FittedBox(
                                              fit: BoxFit.contain,
                                              child: Card(
                                                color: Colors.grey,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(4.0),
                                                  child: Text(
                                                    category,
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
                                      // child: GridView.extent(
                                      //   shrinkWrap: true,
                                      //   maxCrossAxisExtent: 250,
                                      //   crossAxisSpacing: 1,
                                      //   mainAxisSpacing: 1,
                                      //   // childAspectRatio: 5,
                                      //   children: categories.map((category) {
                                      //     return FittedBox(
                                      //       fit: BoxFit.contain,
                                      //       child: Card(
                                      //         color: Colors.grey,
                                      //         child: Padding(
                                      //           padding: const EdgeInsets.all(4.0),
                                      //           child: Text(
                                      //             category,
                                      //             textAlign: TextAlign.center,
                                      //             style: TextStyle(
                                      //               color: Colors.white,
                                      //               fontWeight: FontWeight.w300,
                                      //             ),
                                      //           ),
                                      //         ),
                                      //       ),
                                      //     );
                                      //   }).toList(),
                                      // ),
                                      // child: GridView.builder(
                                      //   shrinkWrap: true,
                                      //   gridDelegate:
                                      //       SliverGridDelegateWithMaxCrossAxisExtent(
                                      //     mainAxisExtent: 30,
                                      //     maxCrossAxisExtent: 250,
                                      //     crossAxisSpacing: 1, // Spacing between columns
                                      //     mainAxisSpacing: 1, // Spacing between rows
                                      //   ),
                                      //   itemCount:
                                      //       categories.length, // Number of grid items
                                      //   itemBuilder: (BuildContext context, int index) {
                                      //     return FittedBox(
                                      //       fit: BoxFit.contain,
                                      //       child: Card(
                                      //         color: Colors.grey,
                                      //         child: Padding(
                                      //           padding: const EdgeInsets.all(4.0),
                                      //           child: Text(
                                      //             categories[index],
                                      //             textAlign: TextAlign.center,
                                      //             style: TextStyle(
                                      //               color: Colors.white,
                                      //               fontWeight: FontWeight.w300,
                                      //             ),
                                      //           ),
                                      //         ),
                                      //       ),
                                      //     );
                                      //     // return Container(
                                      //     //   alignment: Alignment.center,
                                      //     //   decoration: BoxDecoration(
                                      //     //     color: Colors.grey,
                                      //     //     borderRadius: BorderRadius.circular(5),
                                      //     //   ),
                                      //     //   child: Center(
                                      //     //     child: Padding(
                                      //     //       padding: const EdgeInsets.all(8.0),
                                      //     //       child: Text(
                                      //     //         categories[index],
                                      //     //         textAlign: TextAlign.center,
                                      //     //         style: TextStyle(
                                      //     //           color: Colors.white,
                                      //     //           fontWeight: FontWeight.w300,
                                      //     //         ),
                                      //     //       ),
                                      //     //     ),
                                      //     //   ),
                                      //     // );
                                      //   },
                                      // ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Project Brief",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      event.eventDetail,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.calendar_month,
                                      size: 36,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      timeStr + " " + dateStr,
                                      style: TextStyle(fontSize: 16),
                                    )
                                  ],
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.orange),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Add to Calendar  +",
                                        style: TextStyle(color: Colors.orange),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on_sharp,
                                      size: 36,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      event.eventLocation,
                                      style: TextStyle(fontSize: 16),
                                    )
                                  ],
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                      padding: EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.orange),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Icon(
                                        Icons.directions,
                                        size: 30,
                                        color: Colors.orange,
                                      )),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Stack(children: [
                              TabBar(
                                  indicatorPadding: EdgeInsets.symmetric(vertical: 8),
                                  indicator: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                    color: Colors.orange[900],
                                  ),
                                  isScrollable: true,
                                  controller: myTabController.controller,
                                  tabs: [
                                    Container(
                                      alignment: Alignment.center,
                                      child: Tab(
                                        child: Text(
                                          "Goals",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      child: Tab(
                                        child: Text(
                                          "Activities",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      child: Tab(
                                        child: Text(
                                          "Participants",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      child: Tab(
                                        child: Text(
                                          "Comments",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]),
                              Positioned(
                                  left: 0,
                                  right: 0,
                                  bottom: 0,
                                  child: Divider(
                                    color: Colors.orange[900],
                                    thickness: 3,
                                  ))
                            ]),
                            // Divider(
                            //   color: Colors.orange[900],
                            //   thickness: 8,
                            //   height: 0,
                            // ),
                            SizedBox(height: 5),
                            SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              child: Container(
                                // color: Colors.green,
                                height: Get.size.height * 0.4,
                                child: TabBarView(controller: myTabController.controller, children: [
                                  GoalsTab(goals: goals),
                                  ActivitiesTab(activities: activities),
                                  ParticipantsTab(),
                                  CommentsTab(
                                      commentController: commentController, commentController2: _commentController),
                                ]),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Container(
                    height: 40,
                    width: Get.size.width * 0.5,
                    child: ElevatedButton(
                      onPressed: () {
                        eventController.joinEvent(event.id);
                      },
                      child: Text("Join",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          )),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange[900],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(36),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.orange[900],
                      shape: BoxShape.circle,
                      // borderRadius: BorderRadius.circular(10),
                    ),
                    height: 40,
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.share_outlined),
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.orange[900],
                      shape: BoxShape.circle,
                      // borderRadius: BorderRadius.circular(10),
                    ),
                    height: 40,
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.favorite_border_outlined),
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.orange[900],
                      shape: BoxShape.circle,
                      // borderRadius: BorderRadius.circular(10),
                    ),
                    height: 40,
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.bookmark_border_rounded),
                      color: Colors.white,
                    ),
                  ),
                ]),
              ),
            ],
          )),
    );
  }

  Column ParticipantsTab() {
    return Column(
      children: [
        ListView.builder(
          shrinkWrap: true,
          itemCount: event.participants.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(event.participants[index]["profilePhoto"]),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        event.participants[index]["name"],
                        style: TextStyle(color: Colors.black, fontSize: 12),
                      ),
                    ],
                  ),
                  Text(
                    "Score: ${event.participants[index]["score"].toString()}",
                    style: TextStyle(color: Colors.black, fontSize: 12),
                  )
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

class CommentsTab extends StatelessWidget {
  const CommentsTab({
    super.key,
    required this.commentController,
    required TextEditingController commentController2,
  }) : _commentController = commentController2;

  final EventCommentController commentController;
  final TextEditingController _commentController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: Get.size.height * 0.3,
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: commentController.comments.length,
            itemBuilder: (context, index) {
              final comment = commentController.comments[index];
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 28,
                              backgroundImage: NetworkImage(comment.profilePhoto),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    comment.username,
                                    style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    comment.comment,
                                    style: TextStyle(color: Colors.black, fontSize: 12),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                ],
              );
            },
          ),
        ),
        SizedBox(
          height: 10,
        ),
        TextFormField(
          style: TextStyle(color: Colors.black),
          maxLines: 5,
          minLines: 1,
          controller: _commentController,
          decoration: InputDecoration(
            labelStyle: TextStyle(color: Colors.black),
            hintText: "Comment",
            hintStyle: TextStyle(
              color: Colors.black,
              fontSize: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.orange,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.orange,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Colors.orange,
              ),
            ),
            suffixIcon: IconButton(
              onPressed: () {
                FocusScope.of(context).unfocus();
                if (_commentController.text.isNotEmpty) {
                  commentController.postComment(_commentController.text);
                  _commentController.clear();
                }
              },
              icon: Icon(
                Icons.send,
                color: Colors.orange,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ActivitiesTab extends StatelessWidget {
  const ActivitiesTab({
    super.key,
    required this.activities,
  });

  final List activities;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        children: [
          for (var activity in activities)
            Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.circle,
                      size: 4,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        activity,
                        style: TextStyle(color: Colors.black, fontSize: 12),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class GoalsTab extends StatelessWidget {
  const GoalsTab({
    super.key,
    required this.goals,
  });

  final List goals;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          for (var goal in goals)
            Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.circle,
                      size: 4,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        goal,
                        style: TextStyle(color: Colors.black, fontSize: 12),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
        ],
      ),
    );
  }
}
