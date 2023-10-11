
import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart'
    show FirebaseAuth, FirebaseAuthException;
import 'package:firebase_core/firebase_core.dart';
import 'package:shopmate/firebase_options.dart';
import 'package:shopmate/providers/authentication/auth_provider.dart';
import 'package:shopmate/models/authentication/auth_user_model.dart';
import 'package:shopmate/services/Authentication/auth_exceptions.dart';

class FirebaseAuthProvider implements AuthProvider {
  @override
  Future<AuthUserModel> createUser({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = currentUser; 
      if (user != null) {
        return user;
      } else {
        throw UserNotLoggedInAuthException();
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == "weak-password") {
        throw WeakPasswordAuthExceptions();
      } else if (error.code == "email-already-in-use") {
        throw EmailAlreadyInUseAuthException();
      } else if (error.code == 'invalid-email') {
        throw InvalidEmailAuthException();
      } else {
        throw GenericAuthException();
      }
    } catch (error) {
      throw GenericAuthException();
    }
  }

  @override
  AuthUserModel? get currentUser {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return AuthUserModel.fromFirebase(user);
    } else {
      return null;
    }
  }

  @override
  Future<AuthUserModel> logIn({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = currentUser;
      if (user != null) {
        return user;
      } else {
        throw UserNotLoggedInAuthException();
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == "user-not-found") {
        throw UserNotFoundAuthException();
      } else if (error.code == "wrong-password") {
        throw WrongPasswordAuthException();
      } else {
        throw GenericAuthException();
      }
    } catch (error) {
      throw GenericAuthException();
    }
  }

  @override
  Future<void> initialize() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  @override
  Future<Void> logOut() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseAuth.instance.signOut();
    } else {
      throw UserNotLoggedInAuthException();
    }
    throw Exception();
  }
}
