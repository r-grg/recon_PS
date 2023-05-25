import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart';
import 'reservation_page.dart';

class BlueCarMarkerIcon extends StatelessWidget {
  const BlueCarMarkerIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'Images/icons_blue_car.png',
      width: 48,
      height: 48,
    );
  }
}

class RedCarMarkerIcon extends StatelessWidget {
  const RedCarMarkerIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'Images/icons_red_car.png',
      width: 48,
      height: 48,
    );
  }
}

class MarkerDetailsPage extends StatelessWidget {
  final String markerTitle;
  //final String markerDescription;
  final bool isMarkerRed;
  final String address;


  const MarkerDetailsPage({
    Key? key,
    required this.markerTitle,
    //required this.markerDescription,
    required this.isMarkerRed,
    required this.address,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  markerTitle,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, size: 30),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                    children: [
                      const TextSpan(text: 'Address: ',
                          style: TextStyle(fontWeight: FontWeight.bold)
                      ),
                      TextSpan(
                        text: address,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const Spacer(),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: isMarkerRed ? null : () {
                  // Add your reservation logic here
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReservationPage(locationAddress: address),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(250, 50),
                  backgroundColor: isMarkerRed ? Colors.grey : Colors.lightBlueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Reserve',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class ReconPage extends StatefulWidget {
  const ReconPage({Key? key}) : super(key: key);

  @override
  ReconPageState createState() => ReconPageState();
}

class ReconPageState extends State<ReconPage> {
  final MapController _mapController = MapController();
  final TextEditingController _searchController = TextEditingController();
  late List<Marker> _markers;
  LatLng address_1 = LatLng(51.230412, 4.416810);
  LatLng address_2 = LatLng(51.221393, 4.410557);
  LatLng address_3 = LatLng(51.227419, 4.409615);
  LatLng address_4 = LatLng(51.225892, 4.409815);
  LatLng address_5 = LatLng(51.225664, 4.417871);


  @override
  void initState() {
    _markers = [
      Marker(
        width: 40.0,
        height: 40.0,
        point: address_1,
        builder: (ctx) => GestureDetector(
          onTap: () => _showMarkerDetails(
            context,
            'Parking Spot',
            //'Marker 1 Description',
            false,
            address_1,
          ),
          child: const BlueCarMarkerIcon(),
        ),
      ),
      Marker(
        width: 40.0,
        height: 40.0,
        point: address_2,
        builder: (ctx) => GestureDetector(
          onTap: () => _showMarkerDetails(
            context,
            'Parking Spot',
            //'Marker 1 Description',
            false,
            address_2,
          ),
          child: const BlueCarMarkerIcon(),
        ),
      ),
      Marker(
        width: 40.0,
        height: 40.0,
        point:address_3,
        builder: (ctx) => GestureDetector(
          onTap: () => _showMarkerDetails(
            context,
            'Parking Spot',
            //'Marker 2 Description',
            true,
            address_3,
          ),
          child: const RedCarMarkerIcon(),
        ),
      ),
      Marker(
        width: 40.0,
        height: 40.0,
        point:address_4,
        builder: (ctx) => GestureDetector(
          onTap: () => _showMarkerDetails(
            context,
            'Parking Spot',
            //'Marker 2 Description',
            false,
            address_4,
          ),
          child: const BlueCarMarkerIcon(),
        ),
      ),
      Marker(
        width: 40.0,
        height: 40.0,
        point:address_5,
        builder: (ctx) => GestureDetector(
          onTap: () => _showMarkerDetails(
            context,
            'Parking Spot',
            //'Marker 2 Description',
            true,
            address_5,
          ),
          child: const RedCarMarkerIcon(),
        ),
      ),

    ];
    super.initState();
  }

  void _showMarkerDetails(BuildContext context, String title, bool isMarkerRed, LatLng position) async {
    final List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    final String address = placemarks.first.street ?? '';

    final currentContext = context; // Store the context in a variable

    showModalBottomSheet(
      context: currentContext, // Use the stored context inside showModalBottomSheet
      builder: (BuildContext context) {
        return MarkerDetailsPage(
          markerTitle: title,
          //markerDescription: description,
          isMarkerRed: isMarkerRed,
          address: address,
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              center: LatLng(51.2194, 4.4025),
              zoom: 14.0,
              maxZoom: 18.0,
              minZoom: 4.0,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: const ['a', 'b', 'c'],
              ),
              MarkerLayer(
                markers: _markers,
              ),
            ],
          ),
          Positioned(
            top: 35.0,
            left: 16.0,
            right: 16.0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30.0),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search Address',
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    color: Colors.lightBlueAccent,
                    onPressed: _searchAddress,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _searchAddress() async {
    final query = _searchController.text;
    if (query.isEmpty) return;

    final List<Location> locations = await locationFromAddress(query);
    if (locations.isEmpty) return;

    final LatLng position = LatLng(locations.first.latitude, locations.first.longitude);
    _mapController.move(position, 17.5);

    setState(() {
      //_markers.clear();
      _markers.add(
        Marker(
          width: 40.0,
          height: 40.0,
          point: position,
          builder: (ctx) => GestureDetector(
            onTap: () {
              /*_showMarkerDetails(
                context,
                'Parking Spot',
                false,
                position,
              );*/
            },
            child: const Icon(Icons.location_on, color: Colors.blue),
          ),
        ),
      );

    });
  }

  @override
  void dispose() {
    _mapController.dispose();
    _searchController.dispose();
    super.dispose();
  }
}


