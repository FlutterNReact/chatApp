import 'package:chatapp/controllers/auth_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/utils/global_colors.dart';
import 'package:chatapp/view/widgets/signup_button.dart';
import 'package:chatapp/view/widgets/social_login.dart';
import 'package:chatapp/view/widgets/text_form.dart';
import 'package:chatapp/view/widgets/text_form_global.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key, required this.controller}) : super(key: key);
  final AuthController controller;
  @override
  State createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _registering = false;
  _register() async {
    if (_registering) return;
    FocusScope.of(context).unfocus();
    setState(() {
      _registering = true;
    });
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
    UserCredential? credential;
    String? message;
    String messageLabel = "Alert";
    try {
      credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      await FirebaseChatCore.instance.createUserInFirestore(
        types.User(
          firstName: firstNameController.text.trim(),
          id: credential.user!.uid,
          imageUrl:
              'https://i.pravatar.cc/300?u=${emailController.text.trim()}',
          lastName: lastNameController.text.trim(),
        ),
      );
      message =
          "Your account have been created successfully, Login with your new credentials";
      messageLabel = 'Congratulation';
      emailController.clear();
      passwordController.clear();
      firstNameController.clear();
      lastNameController.clear();
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
      _registering = false;
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
                      'Welcome to chatapp 👋',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        'Hello, I guess you are new around here. You can '
                        'start using the application after sign up.',
                        style: TextStyle(
                          color: Colors.grey[850],
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ////email input++
                    ///
                    ///
                    ///
                    Row(
                      children: [
                        Expanded(
                          child: UserTextForm(
                            controller: firstNameController,
                            text: 'First Name',
                            obscure: false,
                            textInputType: TextInputType.name,
                            inputType: TextInputType.text,
                          ),
                        ),
                        Expanded(
                          child: TextForm(
                            controller: lastNameController,
                            text: 'Last Name',
                            obscure: false,
                            textInputType: TextInputType.emailAddress,
                            inputType: TextInputType.text,
                            icon: null,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),
                    TextFormGlobal(
                      controller: emailController,
                      text: 'Email Address',
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

                    SignUpButton(onTap: !_registering ? _register : null),
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
              'Already have an account?',
            ),
            InkWell(
              child: GestureDetector(
                onTap: () {
                  widget.controller.switchMode(AuthMode.login);
                },
                child: Text(
                  ' Sign In',
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
