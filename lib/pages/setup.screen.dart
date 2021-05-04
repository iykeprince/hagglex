import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hagglex/config.dart';
import 'package:hagglex/widgets/custom_button.dart';

class Setup extends StatelessWidget {
  const Setup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.kPrimaryColor,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                SizedBox(height: 50),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: CustomColor.kGoldColor,
                  ),
                  child: Icon(
                    Icons.check,
                    size: 36,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Setup Complete',
                  style: GoogleFonts.lato(
                    color: Colors.white,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Thank you for setting up your HaggleX account',
                  style: GoogleFonts.lato(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 300),
            CustomButton(
              title: 'START EXPLORING',
              color: CustomColor.kGoldColor,
              textColor: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
