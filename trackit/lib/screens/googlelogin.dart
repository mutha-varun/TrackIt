import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:trackit/screens/home.dart';

class Googlelogin extends StatefulWidget {
  const Googlelogin({super.key});
  
  @override
  State<Googlelogin> createState() => _GoogleloginState();
}

class _GoogleloginState extends State<Googlelogin> {

  Future<UserCredential?> singinWithGoogle() async{
    try{
     
      final GoogleSignInAccount googleUser = await GoogleSignIn.instance.authenticate();

      final GoogleSignInAuthentication googleAuth = googleUser.authentication;
      final idToken = googleAuth.idToken;

      final authorizationClient = googleUser.authorizationClient;
      GoogleSignInClientAuthorization? authorization =
      await authorizationClient.authorizationForScopes([
        'email',
        'profile',
      ]);
      authorization ??= await authorizationClient.authorizeScopes(['email', 'profile']);

      final accessToken = authorization.accessToken;
      final credential = GoogleAuthProvider.credential(
        accessToken: accessToken,
        idToken: idToken
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    }
    catch(e){
      debugPrint(e.toString());
      return null;
    }
  }

  Future<void> createData(UserCredential userCredential) async{
    try{
      await FirebaseFirestore.instance.collection("transactions").doc(userCredential.user!.uid).set({
        "Last Deposit": 0,
        "LastDepDate": null,
        "Total": 0
      });
    } 
    catch(e){
      debugPrint(e.toString());
    }
  }


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
        onPressed:() async{
          final user = await singinWithGoogle();
          if(user != null){
            await createData(user);
            if(context.mounted){
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Home()
                )
              );
            }
          }
        },
        child:Text("Continue with Google",
              style: TextStyle(
                fontSize: 23,
                color: Colors.black,
                fontWeight: FontWeight.w400
              ),
            )
      ),
    );
  }
}