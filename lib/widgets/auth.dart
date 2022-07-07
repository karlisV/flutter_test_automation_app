import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../screens/home_screen.dart';

class AuthWidget extends StatefulWidget {
  final dynamic cardFlipController;
  final bool registrationForm;
  final String title;

  const AuthWidget({
    Key? key,
    required this.cardFlipController,
    required this.registrationForm,
    required this.title,
  }) : super(key: key);

  @override
  State<AuthWidget> createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final emailTextController = TextEditingController();
  final pwdTextController = TextEditingController();

  Future<void> _authenticate(String email, String pwd) async {
    widget.registrationForm
        ? await Provider.of<AuthProvider>(context, listen: false)
            .register(email, pwd)
        : await Provider.of<AuthProvider>(context, listen: false)
            .login(email, pwd);
  }

  Future<void> _googleAuthenticate() async {
    await Provider.of<AuthProvider>(context, listen: false).signInWithGoogle();
  }

  void _navigateToHomeScreen() {
    if (!mounted) return;

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
    );
  }

  SnackBar snackBar(String text) {
    return SnackBar(
      content: Text(text),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 40, bottom: 80),
            child: Text(
              widget.title,
              style: const TextStyle(fontSize: 20),
            ),
          ),
          Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Enter your email',
                  ),
                  controller: emailTextController,
                  validator: (String? value) {
                    if (value == null ||
                        value.isEmpty ||
                        !value.contains(RegExp(r'^(.+)@(.+)$'))) {
                      return 'Please enter valid email';
                    }
                    return null;
                  },
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 20.0)),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Enter your password',
                  ),
                  obscureText: true,
                  controller: pwdTextController,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter password';
                    }
                    return null;
                  },
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          try {
                            await _authenticate(emailTextController.text,
                                pwdTextController.text);

                            _navigateToHomeScreen();
                          } on FirebaseAuthException catch (e) {
                            log(e.code);
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar(e.code));
                          }
                        } else {
                          log('Form validation triggered');
                        }
                      },
                      child: Text(widget.title),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.0),
                    ),
                    ElevatedButton(
                      onPressed: () => widget.cardFlipController.toggleCard(),
                      child: widget.registrationForm
                          ? const Text('Back to login')
                          : const Text('Register'),
                    )
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                ),
                Container(
                  child: widget.registrationForm
                      ? null
                      : InkWell(
                          onTap: () async {
                            try {
                              await _googleAuthenticate();

                              _navigateToHomeScreen();
                            } on AssertionError catch (e) {
                              log("Sign-in modal closed");
                              log("$e");
                            }
                          },
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
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
