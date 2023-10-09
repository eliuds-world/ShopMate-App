import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shopmate/services/Authentication/auth_exceptions.dart';
import 'package:shopmate/services/Authentication/auth_service.dart';
import 'package:shopmate/widgets/textformfield_widget.dart';
import 'package:shopmate/widgets/elevated_button_widget.dart';
// import 'package:firebase_auth/firebase_auth.dart';
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
  late final fullNameController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    fullNameController.dispose();
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
                  "Registration",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.15,
                ),
                TextFormFieldWidget(
                    controller: fullNameController,
                    hintText: "full Name",
                    obscureText: false),
                SizedBox(
                  height: screenHeight * 0.04,
                ),
                TextFormFieldWidget(
                  controller: emailController,
                  hintText: "email",
                  obscureText: false,
                  icon: Icons.email,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
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
                  height: screenHeight * 0.04,
                ),
                TextFormFieldWidget(
                  controller: passwordController,
                  hintText: "password",
                  obscureText: true,
                  icon: Icons.password,
                ),
                SizedBox(
                  height: screenHeight * 0.35,
                ),
                ElevatedButtonWidget(
                  text: "Register",
                  onPressed: () async {
                    try {
                      await AuthService.firebase().createUser(
                        email: emailController.text,
                        password: passwordController.text,
                      );

                      //adding user details to firstore collection
                      addUserCollectionDetails(
                        fullNameController.text,
                        emailController.text,
                      );
                    } on WeakPasswordAuthExceptions {
                      await showErrorDialog(
                        context,
                        "Provide a strong password",
                      );
                    } on EmailAlreadyInUseAuthException {
                      await showErrorDialog(
                        context,
                        "Email is already in use, provide a new email",
                      );
                    } on InvalidEmailAuthException {
                      await showErrorDialog(context, 'Invalid-email');
                    } on GenericAuthException {
                      await showErrorDialog(
                        context,
                        "Authentication error",
                      );
                      if (formKey.currentState!.validate()) {
                        print("${emailController.text}");
                      }
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

Future addUserCollectionDetails(String fullName, String email) async {
  await FirebaseFirestore.instance.collection("users").add(
    {
      "full name": fullName,
      "email": email,
    },
  );
}
