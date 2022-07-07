import 'package:flutter/material.dart';

class RegisterWidget extends StatefulWidget {
  final dynamic cardFlipController;
  const RegisterWidget({Key? key, required this.cardFlipController})
      : super(key: key);

  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () => widget.cardFlipController.toggleCard(),
        child: const Text("Back to Login"),
      ),
    );
  }
}
