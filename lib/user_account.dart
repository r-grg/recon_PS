/*
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserAccountPage extends StatefulWidget {
  const UserAccountPage({Key? key}) : super(key: key);

  @override
  UserAccountPageState createState() => UserAccountPageState();
}

class UserAccountPageState extends State<UserAccountPage> {
  late User? currentUser;
  late Stream<DocumentSnapshot> userStream;

  @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      userStream = FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser!.uid)
          .snapshots();
    }
  }


  @override
  Widget build(BuildContext context) {
    if (currentUser == null) {
      // Handle the case when the current user is null
      return const Center(
        child: Text('User not logged in.'),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: userStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          final userData = snapshot.data?.data();

          if (userData == null) {
            return const Center(
              child: Text('User not found.'),
            );
          }

          final userDataMap = userData as Map<String, dynamic>;

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Username: ${userDataMap['username']}'),
              Text('First Name: ${userDataMap['firstName']}'),
              Text('Last Name: ${userDataMap['lastName']}'),
              Text('Email: ${userDataMap['email']}'),
              Text('Car Number Plate: ${userDataMap['carNumberPlate']}'),
              Text('Address: ${userDataMap['address']}'),
              Text('Mobile: ${userDataMap['mobile']}'),
              ElevatedButton(
                onPressed: () => _editUser(context),
                child: const Text('Edit'),
              ),
            ],
          );
        },
      ),
    );
  }

  void _editUser(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const EditUserPage(),
      ),
    );
  }
}

class EditUserPage extends StatefulWidget {
  const EditUserPage({Key? key}) : super(key: key);

  @override
  EditUserPageState createState() => EditUserPageState();
}

class EditUserPageState extends State<EditUserPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _carNumberPlateController =
  TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Account'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextFormField(
              controller: _firstNameController,
              decoration: const InputDecoration(labelText: 'First Name'),
            ),
            TextFormField(
              controller: _lastNameController,
              decoration: const InputDecoration(labelText: 'Last Name'),
            ),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              controller: _carNumberPlateController,
              decoration: const InputDecoration(labelText: 'Car Number Plate'),
            ),
            TextFormField(
              controller: _addressController,
              decoration: const InputDecoration(labelText: 'Address'),
            ),
            TextFormField(
              controller: _mobileController,
              decoration: const InputDecoration(labelText: 'Mobile'),
            ),
            ElevatedButton(
              onPressed: () => _updateUser(context),
              child: const Text('Update'),
            ),
          ],
        ),
      ),
    );
  }

  void _updateUser(BuildContext context) {
    final username = _usernameController.text;
    final firstName = _firstNameController.text;
    final lastName = _lastNameController.text;
    final email = _emailController.text;
    final carNumberPlate = _carNumberPlateController.text;
    final address = _addressController.text;
    final mobile = _mobileController.text;

    final userRef = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid);

    userRef.update({
      'username': username,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'carNumberPlate': carNumberPlate,
      'address': address,
      'mobile': mobile,
    }).then((_) {
      Navigator.pop(context);
    }).catchError((error) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text('Failed to update user. Error: $error'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _carNumberPlateController.dispose();
    _addressController.dispose();
    _mobileController.dispose();
    super.dispose();
  }
}
*/

/*
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserAccountPage extends StatefulWidget {
  const UserAccountPage({Key? key}) : super(key: key);

  @override
  UserAccountPageState createState() => UserAccountPageState();
}

class UserAccountPageState extends State<UserAccountPage> {
  late User? currentUser;
  late Stream<DocumentSnapshot> userStream;

  @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      userStream = FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser!.uid)
          .snapshots();
    }
  }


  @override
  Widget build(BuildContext context) {
    if (currentUser == null) {
      // Handle the case when the current user is null
      return const Center(
        child: Text('User not logged in.'),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: userStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          final userData = snapshot.data?.data();

          if (userData == null) {
            return const Center(
              child: Text('User not found.'),
            );
          }

          final userDataMap = userData as Map<String, dynamic>;

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Username: ${userDataMap['username']}'),
              Text('First Name: ${userDataMap['firstName']}'),
              Text('Last Name: ${userDataMap['lastName']}'),
              Text('Email: ${userDataMap['email']}'),
              Text('Car Number Plate: ${userDataMap['carNumberPlate']}'),
              Text('Address: ${userDataMap['address']}'),
              Text('Mobile: ${userDataMap['mobile']}'),
              ElevatedButton(
                onPressed: () => _editUser(context),
                child: const Text('Edit'),
              ),
            ],
          );
        },
      ),
    );
  }

  void _editUser(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const EditUserPage(),
      ),
    );
  }
}

class EditUserPage extends StatefulWidget {
  const EditUserPage({Key? key}) : super(key: key);

  @override
  EditUserPageState createState() => EditUserPageState();
}

class EditUserPageState extends State<EditUserPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _carNumberPlateController =
  TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Account'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextFormField(
              controller: _firstNameController,
              decoration: const InputDecoration(labelText: 'First Name'),
            ),
            TextFormField(
              controller: _lastNameController,
              decoration: const InputDecoration(labelText: 'Last Name'),
            ),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              controller: _carNumberPlateController,
              decoration: const InputDecoration(labelText: 'Car Number Plate'),
            ),
            TextFormField(
              controller: _addressController,
              decoration: const InputDecoration(labelText: 'Address'),
            ),
            TextFormField(
              controller: _mobileController,
              decoration: const InputDecoration(labelText: 'Mobile'),
            ),
            ElevatedButton(
              onPressed: () => _updateUser(context),
              child: const Text('Update'),
            ),
          ],
        ),
      ),
    );
  }

  void _updateUser(BuildContext context) {
    final username = _usernameController.text;
    final firstName = _firstNameController.text;
    final lastName = _lastNameController.text;
    final email = _emailController.text;
    final carNumberPlate = _carNumberPlateController.text;
    final address = _addressController.text;
    final mobile = _mobileController.text;

    final userRef = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid);

    userRef.update({
      'username': username,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'carNumberPlate': carNumberPlate,
      'address': address,
      'mobile': mobile,
    }).then((_) {
      Navigator.pop(context);
    }).catchError((error) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text('Failed to update user. Error: $error'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _carNumberPlateController.dispose();
    _addressController.dispose();
    _mobileController.dispose();
    super.dispose();
  }
}
*/

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  late User _currentUser;
  late String _userId;

  @override
  void initState() {
    super.initState();
    _currentUser = FirebaseAuth.instance.currentUser!;
    _userId = _currentUser.uid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('users').doc(_userId).get(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text('User document not found'));
          }

          final userData = snapshot.data!.data() as Map<String, dynamic>;

          final firstName = userData['firstName'] as String?;
          final lastName = userData['lastName'] as String?;
          final carNumberPlate = userData['carNumberPlates'] as String?;
          final mobile = userData['mobile'] as String?;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('First Name: ${firstName ?? 'N/A'}'),
                Text('Last Name: ${lastName ?? 'N/A'}'),
                Text('Car Number Plate: ${carNumberPlate ?? 'N/A'}'),
                Text('Mobile: ${mobile ?? 'N/A'}'),
              ],
            ),
          );
        },
      ),
    );
  }
}




