import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/foundation.dart';

@immutable 
class AuthUserModel {
  final String? email;
  const AuthUserModel({
    required this.email,
  });

  factory AuthUserModel.fromFirebase(User user) => AuthUserModel(email: user.email);
 }