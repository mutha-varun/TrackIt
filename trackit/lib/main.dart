import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:trackit/firebase_options.dart';
import 'package:trackit/screens/home.dart';
import 'package:trackit/screens/loginpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await GoogleSignIn.instance.initialize();
  
  runApp(const TrackIt());
}

class TrackIt extends StatelessWidget {
  const TrackIt({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TrackIt',
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(), 
        builder: (context, snapshot){
          if(snapshot.connectionState==ConnectionState.waiting)
          {
            return Center(
            child: CircularProgressIndicator(),
            );
          }
          if(snapshot.hasData)
          {
            return const Home();
          }
          return const LoginPage();
        }
      )
    );
  }
}
