import 'package:chatapp/providers/providers.dart';
import 'package:flutter/material.dart';

enum AuthMode {
  login,
  signUp,
  forgotPassword,
  otp,
  newPassword,
}

class AuthController extends ValueNotifier<AuthMode> {
  AuthController(super.value);
  switchMode(AuthMode mode) {
    value = mode;
  }

  Future logIn({required String email, required String password}) {
    return auth.logIn(email: email, password: password);
  }

  Future logOut() {
    return auth.logOut();
  }
}
