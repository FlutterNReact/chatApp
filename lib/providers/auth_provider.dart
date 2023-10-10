import 'dart:convert';

import 'package:chatapp/providers/storage_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ValueNotifier<User?> {
  AuthProvider({required this.storage}) : super(null);
  final Storage storage;
  bool error = true;
  bool isLogin = false;
  AuthCredential? credential;
  Future init() async {
    await initializeFlutterFire();
  }

  Future initializeFlutterFire() async {
    if (credential != null) return;
    final credential_ = storage.getString('credential');
    if (credential_ != null) {
      try {
        final json = jsonDecode(credential_) as Map;
        print(json);
        credential = AuthCredential(
          accessToken: json['accessToken'],
          providerId: json['providerId'],
          signInMethod: json['signInMethod'],
          token: json['token'],
        );
      } catch (_) {}
    }
    try {
      if (credential != null) {
        await FirebaseAuth.instance.signInWithCredential(credential!);
      }
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        isLogin = user != null;
        value = user;
      });
      error = false;
    } catch (e) {
      print(e);
      error = true;
      notifyListeners();
    }
  }

  Future logIn({required String email, required String password}) async {
    final credentials = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    credential = credentials.credential;
    if (credentials.credential != null) {
      storage.setString(
        'credential',
        jsonEncode(credentials.credential?.asMap()),
      );
    }
    isLogin = credentials.user != null;
    value = credentials.user;
    return credentials;
  }

  Future logOut() async {
    credential = null;
    isLogin = false;
    value = null;
    return await FirebaseAuth.instance.signOut();
  }
}
