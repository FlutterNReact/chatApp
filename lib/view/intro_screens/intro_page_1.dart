import 'package:flutter/material.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children:  [
                Image.asset(
                    'assets/images/page1.png',
                  height: 500,
                ),
                const SizedBox(height: 0),

                const Text(
                    'First to know',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                    'All news in one place, be the '
                    'first to know last news',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 30),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
