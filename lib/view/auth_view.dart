import 'package:chatapp/controllers/auth_controller.dart';
import 'package:chatapp/view/auth_screens/forgot_password.dart';
import 'package:chatapp/view/auth_screens/otp_screen.dart';
import 'package:chatapp/view/auth_screens/signup_page.dart';
import 'package:chatapp/view/widgets/new_password.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/view/auth_screens/login_view.dart';

class AuthView extends StatelessWidget {
  AuthView({Key? key, this.mode}) : super(key: key);
  final AuthMode? mode;
  late final controller = AuthController(mode ?? AuthMode.login);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (context, value, child) {
        switch (value) {
          case AuthMode.newPassword:
            return NewPassword(controller: controller);
          case AuthMode.otp:
            return OTPScreen(controller: controller);
          case AuthMode.forgotPassword:
            return ForgotPasswordPage(controller: controller);
          case AuthMode.signUp:
            return SignUpPage(controller: controller);
          case AuthMode.login:
            return LoginView(controller: controller);
        }
      },
    );
  }
}
