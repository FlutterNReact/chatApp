import 'dart:async';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:chatapp/providers/providers.dart';
import 'package:chatapp/providers/storage_provider.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/utils/global_colors.dart';
// import 'package:chatapp/view/login_view.dart';
import 'package:chatapp/view/intro_screens/onboarding_screen.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  get builder => const OnboardingScreen();

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 1), () {
      debugPrint('1 seconds completed');
      Future.wait(
        [
          initProviders(),
        ],
      ).then(
        (_) => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const OnboardingScreen(),
          ),
        ),
      );
    });
    return Scaffold(
      backgroundColor: GlobalColors.mainColor,
      body: const Center(
        child: Center(
          child: Text(
            'ChatApp',
            style: TextStyle(
              color: Colors.white,
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
