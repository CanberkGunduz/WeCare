import 'package:flutter/material.dart';
import 'package:gdsc_metu2023/events/model/event_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../events/controllers/event_controller.dart';
import 'map_controller.dart';

class MapWidget extends StatelessWidget {
  MapWidget({super.key});

  final MapController mapController = Get.put(MapController());
  EventController eventController = Get.find();
  double zoomVal = 5.0;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
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
            markers: eventController.eventList.isEmpty
                ? <Marker>{}
                : <Marker>{for (Event event in eventController.eventList[0]) mapController.createMarker(event)},
          ),
        ),
      ),
    );
  }

  Marker ankara = Marker(
      markerId: MarkerId('Çankaya Köşkü'),
      position: LatLng(39.88766486046114, 32.8651160404297),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueYellow,
      ),
      onTap: () {});
}
