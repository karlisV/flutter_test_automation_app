import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../screens/home_screen.dart';

class SignInBtn extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController pwdController;
  final bool isRegistration;
  final GlobalKey<FormState> formKey;
  final TextEditingController confirmPwdController;

  const SignInBtn({
    Key? key,
    required this.formKey,
    required this.emailController,
    required this.pwdController,
    required this.isRegistration,
    required this.confirmPwdController,
  }) : super(key: key);

  Future<void> _authenticate(
      String email, String pwd, bool isRegistration, BuildContext ctx) async {
    isRegistration
        ? await Provider.of<AuthProvider>(ctx, listen: false)
            .register(email, pwd)
        : await Provider.of<AuthProvider>(ctx, listen: false).login(email, pwd);
  }

  String title() {
    return isRegistration ? "Register" : "Login";
  }

  bool pwdMatch() {
    if (isRegistration) {
      return pwdController.text == confirmPwdController.text;
    }
    return true;
  }

  String parseFirebaseErrorMsg(FirebaseAuthException e) {
    if (e.message! != 'Given String is empty or null') {
      return e.message!;
    } else {
      return e.code;
    }
  }

  SnackBar snackBar(String text) {
    return SnackBar(
      content: Text(text),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        if (formKey.currentState!.validate() && pwdMatch()) {
          try {
            final navigator = Navigator.of(context);

            await _authenticate(
              emailController.text.trim(),
              pwdController.text,
              isRegistration,
              context,
            );

            navigator.pushReplacementNamed(HomeScreen.routeName);
          } on FirebaseAuthException catch (e) {
            log(e.code);
            ScaffoldMessenger.of(context).showSnackBar(snackBar(
              parseFirebaseErrorMsg(e),
            ));
          }
        } else if (!pwdMatch()) {
          ScaffoldMessenger.of(context).showSnackBar(
            snackBar("Passwords are not equal"),
          );
          log('Form validation triggered');
        } else {
          log('Form validation triggered');
        }
      },
      child: Text(
        title(),
      ),
    );
  }
}
