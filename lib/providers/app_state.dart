//we are going to use this file to track our application state
//it alerts the widgets tree whether or not the user was loggein in

// import 'package:firebase_auth/firebase_auth.dart'
//     hide EmailAuthProvider, PhoneAuthProvider;
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_ui_auth/firebase_ui_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:shopmate/firebase_options.dart';

// class ApplicationState extends ChangeNotifier {
//   ApplicationState() {
//     init();
//   }

//   bool _loggeIn = false;
//   bool get loggedIn => _loggeIn;

//   Future<void> init() async {
//     WidgetsFlutterBinding.ensureInitialized();
//     await Firebase.initializeApp(
//         options: DefaultFirebaseOptions.currentPlatform);

//     FirebaseUIAuth.configureProviders([EmailAuthProvider()]);

//     FirebaseAuth.instance.userChanges().listen(
//       (user) {
//         if (user != null) {
//           _loggeIn = true;
//         } else
//           _loggeIn = false;
//         notifyListeners();
//       },
//     );
//   }
// }
