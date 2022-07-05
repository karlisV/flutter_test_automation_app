import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:test_automation/providers/auth.dart';

import 'home_screen.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = '/authenticate';

  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    final emailTextController = TextEditingController();
    final pwdTextController = TextEditingController();

    Future<void> _authenticate(String email, String pwd) async {
      await Provider.of<AuthProvider>(context, listen: false).login(email, pwd);
    }

    SnackBar snackBar(String text) {
      return SnackBar(
        content: Text(text),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Test automation demo app'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                    const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.0)),
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
                        padding: EdgeInsets.symmetric(vertical: 20.0)),
                    ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            try {
                              await _authenticate(emailTextController.text,
                                  pwdTextController.text);

                              if (!mounted) return;

                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => const HomeScreen(),
                                ),
                              );
                            } on FirebaseAuthException catch (e) {
                              log(e.code);
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar(e.code));
                            }
                          } else {
                            log('Form validation triggered');
                          }
                        },
                        child: const Text('Login'))
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
