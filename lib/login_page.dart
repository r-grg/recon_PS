import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> _signIn() async {
    try {
      final username = _usernameController.text.trim();
      final password = _passwordController.text.trim();

      // Get the Firestore collection for users
      final userCollection = FirebaseFirestore.instance.collection('users');

      // Query the collection for the entered username and password
      final querySnapshot = await userCollection
          .where('username', isEqualTo: username)
          .where('password', isEqualTo: password)
          .get();

      // Check if the query returned any documents
      if (querySnapshot.docs.isNotEmpty) {
        // The login credentials are correct, navigate to the home page
        //Navigator.of(context).pushReplacementNamed("homePage");
        Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const HomePage())
        );
      } else {
        // The login credentials are incorrect, show an error message
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Invalid username or password'),
          duration: Duration(seconds: 3),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('An error occurred'),
        duration: Duration(seconds: 3),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(

          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 80.0),
                Image.asset(
                  'Images/Recon.png',
                  height: 100.0,
                ),
                const SizedBox(height: 40.0),
                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    hintText: 'Enter your username',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your username';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter your password',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 40.0,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    //color: Colors.blue,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _signIn();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(350, 50),
                      backgroundColor: Colors.lightBlueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                  ),
                    child: const Text('Login',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                const SizedBox(height: 30.0),
                GestureDetector(
                  onTap: () {
                    // Navigate to Forgot Password screen
                  },
                  child: const Text(
                    'Forgot my password',
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                GestureDetector(
                  onTap: () {
                    // Navigate to Create Account screen
                  },
                  child: const Text(
                    'Create an account',
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


