//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Googlelogin extends StatelessWidget {
  const Googlelogin({super.key});

  @override 
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 13),
      width: double.infinity,
      height: 50,
      child: OutlinedButton(
        style: ButtonStyle(
          side: WidgetStatePropertyAll(
            BorderSide(
              color: Colors.black, 
              width: 1.2
           )
          )
        ),
        onPressed: (){

        }, 
        child: Text("Continue with Google",
          style: TextStyle(
            fontSize:23,
            color: Colors.black,
            fontWeight: FontWeight.w400
          ),
        )
      ),
    );
  }
}