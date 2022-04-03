import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map/utils/google_map_api_constants.dart';
import 'package:map/view/map.dart';

class Controller {
  //?--- Variables ---
  double originLatitude = 24.934879,
      originLongitude = 67.082261,
      destLatitude = 24.932571,
      destLongitude = 67.085935;

  PolylineResult? result;
  List<LatLng> polylineCoordinates = [];

  //?--- Markers ---
  Marker origin = Marker(
    markerId: const MarkerId('origin'),
    position: const LatLng(24.934879, 67.082261),
    infoWindow: const InfoWindow(title: 'Origin'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
  );

  Marker destination = const Marker(
    markerId: MarkerId('destination'),
    position: LatLng(24.932571, 67.085935),
    infoWindow: InfoWindow(title: 'Destination'),
  );

  //?--- initialCameraPosition ---

  var initialCameraPosition = const CameraPosition(
    target: LatLng(24.9661223, 67.0766291),
    zoom: 14,
  );

  //?--- updateCameraLocation ---

  Future<void> updateCameraLocation(
    LatLng source,
    LatLng destination,
    GoogleMapController mapController,
  ) async {
    // ignore: unnecessary_null_comparison
    if (mapController == null) return;

    LatLngBounds bounds;

    if (source.latitude > destination.latitude &&
        source.longitude > destination.longitude) {
      bounds = LatLngBounds(southwest: destination, northeast: source);
    } else if (source.longitude > destination.longitude) {
      bounds = LatLngBounds(
          southwest: LatLng(source.latitude, destination.longitude),
          northeast: LatLng(destination.latitude, source.longitude));
    } else if (source.latitude > destination.latitude) {
      bounds = LatLngBounds(
          southwest: LatLng(destination.latitude, source.longitude),
          northeast: LatLng(source.latitude, destination.longitude));
    } else {
      bounds = LatLngBounds(southwest: source, northeast: destination);
    }

    CameraUpdate cameraUpdate = CameraUpdate.newLatLngBounds(bounds, 70);

    return checkCameraLocation(cameraUpdate, mapController);
  }

  Future<void> checkCameraLocation(
      CameraUpdate cameraUpdate, GoogleMapController mapController) async {
    mapController.animateCamera(cameraUpdate);
    LatLngBounds l1 = await mapController.getVisibleRegion();
    LatLngBounds l2 = await mapController.getVisibleRegion();

    if (l1.southwest.latitude == -90 || l2.southwest.latitude == -90) {
      return checkCameraLocation(cameraUpdate, mapController);
    }
  }

  //?--- getRoute ---
  Future<void> getRoute() async {
    result = await polylinePoints.getRouteBetweenCoordinates(
      googleMapApiKey,
      PointLatLng(originLatitude, originLongitude),
      PointLatLng(destLatitude, destLongitude),
      travelMode: TravelMode.driving,
      optimizeWaypoints: true,
    );

    if (result!.points.isNotEmpty) {
      for (var point in result!.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }
  }
}
