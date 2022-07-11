import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:herewego/pages/signin_page.dart';
import 'package:herewego/services/prefs_service.dart';

class AuthService {
  static final _auth = FirebaseAuth.instance;

  // #LOGIN
  static Future<User?> signInUser(
      BuildContext context, String email, String password) async {
    try {
      _auth.signInWithEmailAndPassword(email: email, password: password);
      final User? user = _auth.currentUser;
      return user;
    } catch (e) {
      print(e);
    }
    return null;
  }

// #REGISTRATION
  static Future<User?> signUpUser(
      BuildContext context, String email, String password, String name) async {
    try {
      var authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final User? user = authResult.user;
      return user;
    } catch (e) {
      print(e);
    }
    return null;
  }

// #REMOVE
  static void signOutUser(BuildContext context) async {
    _auth.signOut();
    Prefs.removeUserId().then(
      (value) {
        Navigator.pushReplacementNamed(context, SignInPage.id);
      },
    );
  }
}
