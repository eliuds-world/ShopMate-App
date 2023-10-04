import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopmate/pages/HomeScreen/home_page.dart';


import 'package:shopmate/pages/list_page.dart';class AuthenticationPage extends StatelessWidget {
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

// class AuthenticationService {
//   static FirebaseAuth firebaseAuth = FirebaseAuth.instance;
//   static User? user = firebaseAuth.currentUser;
//   static FirebaseFirestore firestore = FirebaseFirestore.instance;

//   //registering a user

//   static Future<String> registerUser(String email, String password) async {
//     try {
//       UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(
//         email: email, 
//         password: password,
//         );

//       String? uid = userCredential.user!.uid;

//       await FirebaseFireStore.instance.collection("Users").doc(uid).set({
//         "email": email,
//       });

//       return null;
//     } on FirebaseAuthException catch (exception) {
//       return exception.code;
//     }
//   }

  //verifying email with ottp

  // static Future<bool> verifyEmailWithOtp (String otpCode) async{
  //   try{
  //     User? user = firebaseAuth.currentUser;
  //     DocumentSnapshot userDoc = await firestore.collection("Users").doc(user!.uid).get();
  //     String? storedOTP =userDoc.get("otp");
  //   }
  // }
// }
