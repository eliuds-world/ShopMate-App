import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shopmate/pages/login_page.dart';

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  void logUserOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print("Error :$e ocuured");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              logUserOut();
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Text("this is the list page"),
      ),
    );
  }
}
