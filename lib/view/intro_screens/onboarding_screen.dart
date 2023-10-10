import 'package:chatapp/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/view/intro_screens/intro_page_1.dart';
import 'package:chatapp/view/welcome_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'intro_page_2.dart';
import 'intro_page_3.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  ////Controller to keep track of which page we are on
  final PageController _controller = PageController();
  @override
  void initState() {
    storage.setBool('onboardingDone', false);
    auth.init();
    super.initState();
  }

  ////Keep track if we are on the last page
  bool onLastPge = false;
  _close() async {
    await storage.setBool('onboardingDone', true);
    setState(() {});
  }

  _skip() {
    _close();
    // _controller.jumpToPage(2);
  }

  @override
  Widget build(BuildContext context) {
    if (storage.getBool('onboardingDone') == true) {
      return AnimatedOpacity(
        opacity: 1,
        duration: Duration(seconds: 1),
        child: const WelcomeScreen(),
      );
    }
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ////Page view
            Expanded(
              child: PageView(
                controller: _controller,
                onPageChanged: (index) {
                  setState(() {
                    onLastPge = (index == 2);
                  });
                },
                children: const [
                  IntroPage1(),
                  IntroPage2(),
                  IntroPage3(),
                ],
              ),
            ),

            ////Dot indicator
            Container(
              alignment: const Alignment(0, 0.75),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ////skip
                  GestureDetector(
                    onTap: _skip,
                    child: const Text(
                      'Skip',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                      ),
                    ),
                  ),

                  SmoothPageIndicator(controller: _controller, count: 3),

                  //// next or done
                  if (onLastPge)
                    GestureDetector(
                      onTap: _close,
                      child: const Text(
                        'Done',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  if (!onLastPge)
                    GestureDetector(
                      onTap: () {
                        _controller.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                        );
                      },
                      child: const Text(
                        'Next',
                        style: TextStyle(fontSize: 16, color: Colors.blue),
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
