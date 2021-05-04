import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hagglex/config.dart';
import 'package:hagglex/gql_operations.dart';
import 'package:hagglex/widgets/custom_button.dart';
import 'package:hagglex/widgets/custom_textfield.dart';

class Signin extends StatefulWidget {
  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final TextEditingController inputController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF271160),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: GraphQLConsumer(
            builder: (client) => Mutation(
              options: MutationOptions(
                document: gql(GqlOperation.LOGIN_GQL_QUERY),
                onCompleted: (data) {
                  print('Completed! Login doc called');
                  print(data);
                  if (data != null) {
                    String token = data['login']['token'];

                    //adding the bearer token as part of the header for graphql
                    AuthLink authLink =
                        AuthLink(getToken: () => 'Bearer $token');
                    client.link.concat(authLink);

                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Account registration was successful!')));
                    Navigator.pushNamed(context, '/dashboard');
                  }
                },
                onError: (OperationException? e) {
                  print('ERROR: $e');
                  var errorMessage = e?.graphqlErrors[0].message;
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('$errorMessage')));
                },
              ),
              builder: (runMutation, result) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 120),
                  Text(
                    'Welcome!',
                    style: GoogleFonts.lato(
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 24),
                  CustomTextField(
                    hint: 'Email address',
                    color: Colors.white,
                    controller: inputController,
                  ),
                  SizedBox(height: 16),
                  CustomTextField(
                      hint: 'Password',
                      color: Colors.white,
                      controller: passwordController), //password field
                  SizedBox(height: 10),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Forgot Password?',
                      style: GoogleFonts.lato(
                        fontSize: 14.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  CustomButton(
                    title: _loading ? 'Authenticating...' : 'LOG IN',
                    textColor: Colors.black,
                    color: CustomColor.kGoldColor,
                    onPressed: () {
                      String emailInput = inputController.text.trim();
                      String passwordInput = passwordController.text.trim();

                      if (emailInput.isEmpty)
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Email input is required'),
                          ),
                        );
                      else if (passwordInput.isEmpty)
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('password cannot be empty'),
                          ),
                        );
                      else {
                        setState(() {
                          _loading = true;
                        });
                        runMutation({
                          "data": {
                            "input": emailInput,
                            "password": passwordInput
                          }
                        });
                        setState(() {
                          _loading = false;
                        });
                      }
                    },
                  ),
                  SizedBox(height: 24),
                  InkWell(
                    onTap: () => Navigator.pushNamed(context, '/register'),
                    child: Center(
                      child: Text(
                        'New User?Create a new account',
                        style: GoogleFonts.lato(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
