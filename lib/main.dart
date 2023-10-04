import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shopmate/firebase_options.dart';
import 'package:shopmate/pages/routes.dart';

final router = createRouter();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const ShopMate());
}

class ShopMate extends StatelessWidget {
  const ShopMate({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
    );
  }
}
