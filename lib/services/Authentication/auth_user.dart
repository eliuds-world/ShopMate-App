import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/foundation.dart';

@immutable 
class AuthUser {
  final String? email;
  const AuthUser({
    required this.email,
  });

  factory AuthUser.fromFirebase(User user) => AuthUser(email: user.email);
 }