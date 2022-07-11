import 'package:flutter/material.dart';

class ScreenFlipBtn extends StatelessWidget {
  final bool isRegistrationForm;
  final Function toggleCard;

  const ScreenFlipBtn({
    Key? key,
    required this.isRegistrationForm,
    required this.toggleCard,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => toggleCard(),
      child: isRegistrationForm
          ? const Text('Back to login')
          : const Text('Register'),
    );
  }
}
