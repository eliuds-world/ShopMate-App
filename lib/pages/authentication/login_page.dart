import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shopmate/widgets/textformfield_widget.dart';
import 'package:shopmate/widgets/elevated_button_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopmate/services/Authentication/show_error_snackbar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //my textediting controllers
  late final emailController = TextEditingController();
  late final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: screenHeight * 0.07,
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
                height: screenHeight *0.15
              ),
              TextFormFieldWidget(
                controller: emailController,
                hintText: "email",
                obscureText: false,
                icon: Icons.email,
              ),
              SizedBox(
                height: screenHeight *0.04,
              ),
              TextFormFieldWidget(
                controller: passwordController,
                hintText: "password",
                obscureText: true,
                icon: Icons.password,
              ),
              SizedBox(
                height: screenHeight *0.03,
              ),
              Text(
                "Forgot your password ?",
                style: TextStyle(
                  color: Color(0xFF3487AA),
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: screenHeight *0.40,
              ),
              ElevatedButtonWidget(
                text: "Login",
                onPressed: () async {
                  try {
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: emailController.text,
                      password: passwordController.text,
                    );
                    final user = FirebaseAuth.instance.currentUser;
                    if (user?.emailVerified ?? false) {
                      //user verified
                      context.go("/list_page");
                    } else {
                      //user email not verified
                      context.go("/verify_page");
                    }
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
                    } else if (error.code == 'unknown') {
                      showErrorDialog(
                          context, 'Email and Password Fields are required');
                    } else {
                      print(error.code);
                    }
                  } catch (error) {
                    await showErrorDialog(
                      context,
                      error.toString(),
                    );
                  }
                },
              ),
              SizedBox(
                height: screenHeight *0.015,
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



