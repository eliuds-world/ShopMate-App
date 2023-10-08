// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:shopmate/widgets/elevated_button_widget.dart';


// class WelcomePage extends StatelessWidget {
//   WelcomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//     final screenWidth = MediaQuery.of(context).size.width;

//     final double shopmatePadding = screenHeight * 0.5;
//     final double titleFontSize = screenWidth * 0.08;
//     final double descriptionFontSize = screenWidth * 0.04;

//     return Container(
//       decoration: BoxDecoration(
//         image: DecorationImage(
//           image: AssetImage("assets/homepage.jpeg"),
//           fit: BoxFit.cover,
//         ),
//       ),
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         body: SingleChildScrollView(
//           child: Center(
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: 60,
//                 ),
//                 Text(
//                   "SHOPMATE APP",
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 20.0,
//                   ),
//                 ),
//                 SizedBox(height: 235),
//                 Center(
//                   child: Container(
//                     width: 300,
//                     child: Text(
//                       "Welcome to ShopMate App,your comprehensive solution for modernizing the way you manage your shopping list.ShopMate eliminates the need for paper-lists and forgetfulness by encapsulating everything you need in an easy to use mobile application.Join Us , and make your shopping experience, more organized and collaborative",
//                       style: TextStyle(
//                         fontSize: 16.0,
//                         color: Colors.black,
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 200,
//                 ),
//                 Column(
//                   children: [
//                     ElevatedButtonWidget(
//                       text: "Register",
//                       onPressed: () {
//                         context.go("/registration_page");
//                       },
//                     ),
//                     SizedBox(
//                       height: 30,
//                     ),
//                     ElevatedButtonWidget(
//                       text: "Login",
//                       onPressed: () {
//                         context.go("/login_page");
//                       },
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shopmate/widgets/elevated_button_widget.dart';

class WelcomePage extends StatelessWidget {
  WelcomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    // Retrieve screen dimensions
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/welcomepage.jpeg"),
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
                  height: screenHeight *0.07,
                ),
                Text(
                  "SHOPMATE APP",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(height: screenHeight * 0.15),
                Center(
                  child: Container(
                    width: screenWidth * 0.9,
                    child: Text(
                      "Welcome to ShopMate App, your comprehensive solution for modernizing the way you manage your shopping list. ShopMate eliminates the need for paper-lists and forgetfulness by encapsulating everything you need in an easy to use mobile application. Join Us, and make your shopping experience more organized and collaborative.",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.40,
                ),
                Column(
                  children: [
                    ElevatedButtonWidget(
                      text: "Register",
                      onPressed: () {
                        context.go("/registration_page");
                      },
                    ),
                    SizedBox(
                      height: screenHeight * 0.025,
                    ),
                    ElevatedButtonWidget(
                      text: "Login",
                      onPressed: () {
                        context.go("/login_page");
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
