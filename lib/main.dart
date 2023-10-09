import 'package:flutter/material.dart';
import 'package:shopmate/constants/routes.dart';
import 'package:shopmate/services/Authentication/auth_service.dart';

final router = createRouter();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await AuthService.firebase().initialize();
  runApp(const ShopMate());
}

class ShopMate extends StatelessWidget {
  const ShopMate({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
