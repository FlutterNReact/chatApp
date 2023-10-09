import 'package:chatapp/controllers/auth_controller.dart';
import 'package:chatapp/providers/providers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/utils/global_colors.dart';
import 'package:chatapp/view/widgets/button_global.dart';
import 'package:chatapp/view/widgets/social_login.dart';
import 'package:chatapp/view/widgets/text_form.dart';
import 'package:chatapp/view/widgets/text_form_global.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key, required this.controller}) : super(key: key);
  final AuthController controller;

  @override
  State<LoginView> createState() {
    return _LoginViewState();
  }
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _loginIn = false;
  _login() async {
    if (_loginIn) return;
    _loginIn = true;
    FocusScope.of(context).unfocus();
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
      await auth.logIn(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } catch (e) {
      if (kDebugMode) print(e);
      if (mounted) {
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            actions: [
              TextButton(
                onPressed: () {
                  widget.controller.switchMode(AuthMode.login);
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
            content: Text(
              e.toString(),
            ),
            title: const Text('Error'),
          ),
        );
      }
    }
    if (!mounted) return;
    Navigator.of(context).pop();
    setState(() {
      _loginIn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Text(
                  'ChatApp',
                  style: TextStyle(
                    color: GlobalColors.mainColor,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      'Welcome Back 👋',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        'I am happy to see you again. You can'
                        ' continue where you left off by logging in',
                        style: TextStyle(
                          color: Colors.grey[850],
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ////email input++
                    TextFormGlobal(
                      controller: emailController,
                      text: 'Email',
                      obscure: false,
                      textInputType: TextInputType.emailAddress,
                      inputType: TextInputType.text,
                    ),

                    const SizedBox(height: 10),

                    ////password input
                    TextForm(
                      controller: passwordController,
                      text: 'Password',
                      textInputType: TextInputType.text,
                      obscure: true,
                      inputType: TextInputType.text,
                    ),

                    const SizedBox(height: 10),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              widget.controller
                                  .switchMode(AuthMode.forgotPassword);
                            },
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    ButtonGlobal(
                      onTap: !_loginIn ? _login : null,
                    ),
                    const SizedBox(height: 15),
                    const SocialLogin(),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 50,
        color: Colors.white,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Don\'t have an account?',
            ),
            InkWell(
              child: GestureDetector(
                onTap: () {
                  widget.controller.switchMode(AuthMode.signUp);
                },
                child: Text(
                  ' Sign Up',
                  style: TextStyle(
                    color: GlobalColors.mainColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
