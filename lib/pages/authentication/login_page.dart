import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shopmate/services/authentication/auth_exceptions.dart';
import 'package:shopmate/services/authentication/auth_service.dart';
import 'package:shopmate/widgets/textformfield_widget.dart';
import 'package:shopmate/widgets/elevated_button_widget.dart';
import 'package:shopmate/services/authentication/show_error_snackbar.dart';

class LoginPage extends StatefulWidget {
  // const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
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
          child: Form(
            key: formKey,
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
                SizedBox(height: screenHeight * 0.15),
                TextFormFieldWidget(
                  controller: emailController,
                  hintText: "email",
                  obscureText: false,
                  icon: Icons.email,
                ),
                SizedBox(
                  height: screenHeight * 0.04,
                ),
                TextFormFieldWidget(
                  controller: passwordController,
                  hintText: "password",
                  obscureText: true,
                  icon: Icons.password,
                ),
                SizedBox(
                  height: screenHeight * 0.03,
                ),
                Text(
                  "Forgot your password ?",
                  style: TextStyle(
                    color: Color(0xFF3487AA),
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.40,
                ),
                ElevatedButtonWidget(
                  text: "Login",
                  onPressed: () async {
                    try {
                      await AuthService.firebase().logIn(
                        email: emailController.text,
                        password: passwordController.text,
                      );
                      formKey.currentState!.validate();
                      context.go("/list_page");
                    } on UserNotFoundAuthException {
                      await showErrorDialog(
                        context,
                        "Enter correct email",
                      );
                    } on WrongPasswordAuthException {
                      await showErrorDialog(
                        context,
                        "Enter Correct password",
                      );
                    } on GenericAuthException {
                      await showErrorDialog(
                        context,
                        "Authentication error",
                      );
                    }
                   
                  },
                ),
                SizedBox(
                  height: screenHeight * 0.015,
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
      ),
    );
  }
}
