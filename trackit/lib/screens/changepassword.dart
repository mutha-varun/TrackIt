import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Changepassword extends StatefulWidget {
  final FirebaseAuth instance;
  const Changepassword({
    required this.instance,
    super.key
  });

  @override
  State<Changepassword> createState() => _ChangepasswordState();
}

class _ChangepasswordState extends State<Changepassword> {
  bool notShowOldPassword=true;
  bool notShowNewPassword=true;
  TextEditingController email = TextEditingController();
  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  
  @override
  void initState() {
    super.initState();
  }

  Future<void> changePassword(String newPassword) async{
    try{
      await widget.instance.currentUser!.updatePassword(newPassword);
      debugPrint("Changed");
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Password Changed successfully",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18
            ),
          ))
        );
      }
    } on FirebaseAuthException catch(e){
      debugPrint(e.message);

      throw Exception;
    }
    catch(e){
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
          contentPadding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
          content: SizedBox(
            height: 250,
            width: 250,
            child: Column(
              spacing: 10,
              children: [
                TextField(
                  decoration: InputDecoration(
                    hint: const Text("Email",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black
                      ),
                    ),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.black
                      )
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.black
                      )
                    ),
                  ),
                  autofocus: true, 
                  controller: email, 
                  obscureText: false,
                ),
                TextField(
                  decoration: InputDecoration(
                    hint: const Text("Old-Password",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black
                      ),
                    ),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.black
                      )
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.black
                      )
                    ),
                    prefixIcon: IconButton(onPressed: ()=> setState(() {
                      notShowOldPassword = !notShowOldPassword;
                      }), 
                      icon: notShowOldPassword?Icon(Icons.visibility_off):Icon(Icons.visibility)
                    )
                  ),
                  autofocus: false, 
                  controller: oldPassword, 
                  obscureText: notShowOldPassword,
                ),
                TextField(
                  decoration: InputDecoration(
                    hint: const Text("New-Password",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black
                      ),
                    ),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.black
                      )
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(
                        width: 2,
                        color: Colors.black
                      )
                    ),
                    prefixIcon: IconButton(onPressed: ()=> setState(() {
                      notShowNewPassword = !notShowNewPassword;
                      }), 
                      icon: notShowNewPassword?Icon(Icons.visibility_off):Icon(Icons.visibility)
                    )
                  ),
                  autofocus: false, 
                  controller: newPassword, 
                  obscureText: notShowNewPassword,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: (){
                        Navigator.of(context).pop();
                        changePassword(newPassword.text);
                      }, 
                      child: const Text("Change",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.blue
                        ),
                      )
                    ),
                    TextButton(onPressed: ()=>Navigator.of(context).pop(), 
                      child: const Text("Close",
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
  }