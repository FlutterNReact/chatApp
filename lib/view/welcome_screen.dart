import 'package:chatapp/providers/providers.dart';
import 'package:chatapp/view/auth_view.dart';
import 'package:chatapp/view/chat_screens/chat_room.dart';
import 'package:chatapp/view/chat_screens/chat_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: auth,
      builder: (context, value, child) {
        if (auth.isLogin == false) {
          return AuthView();
        }
        return const ChatRooms();
      },
    );
  }
}
