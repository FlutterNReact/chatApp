import 'package:chatapp/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/utils/global_colors.dart';
import 'package:chatapp/view/widgets/text_form.dart';
import 'forgot_password_button.dart';

class NewPassword extends StatelessWidget {
  NewPassword({Key? key, required this.controller}) : super(key: key);
  final AuthController controller;
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repeatPasswordController =
      TextEditingController();

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
                      'Create New Password 🔒',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        'You can create a new password, please '
                        'don\t forget it too.',
                        style: TextStyle(
                          color: Colors.grey[850],
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ////password input
                    TextForm(
                      controller: passwordController,
                      text: 'New Password',
                      textInputType: TextInputType.text,
                      obscure: true,
                      inputType: TextInputType.text,
                    ),

                    const SizedBox(height: 10),

                    ////repeat password input
                    TextForm(
                      controller: repeatPasswordController,
                      text: 'Repeat New Password',
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
                              controller.switchMode(AuthMode.newPassword);
                            },
                            child: const Text(
                              'Password Hint?',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    const ForgotPasswordButton(),
                    const SizedBox(height: 15),
                    ////const SocialLogin(),
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
              'Didn’t receive an email?',
            ),
            InkWell(
              child: GestureDetector(
                onTap: () {
                  controller.switchMode(AuthMode.otp);
                },
                child: Text(
                  ' Send again',
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
