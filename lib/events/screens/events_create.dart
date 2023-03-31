import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location_picker_flutter_map/location_picker_flutter_map.dart';
import '../../constants.dart';
import '../controllers/event_controller.dart';

class EventCreateScreen extends StatelessWidget {
  EventCreateScreen({Key? key}) : super(key: key);

  final EventController eventController = Get.put(EventController());
  final TextEditingController _eventNameController = TextEditingController();
  final TextEditingController _eventDetailsController = TextEditingController();
  final RxList _eventLocationController = [].obs;
  final TextEditingController _eventActivitiesController = TextEditingController();
  final TextEditingController _eventGoalsController = TextEditingController();
  final TextEditingController _eventCategoriesController = TextEditingController();
  Rx<DateTime> date = DateTime.now().obs;
  Rx<TimeOfDay> time = TimeOfDay.now().obs;
  RxBool locPicked = false.obs;

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
                        _eventLocationController,
                        _eventGoalsController.text.split("\n"),
                        _eventActivitiesController.text.split("\n"),
                        _eventCategoriesController.text.split("\n"),
                        eventController.eventPhoto,
                        newDate,
                      );
                      if (created) {
                        _eventNameController.clear();
                        _eventDetailsController.clear();
                        _eventLocationController.clear();
                        _eventGoalsController.clear();
                        _eventActivitiesController.clear();
                        _eventCategoriesController.clear();
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
                        Text("Takes Place At: ${_eventLocationController[2]}"),
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
              SizedBox(height: 15),
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
                height: 15,
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
                  maxLines: 2,
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
                height: 15,
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
                  controller: _eventGoalsController,
                  maxLines: 2,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    hintText: "Goals",
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
                height: 15,
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
                  controller: _eventActivitiesController,
                  maxLines: 2,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    hintText: "Activities",
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
                height: 15,
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
                  controller: _eventCategoriesController,
                  maxLines: 2,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                  decoration: const InputDecoration(
                    fillColor: Colors.white,
                    hintText: "Categories",
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
                height: 15,
              ),
              InkWell(
                onTap: () {
                  Get.to(
                    () => Scaffold(
                      body: FlutterLocationPicker(
                        initZoom: 11,
                        minZoomLevel: 5,
                        maxZoomLevel: 16,
                        trackMyPosition: true,
                        searchBarBackgroundColor: Colors.white,
                        locationButtonBackgroundColor: Colors.orange[900],
                        zoomButtonsColor: Colors.white,
                        zoomButtonsBackgroundColor: Colors.orange[900],
                        mapLanguage: 'en',
                        onError: (e) => Get.snackbar(
                          "Error",
                          e.toString(),
                        ),
                        searchBarHintText: "Search Location",
                        selectLocationButtonStyle: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Colors.orange[900],
                          ),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        markerIconColor: Color.fromARGB(255, 230, 81, 0),
                        loadingWidget: const Center(
                          child: CircularProgressIndicator(),
                        ),
                        onPicked: (pickedData) {
                          locPicked.value = true;
                          print(pickedData.latLong.latitude.runtimeType);
                          print(pickedData.latLong.longitude.runtimeType);
                          print(pickedData.address.runtimeType);
                          print(pickedData.addressData['country'].runtimeType);
                          Get.defaultDialog(
                            title: "Event Location",
                            content: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                children: [
                                  Text(
                                    pickedData.address,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                ],
                              ),
                            ),
                            textConfirm: "Confirm",
                            textCancel: "Cancel",
                            confirmTextColor: Colors.white,
                            cancelTextColor: Colors.orange[900],
                            buttonColor: Colors.orange[900],
                            onConfirm: () {
                              _eventLocationController.addAll([
                                pickedData.latLong.latitude,
                                pickedData.latLong.longitude,
                                pickedData.address,
                                pickedData.addressData['country']
                              ]);
                              Get.back();
                              Get.back();
                              Get.snackbar("Location Chosen", "Location Chosen Successfully",
                                  snackPosition: SnackPosition.TOP,
                                  backgroundColor: Colors.green,
                                  colorText: Colors.white,
                                  duration: const Duration(seconds: 2));
                            },
                          );
                        },
                      ),
                    ),
                  );
                },
                child: Container(
                  width: Get.width,
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 15,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
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
                  child: Obx(
                    () => Text(
                        _eventLocationController.length == 0
                            ? "Event Location (Tap to choose)"
                            : _eventLocationController[2],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        )),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
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
                    time.value = (await showTimePicker(context: context, initialTime: TimeOfDay.now()))!;
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
                height: 15,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey),
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
                child: InkWell(
                  onTap: () async {
                    await eventController.pickImageGallery();
                  },
                  child: Icon(
                    Icons.camera_alt_outlined,
                    size: 36,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
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
                            _eventLocationController,
                            _eventGoalsController.text.split("\n"),
                            _eventActivitiesController.text.split("\n"),
                            _eventCategoriesController.text.split("\n"),
                            eventController.eventPhoto,
                            newDate,
                          );
                          if (created) {
                            _eventNameController.clear();
                            _eventDetailsController.clear();
                            _eventLocationController.clear();
                            _eventGoalsController.clear();
                            _eventActivitiesController.clear();
                            _eventCategoriesController.clear();
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
                            Text("Event Details: ${_eventDetailsController.text}"),
                            Text("Takes Place At: ${_eventLocationController[2]}"),
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
