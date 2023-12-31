import 'package:go_router/go_router.dart';
import 'package:shopmate/pages/authentication/welcome_page.dart';
import 'package:shopmate/pages/authentication/login_page.dart';
import 'package:shopmate/pages/authentication/registration_page.dart';
import 'package:shopmate/pages/dashboard/list_page.dart';
import 'package:shopmate/pages/dashboard/new_list_page.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => WelcomePage(),
    ),
    GoRoute(
      path: "/new_list_page",
      builder: (context, state) => NewListPage(),
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
