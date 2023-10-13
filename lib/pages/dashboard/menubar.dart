import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shopmate/services/authentication/auth_service.dart';
// import 'package:shopmate/services/crud_lists.dart';

class NavBarWidget extends StatelessWidget {
  const NavBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color(0xFFD9D9D9),
      child: ListView(
        children: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back),
          ),
          ListTile(
            title: TextButton(
              onPressed: () {},
              child: Text(
                "Add Collaborator",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ),
          ListTile(
            title: TextButton(
              onPressed: () {},
              child: Text(
                "Manage Collaborator",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ),
          ListTile(
            title: TextButton(
              onPressed: () {},
              child: Text(
                "Profile Settings",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ),
          ListTile(
            title: TextButton(
              onPressed: () {
                loggingOut();
                context.go("/login_page");
              },
              child: Text(
                "Log Out",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> loggingOut() async {
  await AuthService.firebase().logOut();
}
