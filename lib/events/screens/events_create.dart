import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants.dart';
import '../controllers/event_controller.dart';

class EventCreateScreen extends StatelessWidget {
  EventCreateScreen({Key? key}) : super(key: key);

  final EventController eventController = Get.put(EventController());
  final TextEditingController _eventNameController = TextEditingController();
  final TextEditingController _eventDetailsController = TextEditingController();
  final TextEditingController _eventLocationController =
      TextEditingController();
  Rx<DateTime> date = DateTime.now().obs;
  Rx<TimeOfDay> time = TimeOfDay.now().obs;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.orange,
              size: 20,
            ),
          ),
          elevation: 0.4,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            "Create Event",
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                // fontStyle: FontStyle.italic,
                color: Colors.orange),
          ),
          actions: [
            TextButton(
              onPressed: () {
                try {
                  Get.defaultDialog(
                    title: "Create Post",
                    textConfirm: "Create",
                    buttonColor: Colors.orange,
                    textCancel: "Cancel",
                    cancelTextColor: Colors.orange,
                    confirmTextColor: Colors.white,
                    onConfirm: () async {
                      Get.back();
                      DateTime newDate = DateTime(
                        date.value.year,
                        date.value.month,
                        date.value.day,
                        time.value.hour,
                        time.value.minute,
                      );
                      bool created = await eventController.createEvent(
                        _eventNameController.text,
                        _eventDetailsController.text,
                        _eventLocationController.text,
                        newDate,
                      );
                      if (created) {
                        _eventNameController.clear();
                        _eventDetailsController.clear();
                        _eventLocationController.clear();
                        FocusScope.of(context).unfocus();
                      }
                    },
                    content: Column(
                      children: [
                        Text(
                          "Are you sure you want to create this post?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text("Event Name: ${_eventNameController.text}"),
                        Text("Event Details: ${_eventDetailsController.text}"),
                        Text(
                            "Takes Place At: ${_eventLocationController.text}"),
                      ],
                    ),
                  );
                } catch (e) {
                  Get.snackbar(
                    "Error Submitting",
                    "Please pick an Image",
                    backgroundColor: Colors.grey,
                  );
                }
              },
              child: Text(
                "Post",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.orange,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.grey[200],
        body: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: 25),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: TextFormField(
                  controller: _eventNameController,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    hintText: "Event Name",
                    hintStyle: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(0)),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: TextFormField(
                  controller: _eventDetailsController,
                  maxLines: 4,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    hintText: "Event Details",
                    hintStyle: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(0)),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: TextFormField(
                  controller: _eventLocationController,
                  maxLines: 4,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    hintText: "Event Location",
                    hintStyle: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(0)),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: InkWell(
                  onTap: () async {
                    date.value = (await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 90)),
                    ))!;
                    time.value = (await showTimePicker(
                        context: context, initialTime: TimeOfDay.now()))!;
                  },
                  child: Container(
                    height: 50,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Text("Date: ",
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            )),
                        Obx(
                          () => Text(
                              date.value.day.toString().padLeft(2, "0") +
                                  "/" +
                                  date.value.month.toString().padLeft(2, "0") +
                                  "/" +
                                  date.value.year.toString() +
                                  " " +
                                  time.value.hour.toString().padLeft(2, "0") +
                                  ":" +
                                  time.value.minute.toString().padLeft(2, "0"),
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
              SizedBox(
                height: 25,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: TextButton(
                  child: const Icon(
                    Icons.add,
                    size: 36,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    try {
                      FocusScope.of(context).unfocus();
                      Get.defaultDialog(
                        backgroundColor: Colors.white,
                        title: "Create Event",
                        textConfirm: "Create",
                        confirmTextColor: Colors.white,
                        textCancel: "Cancel",
                        cancelTextColor: Colors.orange,
                        buttonColor: Colors.orange,
                        onConfirm: () async {
                          Get.back();
                          DateTime newDate = DateTime(
                            date.value.year,
                            date.value.month,
                            date.value.day,
                            time.value.hour,
                            time.value.minute,
                          );
                          bool created = await eventController.createEvent(
                            _eventNameController.text,
                            _eventDetailsController.text,
                            _eventLocationController.text,
                            newDate,
                          );
                          if (created) {
                            _eventNameController.clear();
                            _eventDetailsController.clear();
                            _eventLocationController.clear();
                            FocusScope.of(context).unfocus();
                          }
                          // Get.back();
                        },
                        content: Column(
                          children: [
                            Text(
                              "Are you sure you want to create this post?",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text("Event Name: ${_eventNameController.text}"),
                            Text(
                                "Event Details: ${_eventDetailsController.text}"),
                            Text(
                                "Takes Place At: ${_eventLocationController.text}"),
                          ],
                        ),
                      );
                    } catch (e) {
                      Get.snackbar(
                        "Error",
                        e.toString(),
                        backgroundColor: Colors.grey,
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
