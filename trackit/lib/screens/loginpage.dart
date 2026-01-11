import 'package:trackit/screens/googlelogin.dart';
import 'package:trackit/screens/home.dart';
import 'package:trackit/screens/registerpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  Future<void> loginWithEmail() async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(), 
        password: passwordController.text.trim()
      );
    }on FirebaseAuthException catch(e){
      print(e.message);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.only(top:10, left:20, right:20, bottom:10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin : Alignment.topLeft,
            end: Alignment.bottomRight,
            colors:[
              Color.fromRGBO(99, 115, 74, 1),
              Color.fromRGBO(89, 140, 88, 1),
              Color.fromRGBO(191, 204, 152, 1),
              Color.fromRGBO(221, 232, 179, 1)
            ]
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            spacing: 17,
            children: [
              const SizedBox(height: 10,),
              const Text("  Keep a track...",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
              ),
              const Text("BudgetBuddy",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold
                )
              ),
              Container(
                decoration: BoxDecoration(
                  
                ),
                padding: EdgeInsets.all(10),
                child: Column(
                  spacing: 20,
                  children: [
                    TextFieldUse(hintText: "E-mail",
                      autofocus: true, 
                      controller: emailController,
                      obscureText: false,
                    ),
                    TextFieldUse(hintText: "Password",
                      autofocus: false,
                      controller: passwordController,
                      obscureText: true,
                    ),
                    ElevatedButton(
                      onPressed: ()async{
                        await loginWithEmail();
                        if(context.mounted){
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => Home()
                            )
                          );
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.green.shade300),
                        fixedSize: WidgetStatePropertyAll(Size(247, 55)),
                        surfaceTintColor: WidgetStatePropertyAll(Colors.black),
                      ),
                      child: const Text("Continue Managing",
                        style: TextStyle(
                          fontSize: 21,
                          color: Colors.black
                        )
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
                child: Divider(
                  color: Colors.black,
                  thickness: 1,
                ),
              ),
              const Googlelogin(),
              const SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?",
                    style: TextStyle(
                      fontSize: 18
                    ),
                  ),
                  TextButton(
                    onPressed: (){
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context)=> RegisterPage()
                      ));
                    }, 
                    child: Text("Register",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                      ),
                    )
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TextFieldUse extends StatefulWidget{

  final String hintText;
  final bool autofocus;
  final bool obscureText;
  final TextEditingController controller;

  const TextFieldUse({
    required this.hintText,
    required this.autofocus,
    required this.controller,
    required this.obscureText,
    super.key,
  });

  @override
  State<TextFieldUse> createState() => _TextFieldUseState();
}

class _TextFieldUseState extends State<TextFieldUse> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: widget.autofocus,
      controller: widget.controller,
      obscureText: widget.obscureText,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: const TextStyle(
          fontSize: 20,
          color: Colors.black54,
          fontWeight: FontWeight.w500
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            style: BorderStyle.solid,
            width: 1.5
          )
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            style: BorderStyle.solid
          )
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            style: BorderStyle.solid,
            width: 2
          )
        ),
        
      ),
    );
  }
}