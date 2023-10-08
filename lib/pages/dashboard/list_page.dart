import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ListPage extends StatelessWidget {
  ListPage({super.key});

  final user = FirebaseAuth.instance.currentUser;
  void logUserOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              logUserOut();
              context.go("/login_page");
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Text("this is the list page for ${user?.email ?? 'Guest'}")
,
      ),
    );
  }
}
