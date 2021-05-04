import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? hint;
  final Color color;
  final bool isPassword;
  final TextEditingController? controller;

  CustomTextField({
    Key? key,
    this.hint,
    this.color = Colors.white24,
    this.isPassword = false,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: TextStyle(
        color: color,
      ),
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          fontSize: 12,
          color: color,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: color,
            style: BorderStyle.solid,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: color,
            style: BorderStyle.solid,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        labelStyle: TextStyle(
          color: Colors.white,
        ),
        helperStyle: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
