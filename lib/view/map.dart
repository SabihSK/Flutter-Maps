import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map/controller/map_controller.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

//?--- Controller Object ---
Controller controller = Controller();

//?--- GoogleMapController ---
GoogleMapController? googleMapController;

//?--- PolylinePointsController ---
PolylinePoints polylinePoints = PolylinePoints();

class _MapScreenState extends State<MapScreen> {
  @override
  void initState() {
    super.initState();
    controller.getRoute();
  }

  @override
  void dispose() {
    googleMapController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map 1'),
      ),
      body: GoogleMap(
        zoomControlsEnabled: false,
        initialCameraPosition: controller.initialCameraPosition,
        onMapCreated: (controller) => googleMapController = controller,
        markers: {
          controller.origin,
          controller.destination,
        },

        //?--- Polyline 1st way ---
        polylines: {
          Polyline(
            polylineId: const PolylineId('poly'),
            color: Colors.red,
            width: 3,
            points: controller.polylineCoordinates,
          ),
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await controller.updateCameraLocation(
            LatLng(controller.originLatitude, controller.originLongitude),
            LatLng(controller.destLatitude, controller.destLongitude),
            googleMapController!,
          );

          setState(() {});
        },
        tooltip: 'Show makrs',
        child: const Icon(Icons.add_location),
      ),
    );
  }
}
