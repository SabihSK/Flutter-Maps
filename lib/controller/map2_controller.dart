import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map/services/polylines_of_map_services.dart';
import 'package:map/view/map.dart';

class Controller2 {
  //?--- Variables ---
  double originLatitude = 24.937318,
      originLongitude = 67.0770928,
      destLatitude = 24.9339184,
      destLongitude = 67.08438280000001;

  List<PointLatLng> result = [];

  //?--- initialCameraPosition ---
  var initialCameraPosition2 = const CameraPosition(
    target: LatLng(24.934533, 67.080077),
    zoom: 15,
  );

  //?--- Markers ---
  Marker origin = Marker(
    markerId: const MarkerId('origin'),
    position: const LatLng(24.937318, 67.0770928),
    infoWindow: const InfoWindow(title: 'Origin'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
  );

  Marker destination = const Marker(
    markerId: MarkerId('destination'),
    position: LatLng(24.9339184, 67.08438280000001),
    infoWindow: InfoWindow(title: 'Destination'),
  );

  //?--- Get polylines by using api ---
  void callApi() async {
    var apiData = await GetPolylinesClass().getPolylines(
        originLatitude, originLongitude, destLatitude, destLongitude);

    result = polylinePoints
        .decodePolyline(apiData.routes[0].overviewPolyline.points);
  }
}
