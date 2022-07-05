import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  Future<void> login(String email, String pwd) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: pwd);
  }


  bool isLoggedIn() {
    return FirebaseAuth.instance.currentUser != null;
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
    notifyListeners();
  }

}
