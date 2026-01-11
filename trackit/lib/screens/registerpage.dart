import 'package:trackit/screens/googlelogin.dart';
import 'package:trackit/screens/loginpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final TextStyle hintTextStyle = const TextStyle(
    fontSize: 20,
    color: Colors.black54,
    fontWeight: FontWeight.w500
  );

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController(); 

  Future<void> createUser() async {
    try{
      final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(), 
        password: passwordController.text.trim(),
      );
      await userCredential.user!.updateDisplayName(nameController.text.trim());
      
    }on FirebaseAuthException catch(e){
      print(e.message);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
        child: Column(
          spacing: 12,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                  TextFieldUse(hintText: "Name", 
                    autofocus: true, 
                    controller: nameController,
                    obscureText: false,
                  ),
                  TextFieldUse(hintText: "E-mail",
                    autofocus: false, 
                    controller: emailController,
                    obscureText: false,
                  ),
                  TextFieldUse(hintText: "Password", 
                    autofocus: false, 
                    controller: passwordController,
                    obscureText: true,
                  ),
                  const SizedBox(height: 1,),
                  ElevatedButton(
                    onPressed: () async{
                      await createUser();
                      if(context.mounted)
                      {
                        Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context)=> const LoginPage())
                        );
                      }
                    }, 
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.green.shade300),
                      fixedSize: WidgetStatePropertyAll(Size(240, 55)),
                      surfaceTintColor: WidgetStatePropertyAll(Colors.black),
                    ),
                    child: const Text("Register",
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.black
                      ),
                    )
                  )
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
            const SizedBox(height:15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account?",
                  style: TextStyle(
                    fontSize: 18
                  ),
                ),
                TextButton(
                  onPressed: (){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context)=> LoginPage()
                    ));
                  }, 
                  child: const Text("Login",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
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
}