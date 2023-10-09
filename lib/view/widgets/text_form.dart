import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TextForm extends StatelessWidget {
  const TextForm({
    Key? key,
    required this.controller,
    required this.text,
    required this.inputType,
    required this.obscure,
    required textInputType,
    this.icon = FontAwesomeIcons.lock,
  }) : super(key: key);
  final IconData? icon;
  final TextEditingController controller;
  final String text;
  final TextInputType inputType;
  final bool obscure;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      padding: const EdgeInsets.only(top: 3, left: 15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 7,
            ),
          ]),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.text,
        obscureText: obscure,
        decoration: InputDecoration(
          hintText: text,
          border: InputBorder.none,
          prefixIcon: icon != null
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Icon(
                    icon,
                    size: 20,
                  ),
                )
              : null,
          contentPadding: const EdgeInsets.all(12),
          hintStyle: const TextStyle(
            height: 1,
          ),
        ),
      ),
    );
  }
}

class UserTextForm extends StatelessWidget {
  const UserTextForm({
    Key? key,
    required this.controller,
    required this.text,
    required this.inputType,
    required this.obscure,
    required textInputType,
    this.icon = FontAwesomeIcons.user,
  }) : super(key: key);
  final TextEditingController controller;
  final String text;
  final TextInputType inputType;
  final bool obscure;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      padding: const EdgeInsets.only(top: 3, left: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 7,
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.text,
        obscureText: obscure,
        decoration: InputDecoration(
          hintText: text,
          border: InputBorder.none,
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Icon(
              icon,
              size: 20,
            ),
          ),
          contentPadding: const EdgeInsets.all(12),
          hintStyle: const TextStyle(
            height: 1,
          ),
        ),
      ),
    );
  }
}
