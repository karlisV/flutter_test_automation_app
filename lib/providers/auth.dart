import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider with ChangeNotifier {
  Future<void> login(String email, String pwd) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: pwd);
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  bool isLoggedIn() {
    return FirebaseAuth.instance.currentUser != null;
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    notifyListeners();
  }
}
