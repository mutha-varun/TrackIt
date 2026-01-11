import 'package:trackit/screens/homescreen.dart';
import 'package:trackit/screens/last_statement.dart';
import 'package:trackit/screens/loginpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int currentIndex=0;
  String name = FirebaseAuth.instance.currentUser!.displayName!;
  List<Widget> pages = [HomeScreen(), LastStatement()];

  @override
    void initState() {
      currentIndex = 0;
      super.initState();
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromRGBO(96, 96, 96, 1),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromRGBO(96, 96, 96, 1),
        foregroundColor: Colors.white,
        title: Text("Hi, $name"),
        actions: [
          IconButton(
            onPressed: (){
              showDialog(context: context, 
                builder: (context) {
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
                          FirebaseAuth.instance.signOut();
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
                  );
                }
              );
            },
            icon: Icon(Icons.logout_rounded)
          )
        ],
      ),
      body: pages[currentIndex],
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent
        ),
        child: BottomNavigationBar(
          onTap: (value){
            setState(() {
              currentIndex = value;
            });
          },
          iconSize: 38,
          selectedIconTheme: IconThemeData(color: Colors.black),
          unselectedIconTheme: IconThemeData(color: Colors.grey.shade300),
          backgroundColor: Color.fromRGBO(85, 85, 85, 1),
          unselectedFontSize: 0,
          selectedFontSize: 0,
          currentIndex: currentIndex,
          elevation: 3,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),  
              label:"",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart),
              label:"",
            ),
          ],
        ),
      ),
    );
  }
}

