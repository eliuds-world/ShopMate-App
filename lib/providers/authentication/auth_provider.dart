import 'dart:ffi'; 
import 'package:shopmate/models/authentication/auth_user_model.dart';

abstract class AuthProvider {
  Future<void> initialize();
  AuthUserModel? get currentUser;
  Future<AuthUserModel> logIn({
    required String email,
    required String password,
  });
  Future<AuthUserModel> createUser({
    required String email,
    required String password,
  });
  Future<Void> logOut();
  
}
