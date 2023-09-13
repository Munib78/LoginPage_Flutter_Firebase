// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:login_page/Pages/SignUP.dart';
import 'firebase_options.dart';
import 'Pages/LoginPage.dart';
import 'Pages/auth_page.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MaterialApp(

  home: const Auth_Page(),
  //     initialRoute: '/',
  //     routes: {
  //       '/': (context) => Auth_Page(),
  //       '/loginPage': (context) => LoginPage();
  //       '/SignUP': (context) => SignUP();
  //     },

  ));
}
//
// class MyHome extends StatelessWidget {
//   const MyHome({super.key});
//
//   @overridereturn Scaffold(
//       appBar: AppBar(
//         title: Text("Login Page",
//
//         )
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           TextButton(
//               onPressed: (){},
//               child: Text("Sign In")
//           ),
//
//           TextButton(
//               onPressed: (){},
//               child: Text("Login"))
//         ],
//
//
//       ),
//     );
//   Widget build(BuildContext context) {

//   }
// }
