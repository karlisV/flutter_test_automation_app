import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_automation/screens/home_screen.dart';

import '../providers/auth.dart';

class GoogleSignInBtn extends StatelessWidget {
  const GoogleSignInBtn({Key? key}) : super(key: key);

  Future<void> _googleAuthenticate(context) async {
    try {
      final navigator = Navigator.of(context);

      await Provider.of<AuthProvider>(context, listen: false)
          .signInWithGoogle();

      navigator.pushReplacementNamed(HomeScreen.routeName);
    } on AssertionError catch (e) {
      log("Sign-in modal closed");
      log("$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _googleAuthenticate(context),
      child: SizedBox(
        width: 300,
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.network(
                'http://pngimg.com/uploads/google/google_PNG19635.png',
                fit: BoxFit.cover),
            const SizedBox(
              width: 5.0,
            ),
            const Text('Sign-in with Google')
          ],
        ),
      ),
    );
  }
}
