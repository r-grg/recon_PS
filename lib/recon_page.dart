import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class ReconPage extends StatefulWidget {
  const ReconPage({super.key});

  @override
  _ReconPageState createState() => _ReconPageState();
}

class _ReconPageState  extends State<ReconPage> {
  // Define variables for the current location and map controller
  LocationData? currentLocation;
  MapController mapController = MapController();

  // Define a location object to get the current location
  Location location = Location();

  // Define a function to get the current location
  void getCurrentLocation() async {
    currentLocation = await location.getLocation();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(20.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search address...',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
          ),
        ),
      ),
      body: FlutterMap(
        // Use the OpenStreetMap provider
        options: MapOptions(
          center: LatLng(51.2194, 4.4025),
          zoom: 13.0,
        ),
        // Set the map controller
        mapController: mapController,
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: const ['a', 'b', 'c'],
          ),
          // Add a marker for the current location if available
          if (currentLocation != null)
            MarkerLayer(
              markers: [
                Marker(
                  width: 80.0,
                  height: 80.0,
                  point: LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
                  builder: (ctx) =>
                      const Icon(Icons.location_on),
                ),
              ],
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Zoom to the current location when the button is pressed
          mapController.move(
              LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
              16.0);
        },
        child: const Icon(Icons.my_location),
      ),
    );
  }
}
