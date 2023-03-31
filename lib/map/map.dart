import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:custom_info_window/custom_info_window.dart';

class Map extends StatefulWidget {
  @override
  MapState createState() => MapState();
}

class MapState extends State<Map> {
  Completer<GoogleMapController> _controller = Completer();
  static CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  double zoomVal = 5.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _buildGoogleMap(context),
          _buildInfoWindow(context)
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
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(target: LatLng(1, 1), zoom: 12),
        onMapCreated: (GoogleMapController controller) {
          _customInfoWindowController.googleMapController = controller;
          _controller.complete(controller);
        },
        markers: Set<Marker>.of(createMarkers()),
      ),
    );
  }

  Widget _buildInfoWindow(BuildContext context) {
    return Container(
      child: CustomInfoWindow(
        controller: _customInfoWindowController,
        height: 75,
        width: 150,
        offset: 50,
      ),
    );
  }

  Future<void> _gotoLocation(double lat, double long) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat, long),
      zoom: 15,
      tilt: 50.0,
      bearing: 45.0,
    )));
  }

  Marker ankara = Marker(
    markerId: MarkerId('Çankaya Köşkü'),
    position: LatLng(39.88766486046114, 32.8651160404297),
    infoWindow: InfoWindow(title: 'Çankaya Köşkü'),
    icon: BitmapDescriptor.defaultMarkerWithHue(
      BitmapDescriptor.hueYellow,
    ),
    onTap: () {
      _customInfoWindowController.addInfoWindow!(
        Column(
          children: [],
        ),
        LatLng(39.88766486046114, 32.8651160404297),
      );
    },
  );

  List<Marker> createMarkers() {
    var data = [
      {'name': 'Marker 1', 'lat': 37.77483, 'lng': -122.41942},
      {'name': 'Marker 2', 'lat': 37.78527, 'lng': -122.40617},
      {'name': 'Marker 3', 'lat': 37.76265, 'lng': -122.41417},
    ];

    return data
        .map((item) => Marker(
              markerId: MarkerId(item['name'] as String),
              position: LatLng(item['lat'] as double, item['lng'] as double),
              //infoWindow: InfoWindow(title: item['name'] as String),
              onTap: () {
                print("clicked");
                _customInfoWindowController.addInfoWindow!(
                  Column(
                    children: [
                      Text('First item'),
                      Text('Second item'),
                      Text('Third item'),
                    ],
                  ),
                  LatLng(39.88766486046114, 32.8651160404297),
                );
              },
            ))
        .toList();
  }
}
