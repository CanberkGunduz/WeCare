import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gdsc_metu2023/events/screens/events_details.dart';
import 'package:gdsc_metu2023/events/tiles/event_tile.dart';
import 'package:geolocator/geolocator.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../events/model/event_model.dart';

class MapController extends GetxController {
  Rx<Position> _currentPosition = Position(
    latitude: 39.9128,
    longitude: 32.8090,
    accuracy: 0,
    altitude: 0,
    heading: 0,
    speed: 0,
    speedAccuracy: 0,
    timestamp: DateTime.now(),
  ).obs;

  Completer<GoogleMapController> googleMapController = Completer();

  Position get currentPosition => _currentPosition.value;
  Future<GoogleMapController> get gMapController async => await googleMapController.future;
  set currentPosition(Position value) => _currentPosition.value = value;

  @override
  void onReady() {
    super.onReady();
    try {
      getUserCurrentLocation().then((value) {
        _currentPosition = Rx(value);
      });
    } catch (e) {
      Get.snackbar("Error Getting Location", "Please check your location settings");
    }
  }

  Marker createMarker(Event event) {
    // var doc = [
    //   {'name': 'Marker 1', 'lat': 39.931069435, "lng": 32.847969568196184, "event": event},
    //   {
    //     'name': 'Marker 2',
    //     'lat': 39.87608997359908,
    //     'lng': 32.869549808521256,
    //   },
    //   {
    //     'name': 'Marker 3',
    //     'lat': 40.9788252637817,
    //     'lng': 29.09779102218368,
    //   },
    // ];
    return Marker(
      markerId: MarkerId(event.eventName),
      position: LatLng(event.eventLocation[0], event.eventLocation[1]),
      infoWindow: InfoWindow(title: event.eventName),
      onTap: () {
        Get.bottomSheet(Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          height: Get.height * 0.412,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Project Owner: ${event.username}",
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          "Participants: ${event.participants.length}/5",
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.share_outlined,
                              color: Colors.black,
                            )),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.bookmark_border_rounded,
                              color: Colors.black,
                            )),
                      ],
                    ),
                  ],
                ),
                EventTileBottomSheet(event: event),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 4,
                    ),
                    Expanded(
                      child: Text(
                        "event.eventDetailevent.eventDetailevent.eventDetailevent.eventDetailevent.eventDetailevent.eventDetailevent.eventDetailevent.eventDetailevent.eventDetailevent.eventDetailevent.eventDetailevent.eventDetailevent.eventDetailevent.eventDetailevent.eventDetail",
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          Get.to(() => EventsDetailsPage(event: event));
                        },
                        child: Text("Go to the project",
                            style: TextStyle(color: Colors.orange[900], fontSize: 14, fontWeight: FontWeight.w500)))
                  ],
                )
              ],
            ),
          ),
        ));
      },
    );
  }

  Future<void> gotoLocation(double lat, double long) async {
    GoogleMapController controller = await gMapController;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat, long),
      zoom: 15,
      tilt: 50.0,
      bearing: 45.0,
    )));
  }

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission().then((value) {}).onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print("ERROR" + error.toString());
    });
    return Geolocator.getCurrentPosition();
  }
}
