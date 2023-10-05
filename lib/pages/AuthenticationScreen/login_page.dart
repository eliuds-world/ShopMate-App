import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shopmate/widgets/textfield_widget.dart';
import 'package:shopmate/widgets/elevated_button_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //my textediting controllers
  late final emailController = TextEditingController();
  late final passwordController = TextEditingController();
  // Future loginUserIn() async {
  //   try {
  //     await FirebaseAuth.instance.signInWithEmailAndPassword(
  //       email: emailController.text,
  //       password: passwordController.text,
  //     );
  //   } on FirebaseAuthException catch (error) {
  //     if (error.code == "user-not-found") {
  //       print("No user found with that email");
  //     } else if (error.code == "wrong-password") {
  //       print("wrong password");
  //     }
  //   }
  // }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 60.0,
              ),
              Text(
                "Login",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 150.0,
              ),
              TextFieldWidget(
                controller: emailController,
                hintText: "email",
                obscureText: false,
                icon: Icons.email,
              ),
              SizedBox(
                height: 40.0,
              ),
              TextFieldWidget(
                controller: passwordController,
                hintText: "password",
                obscureText: true,
                icon: Icons.password,
              ),
              SizedBox(
                height: 30.0,
              ),
              Text(
                "Forgot your password ?",
                style: TextStyle(
                  color: Color(0xFF3487AA),
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 350,
              ),
              ElevatedButtonWidget(
                text: "Login",
                onPressed: () async {
                  try {
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: emailController.text,
                      password: passwordController.text,
                    );
                    context.go("/list_page");
                  } on FirebaseAuthException catch (error) {
                    if (error.code == "user-not-found") {
                      await showErrorDialog(
                        context,
                        "Enter correct email",
                      );
                    } else if (error.code == "wrong-password") {
                      await showErrorDialog(
                        context,
                        "Enter Correct password",
                      );
                    } else if (error.code == 'network-request-failed') {
                      showErrorDialog(context, 'No Internet Connection');
                    } else if (error.code == 'too-many-requests') {
                      return showErrorDialog(
                          context, 'Too many attempts please try later');
                    } else if (error.code == 'unknown') {
                      showErrorDialog(
                          context, 'Email and Password Fields are required');
                    } else {
                      print(error.code);
                    }
                  }
                },
              ),
              SizedBox(
                height: 15,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Don't have an account ? ",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                      text: 'Register',
                      style: TextStyle(
                        color: Color(0xFF3487AA),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          context.go("/registration_page");
                        },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Future<void> showErrorDialog(
//   BuildContext context,
//   String text,
// ) {
//   return showDialog(
//     context: context,
//     builder: (context) {
//       return AlertDialog(
//         title: Text("An error occured"),
//         content: Text(text),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             child: Text("Ok"),
//           ),
//         ],
//       );
//     },
//   );
// }

Future<void> showErrorDialog(
  BuildContext context,
  String text,
) async {
  final scaffoldMessenger = ScaffoldMessenger.of(context);

  scaffoldMessenger.showSnackBar(
    SnackBar(
      content: Text(text),
      action: SnackBarAction(
        label: 'OK',
        onPressed: () {
          scaffoldMessenger.hideCurrentSnackBar();
        },
      ),
    ),
  );
}
