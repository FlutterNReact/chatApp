import 'package:chatapp/controllers/auth_controller.dart';
import 'package:chatapp/view/widgets/button_global.dart';
import 'package:chatapp/view/widgets/text_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
  }

  bool _passwordResetting = false;
  Future _passwordReset() async {
    if (_passwordResetting) return;
    FocusScope.of(context).unfocus();
    setState(() {
      _passwordResetting = true;
    });
    String? message;
    String messageLabel = "Alert";

    try {
      if (mounted) {
        showDialog(
          context: context,
          useSafeArea: false,
          builder: (context) => const Material(
            color: Colors.black12,
            child: Center(child: CircularProgressIndicator()),
          ),
        );
      }
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());

      message = 'Password reset link sent! check your email';
      messageLabel = "Alert";
    } on FirebaseException catch (e) {
      if (kDebugMode) print(e);
      message = e.message?.toString() ?? e.toString();
      messageLabel = "Error";
    } catch (e) {
      if (kDebugMode) print(e);
      message = e.toString();
      messageLabel = "Error";
    }
    if (!mounted) return;
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
        content: Text(
          message!,
        ),
        title: Text(messageLabel),
      ),
    );
    if (!mounted) return;
    Navigator.of(context).pop();
    setState(() {
      _passwordResetting = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color.fromARGB(255, 84, 92, 105),
        ),
        backgroundColor: Colors.white,
        title: const Text(
          'Forgot Password',
          style: TextStyle(
            color: Color.fromARGB(255, 84, 92, 105),
          ),
        ),
        leading: InkWell(
          onTap: () => widget.controller.switchMode(AuthMode.login),
          child: const BackButtonIcon(),
        ),
        elevation: 0.2,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
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
                TextForm(
                  controller: _emailController,
                  text: 'Email Address',
                  obscure: false,
                  inputType: TextInputType.emailAddress,
                  textInputType: TextInputType.emailAddress,
                  icon: Icons.email_outlined,
                ),
                const SizedBox(height: 10),
                ButtonGlobal(
                  onTap: !_passwordResetting ? _passwordReset : null,
                  label: 'Next',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
