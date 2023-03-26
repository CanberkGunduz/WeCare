import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeController extends GetxController {
  late GoogleMapController mapController;

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future moveCamera(Future<LatLng> location) async {
    await mapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: await location,
        zoom: 14.0,
      ),
    ));
  }
}

