import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trackit/screens/loginpage.dart';

class Signout extends StatelessWidget {
  final FirebaseAuth instance;
  const Signout({
    required this.instance, 
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.black87,
      title: const Text("Logout",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.bold,
          color: Colors.white
        ),
      ),
      content: const Text("Are you sure you want to logout?",
        style: TextStyle(
          fontSize: 17,
          color: Colors.white
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("No",
            style: TextStyle(
              color: Colors.blue,
              fontSize: 20,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            instance.signOut();
            Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const LoginPage()) 
            );
          },
          child: const Text("Logout",
            style: TextStyle(
              color: Colors.red,
              fontSize: 20,
            ),
          ),
        ),
      ],
    ) ;
  }
}