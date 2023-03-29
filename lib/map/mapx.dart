import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  Future<LatLng> _getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    return LatLng(position.latitude, position.longitude);
  }

//solve current position problem
  Widget _buildGoogleMap(BuildContext context) {
    CameraPosition? cameraPosition;
    final MapController mapController =
        Get.put(MapController()); // create and register the controller
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(target: LatLng(1, 1), zoom: 12),
        onMapCreated: (GoogleMapController controller) {
          mapController.googleMapController.complete(controller);
        },
        onCameraMove: (CameraPosition cameraPositiona) {
          cameraPosition = cameraPositiona; //when map is dragging
        },
        onCameraIdle: () async {
          //when map drag stops
        },
        myLocationEnabled: true,
        markers: Set<Marker>.of(createMarkers()),
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
}

List<Marker> createMarkers() {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final CollectionReference collectionRef = firestore.collection('lab');
  List locs = [];
  collectionRef.get().then((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      // Document data is in doc.data()
      var data = doc.data();
      locs.add(data);
      print(locs);
    });
  }).catchError((error) {
    print('Error getting documents: $error');
  });
/*
  var doc = [
    {'name': 'Marker 1', 'lat': 37.77483, 'lng': -122.41942},
    {'name': 'Marker 2', 'lat': 37.78527, 'lng': -122.40617},
    {'name': 'Marker 3', 'lat': 37.76265, 'lng': -122.41417},
  ];

*/
  /*for (var i in locs) {
    var latlang = i['eventLocation'].split(',');
    i["lat"] = double.parse(latlang[0]);
    i["lng"] = double.parse(latlang[1]);
    print(latlang);
  }*/
  return locs
      .map((item) => Marker(
            markerId: MarkerId(item['eventName'] as String),
            position:
                LatLng(item["eventLocation"][0], item["eventLocation"][1]),
            infoWindow: InfoWindow(title: item['eventName'] as String),
          ))
      .toList();
}

Marker ankara = Marker(
  markerId: MarkerId('Çankaya Köşkü'),
  position: LatLng(39.88766486046114, 32.8651160404297),
  infoWindow: InfoWindow(title: 'Çankaya Köşkü'),
  icon: BitmapDescriptor.defaultMarkerWithHue(
    BitmapDescriptor.hueYellow,
  ),
);

class MapController extends GetxController {
  Completer<GoogleMapController> googleMapController = Completer();
}
