import 'dart:ffi';
import 'package:shopmate/providers/authentication/auth_provider.dart';
import 'package:shopmate/models/authentication/auth_user_model.dart';
import 'package:shopmate/providers/authentication/firebase_auth_providers.dart';

class AuthService implements AuthProvider {
  final AuthProvider provider;
  const AuthService(this.provider);

  factory AuthService.firebase() => AuthService(
    FirebaseAuthProvider(),
  );

  @override
  Future<AuthUserModel> createUser({
    required String email,
    required String password,
  }) => provider.createUser(  
        email: email,
        password: password,
      );

  @override
  AuthUserModel? get currentUser => provider.currentUser;

  @override
  Future<AuthUserModel> logIn({
    required String email,
    required String password,
  }) => provider.logIn(
        email: email,
        password: password,
      );

  @override
  Future<Void> logOut() => provider.logOut();

  @override
  Future<void> initialize() => provider.initialize();
}
