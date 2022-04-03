import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map/controller/map2_controller.dart';

class MapScreen2 extends StatefulWidget {
  const MapScreen2({Key? key}) : super(key: key);

  @override
  State<MapScreen2> createState() => _MapScreen2State();
}

Controller2 controller = Controller2();
GoogleMapController? googleMapController;

class _MapScreen2State extends State<MapScreen2> {
  @override
  void initState() {
    controller.callApi();
    super.initState();
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
        title: const Text('Map 2'),
      ),
      body: GoogleMap(
        zoomControlsEnabled: false,
        initialCameraPosition: controller.initialCameraPosition2,
        onMapCreated: (controller) => googleMapController = controller,
        markers: {
          controller.origin,
          controller.destination,
        },

        //?--- Polyline 2nd way ---
        polylines: {
          Polyline(
            polylineId: const PolylineId('route'),
            width: 3,
            color: Colors.red,
            points: controller.result
                .map((e) => LatLng(e.latitude, e.longitude))
                .toList(),
          ),
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {});
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
