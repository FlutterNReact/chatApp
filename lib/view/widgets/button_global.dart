import 'package:flutter/material.dart';
import 'package:chatapp/utils/global_colors.dart';

class ButtonGlobal extends StatelessWidget {
  const ButtonGlobal({Key? key, this.onTap, this.label = 'Sign In'})
      : super(key: key);
  final void Function()? onTap;
  final String label;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: 55,
        decoration: BoxDecoration(
            color: GlobalColors.mainColor,
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
              )
            ]),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
