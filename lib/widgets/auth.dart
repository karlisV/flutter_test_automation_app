import 'package:flutter/material.dart';

import '../widgets/login_form_field.dart';
import '../widgets/screen_flip_button.dart';
import '../widgets/google_sign_in_button.dart';
import '../widgets/sign_in_button.dart';

class AuthWidget extends StatefulWidget {
  final dynamic cardFlipController;
  final bool isRegistrationForm;
  final String title;

  const AuthWidget({
    Key? key,
    required this.cardFlipController,
    required this.isRegistrationForm,
    required this.title,
  }) : super(key: key);

  @override
  State<AuthWidget> createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final emailTextController = TextEditingController();
  final pwdTextController = TextEditingController();
  final confirmPwdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 40, bottom: 80),
              child: Text(
                widget.title,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
              ),
            ),
            Form(
              key: formKey,
              child: Column(
                children: [
                  LoginFormField(
                    type: 'EMAIL',
                    controller: emailTextController,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                  ),
                  LoginFormField(
                    type: 'PASSWORD',
                    controller: pwdTextController,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0),
                  ),
                  Container(
                      child: widget.isRegistrationForm
                          ? Padding(
                              padding: const EdgeInsets.only(bottom: 50.0),
                              child: LoginFormField(
                                type: 'PASSWORD_CONFIRM',
                                controller: confirmPwdController,
                              ),
                            )
                          : null),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SignInBtn(
                        formKey: formKey,
                        emailController: emailTextController,
                        pwdController: pwdTextController,
                        confirmPwdController: confirmPwdController,
                        isRegistration: widget.isRegistrationForm,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25.0),
                      ),
                      ScreenFlipBtn(
                          toggleCard: widget.cardFlipController.toggleCard,
                          isRegistrationForm: widget.isRegistrationForm)
                    ],
                  ),
                  Container(
                    child: widget.isRegistrationForm
                        ? null
                        : Column(
                            children: const [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 20.0),
                              ),
                              GoogleSignInBtn(),
                            ],
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
