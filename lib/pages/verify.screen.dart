import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hagglex/config.dart';
import 'package:hagglex/gql_operations.dart';
import 'package:hagglex/view_models/app_data.model.dart';
import 'package:hagglex/widgets/custom_button.dart';
import 'package:hagglex/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

class Verify extends StatefulWidget {
  @override
  _VerifyState createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  TextEditingController _codeController = TextEditingController();
  bool _loading = false;

  sendVerificationCode(GraphQLClient client, String email) {
    client.query(QueryOptions(
      document: gql(GqlOperation.SEND_VERIFICATION_CODE),
      variables: {
        "data": {"email": email}
      },
      pollInterval: Duration(seconds: 10),
    ));
  }

  @override
  Widget build(BuildContext context) {
    AppData appData = Provider.of<AppData>(context);
    return GraphQLProvider(
      client: Config.initailizeClient(appData.token),
      child: Scaffold(
        backgroundColor: Color(0xFF271160),
        body: SafeArea(
          child: SingleChildScrollView(
            child: GraphQLConsumer(builder: (client) {
              sendVerificationCode(client, appData.email);

              return Mutation(
                options: MutationOptions(
                  document: gql(GqlOperation.VERIFY_CODE),
                  update: (cache, result) {
                    print('Query result: ${result?.data}');
                    print('Resutl: $result');
                  },
                  onCompleted: (data) {
                    if (data != null) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text('Veified')));
                      Navigator.pushNamed(context, '/dashboard');
                      // } else {
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //       SnackBar(content: Text('INvalid CODE')));
                      // }
                    }
                  },
                  onError: (error) {
                    var errorMessage = error?.graphqlErrors[0].message;
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('$errorMessage')));
                  },
                ),
                builder: (runMutation, result) => Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 34),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.indigo.shade300,
                            borderRadius: BorderRadius.circular(16)),
                        child: InkWell(
                          onTap: () => Navigator.pop(context),
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
                                title: _loading
                                    ? 'Verifying code...'
                                    : 'VERIFY ME',
                                color: CustomColor.kPrimaryColor,
                                textColor: Colors.white,
                                onPressed: _loading
                                    ? null
                                    : () {
                                        setState(() {
                                          _loading = true;
                                        });
                                        int codeText =
                                            int.parse(_codeController.text);

                                        runMutation({
                                          "data": {
                                            "code": codeText,
                                          }
                                        });
                                        setState(() {
                                          _loading = false;
                                        });
                                      },
                              ),
                              SizedBox(height: 8),
                              Center(
                                child: _loading
                                    ? CircularProgressIndicator()
                                    : Container(),
                              ),
                              SizedBox(height: 16),
                              Text('This code will expire in 10 minutes'),
                              SizedBox(height: 24),
                              InkWell(
                                onTap: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text('Code requested!')));
                                  sendVerificationCode(client, appData.email);
                                },
                                child: Text(
                                  'Resend Code',
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
