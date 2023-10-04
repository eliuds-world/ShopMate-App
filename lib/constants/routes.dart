// import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shopmate/pages/HomeScreen/home_page.dart';
import 'package:shopmate/pages/AuthenticationScreen/login_page.dart';
import 'package:shopmate/pages/AuthenticationScreen/registration_page.dart';
import 'package:shopmate/pages/list_page.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => HomePage(),
    ),
    GoRoute(
      path: "/registration_page",
      builder: (context, state) => RegistrationPage(),
    ),
    GoRoute(
      path: "/login_page",
      builder: (context, state) => LoginPage(),
    ),
     GoRoute(
      path: "/list_page",
      builder: (context, state) => ListPage(),
    ),
  ],
);

//GoRouter data-Type
GoRouter createRouter() {
  return router;
}
