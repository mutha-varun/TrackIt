import 'package:trackit/firebase_options.dart';
import 'package:trackit/screens/home.dart';
import 'package:trackit/screens/loginpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BudgetBuddy',
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(), 
        builder: (context, snapshot){
          if(snapshot.connectionState==ConnectionState.waiting)
          {
            return Center(
            child: CircularProgressIndicator(),
            );
          }
          if(snapshot.data != null)
          {
            return const Home();
          }
          return const LoginPage();
        }
      )
    );
  }
}
