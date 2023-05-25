import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:recon_ps/parking_spot.dart';
import 'login_page.dart';
import 'user_account.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigate to Parking page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ParkingSpotPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(280, 50),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(color: Colors.lightBlueAccent, width: 2),
                ),
              ),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Parking spot',
                      style: TextStyle(
                          color: Colors.lightBlueAccent,
                          fontSize: 25,
                          //fontWeight: FontWeight.w500
                      )
                  ),
                  Icon(Icons.arrow_forward_ios,
                    color: Colors.lightBlueAccent,
                  ), // Add arrow icon
                ],
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Navigate to account page
               /* Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserProfilePage()),
                );*/
              },
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(280, 50),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(color: Colors.lightBlueAccent, width: 2),
                ),
              ),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Account',
                      style: TextStyle(
                          color: Colors.lightBlueAccent,
                          fontSize: 25,
                          //fontWeight: FontWeight.w500
                      )
                  ),
                  Icon(Icons.arrow_forward_ios,
                    color: Colors.lightBlueAccent,
                  ), // Add arrow icon
                ],
              ),
            ),
            const SizedBox(height: 60),
            ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(250, 50),
                backgroundColor: Colors.lightBlueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),

              child: const Text('Log out',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



