import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ReservationPage extends StatefulWidget {
  final String locationAddress;

  const ReservationPage({Key? key, required this.locationAddress}) : super(key: key);

  @override
  ReservationPageState createState() => ReservationPageState();
}

class ReservationPageState extends State<ReservationPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _carNumberController = TextEditingController();
  TextEditingController _fromTimeController = TextEditingController();
  TextEditingController _toTimeController = TextEditingController();

  bool _isButtonEnabled = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _carNumberController.dispose();
    _fromTimeController.dispose();
    _toTimeController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_validateInputs);
    _emailController.addListener(_validateInputs);
    _mobileController.addListener(_validateInputs);
    _carNumberController.addListener(_validateInputs);
    _fromTimeController.addListener(_validateInputs);
    _toTimeController.addListener(_validateInputs);
  }

  void _validateInputs() {
    bool isButtonEnabled = _nameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _mobileController.text.isNotEmpty &&
        _carNumberController.text.isNotEmpty &&
        _fromTimeController.text.isNotEmpty &&
        _toTimeController.text.isNotEmpty;

    setState(() {
      _isButtonEnabled = isButtonEnabled;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reservation'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Location Address:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.locationAddress,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Reservation Details',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _mobileController,
                decoration: const InputDecoration(
                  labelText: 'Mobile',
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _carNumberController,
                decoration: const InputDecoration(
                  labelText: 'Car Number',
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _fromTimeController,
                decoration: const InputDecoration(
                  labelText: 'From Reservation Time',
                ),
                keyboardType: TextInputType.datetime,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _toTimeController,
                decoration: const InputDecoration(
                  labelText: 'To Reservation Time',
                ),
                keyboardType: TextInputType.datetime,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _isButtonEnabled ? _showParkingTicket : null,
                child: const Text('Reserve'),
              ),
            ],
          ),
        ),
      ),
    );
  }


  void _showParkingTicket() {
    final reservationData = {
      'locationAddress': widget.locationAddress,
      'name': _nameController.text,
      'email': _emailController.text,
      'mobile': _mobileController.text,
      'carNumber': _carNumberController.text,
      'fromTime': _fromTimeController.text,
      'toTime': _toTimeController.text,
    };

    FirebaseFirestore.instance
        .collection('reservations')
        .add(reservationData)
        .then((value) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Parking Ticket'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Location Address: ${widget.locationAddress}'),
                const SizedBox(height: 8),
                Text('Name: ${_nameController.text}'),
                Text('Email: ${_emailController.text}'),
                Text('Mobile: ${_mobileController.text}'),
                Text('Car Number: ${_carNumberController.text}'),
                Text('From: ${_fromTimeController.text}'),
                Text('To: ${_toTimeController.text}'),
                const Text('\nYour reservation has been successfully saved.'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Close'),
              ),
            ],
          );
        },
      );
    }).catchError((error) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Reservation Failed'),
            content: Text('Failed to save reservation: $error'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Close'),
              ),
            ],
          );
        },
      );
    });
  }
}




