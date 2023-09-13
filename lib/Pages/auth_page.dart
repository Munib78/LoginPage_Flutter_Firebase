import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_page/Pages/Login_SignUp.dart';
import 'HomePage.dart';
import 'LoginPage.dart';
import 'package:flutter/material.dart';

class Auth_Page extends StatelessWidget {
  const Auth_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context,AsyncSnapshot<User?> snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const CircularProgressIndicator();
          }
          else{
            if(snapshot.hasData){
              return HomePage();
            }

            else{
              return LoginPage();
            }
          }
        },
      ),
    );
  }
}
