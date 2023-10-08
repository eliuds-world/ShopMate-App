
import 'package:go_router/go_router.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shopmate/widgets/textformfield_widget.dart';
import 'package:shopmate/widgets/elevated_button_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopmate/services/Authentication/show_error_snackbar.dart';

class RegistrationPage extends StatefulWidget {
  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  //my textediting controllers
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
                  height: 60.0,
                ),
                Text(
                  "Registration",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 150.0,
                ),
                TextFormFieldWidget(
                  controller: emailController,
                  hintText: "email",
                  obscureText: false,
                  icon: Icons.email,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Enter Email";
                    } else {
                      return null;
                    }
                    // bool emailIsValid =
                    //     RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
                    //         .hasMatch(value);
                    // if (!emailIsValid) {
                    //   return "Enter Valid email";
                    // }
                  },
                ),
                SizedBox(
                  height: 40.0,
                ),
                TextFormFieldWidget(
                  controller: passwordController,
                  hintText: "password",
                  obscureText: true,
                  icon: Icons.password,
                ),
                SizedBox(
                  height: 350,
                ),
                ElevatedButtonWidget(
                    text: "Register",
                    onPressed: () async{
                      try {
                        await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text,
                        );
                        final user = FirebaseAuth.instance.currentUser;
                        await user?.sendEmailVerification();
                        context.go("/verify_page");
                      } on FirebaseAuthException catch (error) {
                        if (error.code == "weak-password") {
                          await showErrorDialog(
                            context,
                            "Provide a strong password",
                          );
                        } else if (error.code == "email-already-in-use") {
                          await showErrorDialog(
                            context,
                            "Email is already in use, provide a new email",
                          );
                        } else if (error.code == 'invalid-email') {
                          await showErrorDialog(context, 'Invalid-email');
                        } else if (error.code == 'unknown') {
                          await showErrorDialog(
                              context, 'Email and Password Fields are required');
                        } else {
                          await showErrorDialog(context, "Error ${error.code}");
                        }
                      } catch (error) {
                        await showErrorDialog(
                          context,
                          error.toString(),
                        );

                      if (formKey.currentState!.validate()) {
                        print("${emailController.text}");
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
                        text: 'Already have an account ? ',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: 'Log in',
                        style: TextStyle(
                          color: Color(0xFF3487AA),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            context.go("/login_page");
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
