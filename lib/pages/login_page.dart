import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shopmate/widgets/textfield_widget.dart';
import 'package:shopmate/widgets/elevated_button_widget.dart';
// import 'package:go_router/go_router.dart';

class LoginPage extends StatelessWidget {
  //my textediting controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void loginUser() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
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
                onPressed: () {
                  context.go("/list_page");
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
