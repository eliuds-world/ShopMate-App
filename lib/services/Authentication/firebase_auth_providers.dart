// import 'dart:ffi';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:shopmate/firebase_options.dart';
// import 'package:shopmate/services/Authentication/auth_provider.dart';
// import 'package:shopmate/services/Authentication/auth_user.dart';
// import 'package:shopmate/services/Authentication/exceptions.dart';

// class FirebaseAuthProvider implements AuthProvider {
//   @override
//   Future<AuthUser> createUser({
//     required String email,
//     required String password,
//   }) async {
//     try {
//       await FirebaseAuth.instance.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       final user = currentUser;
//       if (user != null) {
//         return user;
//       } else {
//         throw UserNotLoggedInAuthException();
//       }
//     } on FireBaseAuthException catch (error) {
//       if (error.code == "weak-password") {
//       } else if (error.code == "email-already-in-use") {
//         throw EmailAlreadyInUseAuthException();
//       } else if (error.code == 'invalid-email ') {
//         throw InvalidEmailAuthException();
//       } else if (error.code == 'unknown') {
//       } else {
//         throw GenericAuthException();
//       }
//     } catch (error) {
//       throw GenericAuthException();
//     }
//   }

//   @override
//   AuthUser? get currentUser {
//     final user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       return AuthUser.fromFirebase(user);
//     } else {
//       return null;
//     }
//   }

//   @override
//   Future<AuthUser> logIn({
//     required String email,
//     required String password,
//   }) async {
//     try {
//       await FirebaseAuth.instance.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       final user = currentUser;
//       if (user != null) {
//         return user;
//       } else {
//         throw Exception();
//       }
//     } on FirebaseAuthException catch (error) {

//   }

//   @override
//   Future<Void> logOut() async {
//     final user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       await FirebaseAuth.instance.signOut();
//     } else {
//       throw Exception();
//     }
//     throw Exception();
//   }

//   @override
//   Future<void> initialize() async {
//     await Firebase.initializeApp(
//       options: DefaultFirebaseOptions.currentPlatform,
//     );
//   }

// @override
// Future<void> sendEmailVerification() async {
//   final user = FirebaseAuth.instance.currentUser;
//   if (user != null) {
//     await user.sendEmailVerification();
//   } else {
//     throw UserNotLoggedInAuthException();
//   }
// }
// }

// import 'dart:ffi';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:shopmate/firebase_options.dart';
// import 'package:shopmate/services/Authentication/auth_provider.dart';
// import 'package:shopmate/services/Authentication/auth_user.dart';
// import 'package:shopmate/services/Authentication/exceptions.dart';

// class FirebaseAuthProvider implements AuthProvider {
//   @override
//   Future<AuthUser> createUser({
//     required String email,
//     required String password,
//   }) async {
//     await FirebaseAuth.instance.createUserWithEmailAndPassword(
//       email: email,
//       password: password,
//     );
//     final user = currentUser;
//     if (user != null) {
//       return user;
//     } else {
//       throw UserNotLoggedInAuthException();
//     }
//   }

//   @override
//   AuthUser? get currentUser {
//     final user = FirebaseAuth.instance.currentUser;
//     if (user != null) {
//       return AuthUser.fromFirebase(user);
//     } else {
//       return null;
//     }
//   }

//   @override
//   Future<AuthUser> logIn({
//     required String email,
//     required String password,
//   }) async {
//     try {
//       await FirebaseAuth.instance.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       final user = currentUser;
//       if (user != null) {
//         return user;
//       } else {
//         throw Exception();
//       }
//     } on FirebaseAuthException catch (error) {}

//     @override
//     Future<Void> logOut() async {
//       final user = FirebaseAuth.instance.currentUser;
//       if (user != null) {
//         await FirebaseAuth.instance.signOut();
//       } else {
//         throw Exception();
//       }
//       throw Exception();
//     }

//     @override
//     Future<void> initialize() async {
//       await Firebase.initializeApp(
//         options: DefaultFirebaseOptions.currentPlatform,
//       );
//     }
//   }
// }
