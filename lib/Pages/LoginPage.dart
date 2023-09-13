import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_page/Pages/HomePage.dart';
import 'package:login_page/Pages/SignUP.dart';
import 'Login_SignUp.dart';

class LoginPage extends StatefulWidget {
  // final void Function()? onPressed;
  const LoginPage({super.key,/*required this.onPressed*/});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formkey = GlobalKey<FormState>();
  bool isLogging = false;
  final TextEditingController Email = TextEditingController();
  final TextEditingController Password = TextEditingController();

  gotohomepage(){
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()));
  }

  signInWithEmailAndPassword() async{
    try {
      setState(() {
        isLogging= true;
      });
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: Email.text,
          password: Password.text
      );
      setState(() {
        isLogging= false;
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLogging = false;
      });
      if (e.code == 'user-not-found') {
        return ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("No user found for that email.")
          ),
        );
       // print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        return ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Wrong password provided for that user.')
          )
        );
        // print('Wrong password provided for that user.');
      }
    }

    gotohomepage();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login Page")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formkey,
            child: OverflowBar(
              overflowSpacing: 20,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: Email,
                      validator: (email) {
                        if (email == null || email.isEmpty) {
                          return "Please enter the email";
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: "Email"),
                    ),
                    TextFormField(
                      controller: Password,
                      validator: (password) {
                        if (password == null || password.isEmpty) {
                          return "Please enter the password";
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: "Password"),
                    ), TextButton(
                        onPressed: () {
                          if(formkey.currentState!.validate())
                          {
                            signInWithEmailAndPassword();
                          }
                        },
                        child: isLogging? CircularProgressIndicator():Text("Login")),
                    TextButton(onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignUP()),
                      );
                    }, child: Text("Sign In")),

                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
