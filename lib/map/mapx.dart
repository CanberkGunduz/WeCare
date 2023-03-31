import 'dart:async';
import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart';

class Map extends GetWidget<MapController> {
  double zoomVal = 5.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _buildGoogleMap(context),
          //_buildContainer(),
        ],
      ),
    );
  }

  static const CameraPosition _kGoogle = CameraPosition(
    target: LatLng(20.42796133580664, 80.885749655962),
    zoom: 14.4746,
  );
  @override
  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print("ERROR" + error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }
//solve current position problem

  @override
  Widget _buildGoogleMap(BuildContext context) {
    final MapController mapController =
        Get.put(MapController()); // create and register the controller
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGoogle,
        onMapCreated: (GoogleMapController controller) {
          mapController.googleMapController.complete(controller);
        },
        myLocationEnabled: true,
        markers: Set<Marker>.of(createMarkers()),
        zoomControlsEnabled: false,
      ),
    );
  }

  Future<void> _gotoLocation(double lat, double long) async {
    final MapController mapController =
        Get.put(MapController()); // create and register the controller
    final GoogleMapController controller =
        await mapController.googleMapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat, long),
      zoom: 15,
      tilt: 50.0,
      bearing: 45.0,
    )));
  }

  List<Marker> createMarkers() {
    var doc = [
      {'name': 'Marker 1', 'lat': 37.77483, 'lng': -122.41942},
      {'name': 'Marker 2', 'lat': 37.78527, 'lng': -122.40617},
      {'name': 'Marker 3', 'lat': 37.76265, 'lng': -122.41417},
    ];
    return doc
        .map((item) => Marker(
              markerId: MarkerId(item['name'] as String),
              position: LatLng(item["lat"] as double, item["lng"] as double),
              infoWindow: InfoWindow(title: item['name'] as String),
              onTap: () {},
            ))
        .toList();
  }

  Marker ankara = Marker(
      markerId: MarkerId('Çankaya Köşkü'),
      position: LatLng(39.88766486046114, 32.8651160404297),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueYellow,
      ),
      onTap: () {});
}

class MapController extends GetxController {
  Completer<GoogleMapController> googleMapController = Completer();
}
