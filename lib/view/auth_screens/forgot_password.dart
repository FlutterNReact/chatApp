import 'package:chatapp/controllers/auth_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../utils/global_colors.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key, required this.controller});
  final AuthController controller;
  @override
  State createState() => ForgotPasswordPageState();
}

class ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();

    Future passwordReset() async {
      try {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: _emailController.text.trim());
        if (mounted) {
          showDialog(
            context: context,
            builder: (context) {
              return const AlertDialog(
                content: Text('Password reset link sent! check your email'),
              );
            },
          );
        }
      } on FirebaseAuthException catch (e) {
        print(e);
        if (mounted) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(e.message.toString()),
              );
            },
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: GlobalColors.mainColor,
        title: const Text('Forgot Password'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 30),
            const Text(
              'Forgot Password 🤔',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                'We need your email address so we can send '
                'you the password reset code.',
                style: TextStyle(
                  color: Colors.grey[850],
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: 'Email Address',
                  fillColor: Colors.grey[100],
                  filled: true),
            ),
            const SizedBox(height: 10),
            Container(
              alignment: Alignment.center,
              height: 55,
              decoration: BoxDecoration(
                color: GlobalColors.mainColor,
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: MaterialButton(
                onPressed: () {
                  widget.controller.switchMode(AuthMode.otp);
                },
                child: const Text('Next'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
