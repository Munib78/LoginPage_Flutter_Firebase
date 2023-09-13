import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_page/Pages/LoginPage.dart';
import 'HomePage.dart';

class SignUP extends StatefulWidget {
  // final void Function()? onPressed;
  // const SignUP({super.key,/*required this.onPressed*/});
  const SignUP({super.key});
  @override
  State<SignUP> createState() => _SignUPState();
}

class _SignUPState extends State<SignUP> {

  final formkey = GlobalKey<FormState>();
  bool isLoadding = false;
  final TextEditingController Email = TextEditingController();
  final TextEditingController Password = TextEditingController();

  gotohomepage(){
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()));
  }
  createUserWithEmailAndPassword() async{

    try {
      setState(() {
        isLoadding = true;
      });
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: Email.text,
        password: Password.text,
      );

      setState(() {
        isLoadding = false;
      });
    } on FirebaseAuthException catch (e) {

      setState(() {
        isLoadding = false;
      });

      if (e.code == 'weak-password') {
        return ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('The password provided is too weak.'))
        );
        // print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        return ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('The account already exists for that email.'))
        );
      }
      // print('The account already exists for that email.');
    }catch (e) {
      setState(() {
        isLoadding = false;
      });
      print(e);
    }

    gotohomepage();
  }



@override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: Text("SignUP Page")),
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
                  ),
                  TextButton(onPressed: () {
                    if (formkey.currentState!.validate()) {
                      createUserWithEmailAndPassword();
                    }
                  },
                      child: Text("Sign In")),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginPage()),
                        );
                      },
                      child: isLoadding? CircularProgressIndicator():Text("Login"))
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
