import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hagglex/config.dart';
import 'package:hagglex/widgets/custom_button.dart';
import 'package:hagglex/widgets/custom_textfield.dart';

class Verify extends StatefulWidget {
  @override
  _VerifyState createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  TextEditingController _codeController = TextEditingController();
  int code = 1999;
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF271160),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 34),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.indigo.shade300,
                      borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4.0,
                      horizontal: 8.0,
                    ),
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 24),
                Text(
                  'Verify your account',
                  style: GoogleFonts.lato(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 24),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFF271160).withOpacity(.3),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.check,
                                size: 36,
                                color: Color(0xFF271160),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'We just sent a verification code to your email, please enter the code',
                            style: GoogleFonts.lato(),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 8),
                        CustomTextField(
                          controller: _codeController,
                          color: Colors.black,
                          hint: 'Verification code',
                        ), //Verification code
                        SizedBox(height: 10),

                        CustomButton(
                          title: 'VERIFY ME',
                          color: CustomColor.kPrimaryColor,
                          textColor: Colors.white,
                          onPressed: () {
                            setState(() {
                              _loading = true;
                            });
                            int codeText = int.parse(_codeController.text);
                            Future.delayed(Duration(seconds: 5000), () {
                              setState(() {
                                _loading = false;
                              });
                              if (codeText == code) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Veified')));
                                Navigator.pushNamed(context, '/dashboard');
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('INvalid CODE')));
                              }
                            });
                          },
                        ),
                        SizedBox(height: 16),
                        Text('This code will expire in 10 minutes'),
                        SizedBox(height: 24),
                        Text(
                          'Resend Code',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
