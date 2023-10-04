import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shopmate/widgets/textfield_widget.dart';
import 'package:shopmate/widgets/elevated_button_widget.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //my textediting controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  
  Future loginUserIn() async {
    // showDialog(
    //   context: context, // Use the context from the onPressed callback
    //   builder: (context) {
    //     return Center(
    //       child: CircularProgressIndicator(),
    //     );
    //   },
    // );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    } on FirebaseAuthException catch (error) {
      if (error.code == "user-not-found") {
        print("No user found with that email");
      } else if (error.code == "wrong-password") {
        print("wrong password");
      }
    }
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
                  final loginResult = await loginUserIn();
                  if (loginResult == loginResult.success) {
                    context.go("/list_page");
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
