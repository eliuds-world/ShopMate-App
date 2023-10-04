import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shopmate/widgets/elevated_button_widget.dart';
// import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/homepage.jpeg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 60,
                ),
                Text(
                  "SHOPMATE APP",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(height: 235),
                Center(
                  child: Container(
                    width: 300,
                    child: Text(
                      "Welcome to ShopMate App,your comprehensive solution for modernizing the way you manage your shopping list.ShopMate eliminates the need for paper-lists and forgetfulness by encapsulating everything you need in an easy to use mobile application.Join Us , and make your shopping experience, more organized and collaborative",
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 200,
                ),
                ElevatedButtonWidget(
                  text: "Register",
                  onPressed: () {
                    context.go("/registration_page");
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButtonWidget(
                  text: "Login",
                  onPressed: () {
                    context.go("/login_page");
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
