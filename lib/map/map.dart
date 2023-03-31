import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'map_controller.dart';

class MapWidget extends StatelessWidget {
  MapWidget({super.key});

  final MapController mapController = Get.put(MapController());
  double zoomVal = 5.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
            target: LatLng(mapController.currentPosition.latitude, mapController.currentPosition.longitude),
            zoom: 14.4746,
          ),
          onMapCreated: (GoogleMapController controller) {
            mapController.googleMapController.complete(controller);
          },
          myLocationEnabled: true,
          markers: Set<Marker>.of(createMarkers()),
        ),
      ),
    );
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
