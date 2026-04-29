import 'package:trackit/screens/googlelogin.dart';
import 'package:trackit/screens/home.dart';
import 'package:trackit/screens/registerpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();
  final TextEditingController recoveryEmail = TextEditingController();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<bool> loginWithEmail() async{
    try{
      await _firebaseAuth.signInWithEmailAndPassword(
        email: emailController.text.trim(), 
        password: passwordController.text.trim()
      );

      return true;
      
    }on FirebaseAuthException catch(e){
      //debugPrint(e.message);
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18
              ),
            )
          )
        );
      }
      return false;
    }
  }

  Future<void> resetPasswordDialog() async{
    await showDialog<void>(context: context, 
      builder: (BuildContext context){
        return AlertDialog(
          contentPadding: EdgeInsets.only(top: 0, left: 0, right: 0, bottom: 0),
          content: Container(
            padding: EdgeInsets.only(left:20, right: 20, top: 25),
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
              borderRadius: BorderRadius.all(Radius.circular(20))
            ),
            height: 155,
            width: 250,
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    hint: Text("E-mail",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.black
                      )
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.black
                      )
                    ),
                  ),
                  autofocus: true, 
                  controller: recoveryEmail, 
                  obscureText: false
                ),
                SizedBox(height: 14,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: (){
                        Navigator.of(context).pop();
                        resetPassword();
                      }, 
                      child: Text("Send",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.blue.shade700
                        ),
                      )
                    ),
                    TextButton(onPressed: ()=>Navigator.of(context).pop(), 
                      child: Text("Close",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.red
                        ),
                      )
                    )
                  ],
                )
              ],
            ),
          ),
        );
      }
    );
  }

  Future<void> resetPassword() async{
    try{ 
      await _firebaseAuth.sendPasswordResetEmail(email: recoveryEmail.text.trim());
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Mail sent",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18
              )
            )
          )
        );
      }
    } on FirebaseAuthException catch(e){

      if (e.code == 'user-not-found' && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18
              ),
            )
          )
        );
      } 
      else if (e.code == 'invalid-email' && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18
              ),
            )
          )
        );
      }
      throw Exception(e.message);
    }catch(e){
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString()))
        );
      }
    }

    recoveryEmail.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                padding: EdgeInsets.all(10),
                child: Column(
                  spacing: 15,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: ()async {
                            //debugPrint("Tapped");
                            await resetPasswordDialog();
                          },
                          child: Text("Forgot Password?",
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple
                            ),
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: ()async{
                        if(emailController.text.isEmpty){
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("E-mail cannot be empty",
                              textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18
                                ),
                              )
                            )
                          );
                        }
                        else if(passwordController.text.isEmpty){
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Password is required",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18
                                ),
                              )
                            )
                          );
                        }
                        else{
                          bool isLoggedIn = await loginWithEmail();
                          if(isLoggedIn){
                            if(context.mounted){
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Home()
                                )
                              );
                            }
                          }
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.green.shade300),
                        fixedSize: const WidgetStatePropertyAll(Size(247, 55)),
                        surfaceTintColor: const WidgetStatePropertyAll(Colors.black),
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
              const Divider(
                color: Colors.black,
                thickness: 1,
              ), 
              const Googlelogin(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?",
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
                    child: const Text("Register",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                      ),
                    )
                  )
                ],
              ),
              const SizedBox(height: 30,)
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