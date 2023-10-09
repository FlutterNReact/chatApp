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
  PageController _controller = PageController();

  ////Keep track if we are on the last page
  bool onLastPge = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ////Page view
          PageView(
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

          ////Dot indicator
          Container(
            alignment: Alignment(0, 0.75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ////skip
                GestureDetector(
                  onTap: () {
                    _controller.jumpToPage(2);
                  },
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
                onLastPge
                    ? GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const WelcomeScreen();
                              },
                            ),
                          );
                        },
                        child: const Text(
                          'Done',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.blue,
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          _controller.nextPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeIn);
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
    );
  }
}
