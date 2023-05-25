import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ParkingSpotPage extends StatefulWidget {
  const ParkingSpotPage({super.key});

  @override
  _ParkingSpotPageState createState() => _ParkingSpotPageState();
}

class _ParkingSpotPageState extends State<ParkingSpotPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Parking Spots'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('parking_spots').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final spots = snapshot.data!.docs;

          if (spots.isEmpty) {
            return const Center(child: Text('No available parking spots'));
          }

          return ListView.builder(
            itemCount: spots.length,
            itemBuilder: (BuildContext context, int index) {
              final spotData = spots[index].data() as Map<String, dynamic>?;  // Cast to Map<String, dynamic> type
              final spotName = spotData?['name'];
              final spotLocation = spotData?['address'];

              return ListTile(
                title: Text(spotName ?? ''),
                subtitle: Text(spotLocation ?? ''),
              );
            },
          );


        },
      ),
    );
  }
}
