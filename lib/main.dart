import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:recon_ps/home_page.dart';
import 'firebase_options.dart';
import 'login_page.dart';

void main() async {
  runApp(const MyApp());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}

