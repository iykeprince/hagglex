import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hagglex/config.dart';

class CustomButton extends StatelessWidget {
  final String? title;
  final Color? color;
  final Color? textColor;
  final VoidCallback? onPressed;

  const CustomButton({
    Key? key,
    @required this.title,
    this.color,
    this.textColor,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: color,
        primary: color,
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '$title',
            style: GoogleFonts.lato(
              fontSize: 14,
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
