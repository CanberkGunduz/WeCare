import 'package:flutter/material.dart';
import 'package:gdsc_metu2023/events/screens/events_details.dart';
import 'package:get/get.dart';

import '../model/event_model.dart';

class EventTile extends StatelessWidget {
  Event event;
  EventTile({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    DateTime date = event.eventDate.toDate();
    String dateStr =
        "${date.day.toString().padLeft(2, "0")}/${date.month.toString().padLeft(2, "0")}/${date.year.toString().padLeft(2, "0")} ${date.hour.toString().padLeft(2, "0")}:${date.minute.toString().padLeft(2, "0")}";
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: FittedBox(
        fit: BoxFit.contain,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          // height: size.height * 0.15,
          width: size.width * 0.9,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 3,
                blurRadius: 5,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    event.eventPhoto,
                    fit: BoxFit.cover,
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
                // child: Image.asset(
                //   "assets/placeholder.png",

                width: size.width * 0.3,

                // ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 7),
                    Text(
                      event.eventName,
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          color: Colors.grey,
                          size: 16,
                        ),
                        SizedBox(width: 5),
                        Text(
                          dateStr,
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.grey,
                          size: 16,
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            event.eventLocation[2],
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                            // maxLines: 3,
                            // overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class EventTileUrgent extends StatelessWidget {
  Event event;
  EventTileUrgent({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    DateTime date = event.eventDate.toDate();
    String dateStr =
        "${date.hour.toString().padLeft(2, "0")}:${date.minute.toString().padLeft(2, "0")}, ${DateTime.now().day == date.day ? "Today" : "Tomorrow"}";
    return GestureDetector(
      onTap: () {
        Get.to(() => EventsDetailsPage(event: event));
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 6),
        child: FittedBox(
          fit: BoxFit.contain,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            // height: size.height * 0.15,
            width: size.width * 0.35,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.orange, width: 1),
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 0.5,
                  blurRadius: 1,
                  offset: Offset(0, 0),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      event.eventPhoto,
                      fit: BoxFit.cover,
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
                  // child: Image.asset(
                  //   "assets/placeholder.png",

                  width: size.width * 0.1,

                  // ),
                ),
                SizedBox(width: 7),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        event.eventName,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 8, color: Colors.black, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 2),
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            color: Colors.grey,
                            size: 10,
                          ),
                          SizedBox(width: 2),
                          Text(
                            dateStr,
                            style: TextStyle(fontSize: 8, color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EventTileWithCategories extends StatelessWidget {
  Event event;
  EventTileWithCategories({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List categories = event.categories;
    Size size = MediaQuery.of(context).size;
    DateTime date = event.eventDate.toDate();
    String dateStr =
        "${date.hour.toString().padLeft(2, "0")}:${date.minute.toString().padLeft(2, "0")} ${date.day.toString().padLeft(2, "0")}.${date.month.toString().padLeft(2, "0")}.${date.year.toString().padLeft(2, "0")}";
    return GestureDetector(
      onTap: () => Get.to(() => EventsDetailsPage(
            event: event,
          )),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(12, 4, 12, 0),
            child: FittedBox(
              fit: BoxFit.contain,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                // height: size.height * 0.15,
                width: size.width * 0.95,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              event.eventPhoto,
                              fit: BoxFit.cover,
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
                          // child: Image.asset(
                          //   "assets/placeholder.png",

                          width: size.width * 0.3,

                          // ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 7),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      event.eventName,
                                      style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  InkWell(
                                      onTap: () {},
                                      child: Icon(Icons.more_vert_rounded, color: Colors.grey[850], size: 20)),
                                ],
                              ),
                              SizedBox(height: 5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    Icons.calendar_today,
                                    color: Colors.grey[850],
                                    size: 16,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    dateStr,
                                    style: TextStyle(fontSize: 14, color: Colors.grey[850]),
                                  ),
                                  SizedBox(width: 10),
                                  SizedBox(
                                    height: 25,
                                    width: 60,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Get.to(() => EventsDetailsPage(
                                              event: event,
                                            ));
                                      },
                                      child: Text(
                                        "Join",
                                        style: TextStyle(fontSize: 14, color: Colors.white),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.orange[800],
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(48)),
                                          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 2)),
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                ],
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: Colors.grey[850],
                                    size: 16,
                                  ),
                                  SizedBox(width: 5),
                                  Expanded(
                                    child: Text(
                                      event.eventLocation[2],
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 14, color: Colors.grey[850]),
                                      // maxLines: 3,
                                      // overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
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
                              for (var category in categories.sublist(0, categories.length > 2 ? 2 : categories.length))
                                FittedBox(
                                  fit: BoxFit.contain,
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    color: Colors.grey[600],
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
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
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Divider(
            color: Colors.grey,
            thickness: 1,
          ),
        ],
      ),
    );
  }
}
