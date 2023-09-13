import 'package:flutter/material.dart';
import 'LoginPage.dart';
import 'SignUP.dart';

class Login_SignUP extends StatefulWidget {
  const Login_SignUP({super.key});

  @override
  State<Login_SignUP> createState() => _Login_SignUPState();
}

class _Login_SignUPState extends State<Login_SignUP> {
  bool isLogin = true;
   void toggle()
   {
     setState(() {
       isLogin = !isLogin;
     });

   }
   @override
  Widget build(BuildContext context) {
    if(isLogin){
      return LoginPage();
    }

    else{
      return SignUP();
    }
  }
}
