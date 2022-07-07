import 'package:flutter/material.dart';

import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';

import '../widgets/auth.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = '/authenticate';

  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late FlipCardController flipCardController;

  @override
  void initState() {
    super.initState();
    flipCardController = FlipCardController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test automation demo app'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: FlipCard(
          controller: flipCardController,
          flipOnTouch: false,
          front: AuthWidget(
            registrationForm: false,
            title: 'Login',
            cardFlipController: flipCardController,
          ),
          back: AuthWidget(
            registrationForm: true,
            title: 'Register',
            cardFlipController: flipCardController,
          ),
        ),
      ),
    );
  }
}
