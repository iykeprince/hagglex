import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hagglex/config.dart';
import 'package:hagglex/gql_operations.dart';
import 'package:hagglex/view_models/app_data.model.dart';
import 'package:hagglex/widgets/custom_button.dart';
import 'package:hagglex/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  List<String> codes = ['+234', '+44', '+222', '+57'];

  final TextEditingController usernameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController phoneNumberController = TextEditingController();

  final TextEditingController referalController = TextEditingController();

  String _phoneCode = '+234';
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.kPrimaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 24),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
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
                ),
                SizedBox(height: 24),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Mutation(
                    options: MutationOptions(
                      document: gql(GqlOperation.REGISTER_QUERY),
                      onCompleted: (data) {
                        setState(() {
                          _loading = false;
                        });
                        print('Completed! Account registration called');
                        print(data);
                        if (data != null) {
                          String token = data['login']['token'];

                          //save the token to the provider
                          context.read<AppData>().setToken(token);

                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  'Account registration was successful!')));
                          Navigator.pushNamed(context, '/verify');
                        }
                      },
                      onError: (OperationException? e) {
                        setState(() {
                          _loading = false;
                        });
                        print('error: $e');
                        var errorMessage = e?.graphqlErrors[0].message;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('$errorMessage'),
                          ),
                        );
                      },
                    ),
                    builder: (runMutation, result) => Padding(
                      padding: EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Create a new account',
                            style: GoogleFonts.lato(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 34),
                          CustomTextField(
                            controller: emailController,
                            color: Colors.black,
                            hint: 'Email Address',
                          ),
                          SizedBox(height: 24),
                          CustomTextField(
                            controller: passwordController,
                            color: Colors.black,
                            hint: 'Password (Min 8 characters)',
                            isPassword: true,
                          ),
                          SizedBox(height: 24),
                          CustomTextField(
                            controller: usernameController,
                            color: Colors.black,
                            hint: 'Create a username',
                          ),
                          SizedBox(height: 24),
                          Row(
                            children: [
                              Container(
                                width: 70,
                                height: 40,
                                padding: EdgeInsets.symmetric(vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(2),
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.grey,
                                  ),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                      onChanged: (String? value) {
                                        setState(() {
                                          _phoneCode = value ?? '';
                                        });
                                      },
                                      value: _phoneCode,
                                      items: [
                                        for (String code in codes)
                                          DropdownMenuItem(
                                            value: code,
                                            child: Text(
                                              code,
                                              style: GoogleFonts.lato(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                      ]),
                                ),
                              ),
                              SizedBox(width: 6),
                              Expanded(
                                child: CustomTextField(
                                  controller: phoneNumberController,
                                  color: Colors.black,
                                  hint: 'Enter your phone number',
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          CustomTextField(
                            controller: referalController,
                            color: Colors.black,
                            hint: 'Referal code (Optional)',
                          ),
                          SizedBox(height: 16),
                          Text(
                              'By signing you agree to HaggleX terms and privacy policy'),
                          SizedBox(
                            height: 16,
                          ),
                          CustomButton(
                            title: _loading ? 'Please wait...' : 'SIGN UP',
                            color: CustomColor.kPrimaryColor,
                            textColor: Colors.white,
                            onPressed: () {
                              String username = usernameController.text;
                              String email = emailController.text;
                              String password = passwordController.text;
                              String phone =
                                  '$_phoneCode${phoneNumberController.text}';

                              //Grab the country value from the country screen via the provider
                              String country = context.read<AppData>().country;

                              String referalCode = referalController.text;

                              if (username.isEmpty)
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Username is required'),
                                  ),
                                );
                              else if (email.isEmpty)
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('email is required'),
                                  ),
                                );
                              else if (password.isEmpty)
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Password is required'),
                                  ),
                                );
                              else {
                                context.read<AppData>().setEmail(email);
                                setState(() {
                                  _loading = true;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content:
                                        Text('Everything is ready to submit'),
                                  ),
                                );
                                runMutation({
                                  "data": {
                                    "email": email,
                                    "username": username,
                                    "password": password,
                                    "phonenumber": phone,
                                    "country": "Nigeria",
                                    "currency": "NGN"
                                  }
                                });
                              }
                            },
                          )
                        ],
                      ),
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
