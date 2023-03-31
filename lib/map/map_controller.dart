import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
