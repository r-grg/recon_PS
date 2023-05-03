//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart'; // Suitable for most situations
import 'package:flutter_map/plugin_api.dart'; // Only import if required functionality is not exposed by default
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class ReconPage extends StatefulWidget {
  const ReconPage({super.key});

  @override
  ReconPageState createState() => ReconPageState();
}

class ReconPageState extends State<ReconPage> {
  final MapController _mapController = MapController();
  final TextEditingController _searchController = TextEditingController();
  late LatLng _currentLocation;

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _getLocation() async {
    // TODO: Implement code to get the user's current location using location package or geolocator package
    // In this example, we'll just set a default location
    _currentLocation = LatLng(51.229723, 4.41583); //Antwerpen
    setState(() {

    });
  }

  Future<LatLng?> _searchAddress(String query) async {
    final String apiUrl =
        'https://nominatim.openstreetmap.org/search?q=$query&format=json&addressdetails=1';
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final jsonData = convert.jsonDecode(response.body);
      if (jsonData.isNotEmpty) {
        final lat = double.parse(jsonData[0]['lat']);
        final lon = double.parse(jsonData[0]['lon']);
        return LatLng(lat, lon);
      }
    }
    return null;
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
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search address...',
                filled: true,
                fillColor: Colors.grey[200],
                suffixIcon: IconButton(
                  color: Colors.black,
                  icon: const Icon(Icons.search),
                  onPressed: () async {
                    final address = _searchController.text;
                    final result = await _searchAddress(address);
                    if (result != null) {
                      _mapController.move(result, 13);
                    }
                  },
                ),
              ),
            ),
          ),
        ),
      ),
      body: FlutterMap(
        // Use the OpenStreetMap provider
        options: MapOptions(
          center: LatLng(51.229723, 4.41583),
          zoom: 13.0,
        ),
        // Set the map controller
        mapController: _mapController,
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: const ['a', 'b', 'c'],
          ),
          // Add a marker for the current location if available
          if (_currentLocation != null)
            MarkerLayer(
              markers: [
                Marker(
                  width: 80.0,
                  height: 80.0,
                  point: LatLng(_currentLocation.latitude, _currentLocation.longitude),
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
          _mapController.move(
              LatLng(_currentLocation.latitude, _currentLocation.longitude),
              16.0);
        },
        child: const Icon(Icons.my_location),
      ),
    );
  }
}



/*
class ReconPage extends StatefulWidget {
  const ReconPage({super.key});

  @override
  ReconPageState createState() => ReconPageState();
}

class ReconPageState extends State<ReconPage> {
  final List<String> _coordsList = <String>[];
  final MapController _mapController = MapController();

  String _appBarTitle = 'Ellermanstraat 33, 2000 Antwerp';
  //String _appBarTitle = 'Unitaswijk';

  // text field
  final TextEditingController _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(_appBarTitle),
      ),
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          //center: LatLng(51.23016715, 4.4161294643975015), zoom: 14.0),
          //bounds: LatLngBounds.fromPoints([LatLng(51.20087, 4.46214), LatLng(51.19827, 4.47352),])),
          swPanBoundary: LatLng(51.20087, 4.46214),
          nePanBoundary: LatLng(51.19827, 4.47352),
          minZoom: 14.0,
          maxZoom: 17.0,
          zoom: 14.0,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'dev.fleaflet.flutter_map.example',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => _displayDialog(context),
          tooltip: 'Search Address',
          child: const Icon(Icons.add)),
    );
  }

  void _addCoords(String coords) async {
    _coordsList.add(coords);
    var latLon = coords.split(',');
    var urlString =
        'https://nominatim.openstreetmap.org/reverse?lat=${latLon[0]}&lon=${latLon[1]}&format=json';
    final dataUrl = Uri.parse(urlString);
    final response = await http.get(dataUrl);

    setState(() {
      if (response.statusCode == 200) {
        final jsonResponse = convert.jsonDecode(response.body);
        _appBarTitle = jsonResponse['address']['road'] +
            ' ' +
            jsonResponse['address']['house_number'] +
            ', ' +
            jsonResponse['address']['postcode'] +
            ' ' +
            jsonResponse['address']['city'];
        _mapController.move(
            LatLng(double.parse(latLon[0]), double.parse(latLon[1])), 14.0);
      }
    });
    _textFieldController.clear();
  }

  // display a dialog for the user to enter items
  _displayDialog(BuildContext context) {
    // alter the app state to show a dialog
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Search for address'),
            content: TextField(
              controller: _textFieldController,
              decoration: const InputDecoration(hintText: 'Enter lat/lon here'),
            ),
            actions: <Widget>[
              // add button
              TextButton(
                child: const Text('ADD'),
                onPressed: () {
                  Navigator.of(context).pop();
                  _addCoords(_textFieldController.text);
                },
              ),
              // Cancel button
              TextButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}

*/
