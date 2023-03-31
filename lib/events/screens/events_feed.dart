import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:gdsc_metu2023/events/controllers/event_controller.dart';
import 'package:gdsc_metu2023/events/tiles/event_tile.dart';
import 'package:get/get.dart';

class EventFeed extends StatelessWidget {
  EventFeed({super.key});

  EventController eventController = Get.put(EventController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              color: Colors.grey,
            ),
          )
        ],
        title: Image.asset(
          "assets/WeCare.png",
          width: Get.width * 0.4,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    FilterCard(text: "Animal Shelter", isEnabled: false.obs),
                    FilterCard(text: "Walk with Disabled Individuals", isEnabled: false.obs),
                    FilterCard(text: "Child Care Project", isEnabled: false.obs),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "  Urgent",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 5,
            ),
            SizedBox(
              width: Get.width,
              height: Get.height * 0.14,
              child: ListView.builder(
                  itemCount: eventController.eventList[4].length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final event = eventController.eventList[4][index];
                    print(eventController.eventList[4][index]);
                    return EventTileUrgent(event: event);
                  }),
            ),
            SizedBox(
              height: 5,
            ),
            Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.sort_rounded,
                      color: Colors.black,
                    )),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.filter_alt_rounded,
                      color: Colors.black87,
                    )),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            eventController.eventList[0].length == 0
                ? Center(
                    child: Text(
                      "There are no events at the moment.",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 24,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                : ListView.builder(
                    itemCount: eventController.eventList[0].length,
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final event = eventController.eventList[0][index];
                      return EventTileWithCategories(event: event);
                    }),
          ],
        ),
      ),
    );
  }
}

class FilterCard extends StatelessWidget {
  FilterCard({
    required this.text,
    required this.isEnabled,
    super.key,
  });

  final String text;
  RxBool isEnabled;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => isEnabled.value = !isEnabled.value,
      child: Obx(
        () => Card(
          color: isEnabled.value ? Colors.orange[900] : Colors.grey[400],
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Text(
              text,
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),
    );
  }
}
