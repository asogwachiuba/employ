import 'dart:async';

import 'package:employ/constants/custom_colors.dart';
import 'package:employ/constants/custom_fonts.dart';
import 'package:employ/location_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  String employeeLocation;
  String jobLocation;

  MapPage({required this.employeeLocation, required this.jobLocation, Key? key})
      : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = Set<Marker>();
  Set<Polyline> _polyline = Set<Polyline>();
  late final directions = LocationService()
      .getDirection(widget.employeeLocation, widget.jobLocation);

  int _polylineIdCounter = 1;

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  void _setMarker(LatLng point, String markerId, String snippet) {
    setState(() {
      _markers.add(Marker(
          markerId: MarkerId(markerId),
          infoWindow: InfoWindow(title: markerId, snippet: snippet),
          position: point));
    });
  }

  void _setPolyline(List<PointLatLng> points) {
    final String polylineIdVal = 'polyline_$_polylineIdCounter';
    _polylineIdCounter++;

    _polyline.add(Polyline(
        polylineId: PolylineId(polylineIdVal),
        width: 5,
        color: CColor.red,
        points: points
            .map((point) => LatLng(point.latitude, point.longitude))
            .toList()));
  }

  @override
  Widget build(BuildContext context) {
    // var directions =  LocationService().getDirection('Lagos', 'Emene Enugu');
    return Scaffold(
      backgroundColor: CColor.white,
      body: GoogleMap(
        mapType: MapType.hybrid,
        markers: _markers,
        polylines: _polyline,
        initialCameraPosition: _kLake,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          setState(() async {
            var directions = await LocationService()
                .getDirection(widget.employeeLocation, widget.jobLocation);

            _goToPlace(
                directions['start_location']['lat'],
                directions['start_location']['lng'],
                directions['end_location']['lat'],
                directions['end_location']['lng'],
                directions['bounds_ne'],
                directions['bounds_sw']);

            _setPolyline(directions['polyline_decoded']);
          });
        },
        label: CFont.smallerPrimary('Job Location', color: CColor.red),
        backgroundColor: CColor.black,
        hoverColor: Colors.transparent,
      ),
    );
  }

  _goToPlace(double startLat, double startLng, double endLat, double endLng,
      Map<String, dynamic> boundsNe, Map<String, dynamic> boundsSw) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(startLat, startLng), zoom: 12)));

    controller.animateCamera(CameraUpdate.newLatLngBounds(
        LatLngBounds(
            southwest: LatLng(boundsSw['lat'], boundsSw['lng']),
            northeast: LatLng(boundsNe['lat'], boundsNe['lng'])),
        25));
    _setMarker(
        LatLng(startLat, startLng), widget.employeeLocation, 'Your address');
    _setMarker(LatLng(endLat, endLng), widget.jobLocation, 'Job location');
  }
}
