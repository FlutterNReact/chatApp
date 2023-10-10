import 'dart:async';
import 'package:chatapp/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/utils/global_colors.dart';
import 'package:chatapp/view/intro_screens/onboarding_screen.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() {
    return _SplashViewState();
  }
}

class _SplashViewState extends State<SplashView> {
  OnboardingScreen builder = const OnboardingScreen();
  @override
  void reassemble() {
    setState(() {});
    super.reassemble();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait(
        [
          initProviders(),
        ],
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return builder;
        }
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
      },
    );
  }
}
