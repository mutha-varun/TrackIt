import 'package:trackit/screens/changepassword.dart';
import 'package:trackit/screens/homescreen.dart';
import 'package:trackit/screens/last_statement.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trackit/screens/signout.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FirebaseAuth instance = FirebaseAuth.instance;
  
  int currentIndex=0;
  String name = FirebaseAuth.instance.currentUser!.displayName!;
  List<Widget> pages = [HomeScreen(), LastStatement()];
  

  @override
  void initState() {
    currentIndex = 0;
    super.initState();
  }

  Future<void> resetPasswordDialog() async{
    await showDialog<void>(context: context, 
      builder: (BuildContext context){
        return Changepassword(instance: instance,);
      }
    );
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
        leading: IconButton(
          onPressed: () async{
            await resetPasswordDialog();
          }, 
          icon: const Icon(Icons.password_sharp)
        ),
        title: Text("Hi, $name"),
        actions: [
          IconButton(
            onPressed: (){
              showDialog(context: context, 
                builder: (context) {
                  return Signout(instance: instance);
                }
              );
            },
            icon: const Icon(Icons.logout_rounded)
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
          selectedIconTheme: const IconThemeData(color: Colors.black),
          unselectedIconTheme: IconThemeData(color: Colors.grey.shade300),
          backgroundColor: Color.fromRGBO(85, 85, 85, 1),
          unselectedFontSize: 0,
          selectedFontSize: 0,
          currentIndex: currentIndex,
          elevation: 3,
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home),  
              label:"",
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart),
              label:"",
            ),
          ],
        ),
      ),
    );
  }
}

