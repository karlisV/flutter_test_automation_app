import 'package:flutter/material.dart';

class LoginFormField extends StatelessWidget {
  final TextEditingController controller;
  final Map<String, dynamic> fieldProperties = {};
  final String type;

  LoginFormField({Key? key, required this.type, required this.controller})
      : super(key: key) {
    switch (type) {
      case 'PASSWORD':
        fieldProperties.addAll({
          "formText": "Enter your password",
          "obscureText": true,
          "emailFieldValidation": false
        });
        break;
      case 'PASSWORD_CONFIRM':
        fieldProperties.addAll({
          "formText": "Re-enter password",
          "obscureText": true,
          "emailFieldValidation": false
        });
        break;
      default:
        fieldProperties.addAll({
          "formText": "Enter your e-mail",
          "obscureText": false,
          "emailFieldValidation": true
        });
        break;
    }
  }

  String? _isEmailValid(String? value) {
    if (value == null ||
        value.isEmpty ||
        !value.contains(RegExp(r'^(.+)@(.+)$'))) {
      return 'Please enter valid email';
    }
    return null;
  }

  String? _isPwdValid(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter password';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: fieldProperties['formText'],
      ),
      obscureText: fieldProperties['obscureText'],
      controller: controller,
      validator: (String? value) => fieldProperties['emailFieldValidation']
          ? _isEmailValid(value)
          : _isPwdValid(value),
    );
  }
}
