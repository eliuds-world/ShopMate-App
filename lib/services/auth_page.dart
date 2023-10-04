import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopmate/pages/home_page.dart';
import 'package:shopmate/pages/list_page.dart';


//if user is signed in i display list page
class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListPage();
          } else
            return HomePage();
        },
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';


// class AuthFunction extends StatelessWidget {
//   const AuthFunction({
//     required this.loggedIn,
//     required this.signOut,
//   });

//   final bool loggedIn;
//   final void Function() signOut;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Padding(
//           padding: EdgeInsets.all(8),
//           child: ElevatedButton(
//             onPressed: (){
//               !loggedIn ? context.push("/login_page"): signOut();

//             },
//              child: !loggedIn ? Text("logIn"): Text("LogOut"),),),
//         Visibility(
//           visible: loggedIn,
//           child: Padding(
//             padding: EdgeInsets.all(8),
//             child: ElevatedButton(
//               onPressed: (){
//                 context.push("/registration_page");
//               },
//                child: Text("registering hahaha"),),
//             ),),
//       ],
//     );
    
//   }

// }
