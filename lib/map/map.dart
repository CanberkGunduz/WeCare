import 'package:flutter/material.dart';
import 'package:gdsc_metu2023/events/model/event_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:search_map_place_updated/search_map_place_updated.dart';

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
        body: Stack(
          children: [
            Container(
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: Get.width * 0.8,
                child: SearchMapPlaceWidget(
                  apiKey: "AIzaSyDi5By4EfumAfILVEr-XCnvVUDqtSSwM2A",
                  language: "en",
                  location: LatLng(mapController.currentPosition.latitude, mapController.currentPosition.longitude),
                  radius: 300,
                  bgColor: Color.fromARGB(255, 255, 255, 255),
                  placeholder: "Search Location",
                  iconColor: Color.fromARGB(255, 230, 81, 0),
                  textColor: Colors.black,
                  onSelected: (Place place) async {
                    final geolocation = await place.geolocation;

                    // Will animate the GoogleMap camera, taking us to the selected position with an appropriate zoom
                    final GoogleMapController controller = await mapController.googleMapController.future;
                    controller.animateCamera(CameraUpdate.newLatLng(geolocation!.coordinates));
                    controller.animateCamera(CameraUpdate.newLatLngBounds(geolocation.bounds, 0));
                  },
                ),
              ),
            ),
          ],
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
