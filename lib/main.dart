import 'dart:io';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hagglex/config.dart';
import 'package:hagglex/pages/country.screen.dart';
import 'package:hagglex/pages/dashboard.screen.dart';
import 'package:hagglex/pages/launcher.screen.dart';
import 'package:hagglex/pages/setup.screen.dart';
import 'package:hagglex/pages/signin.screen.dart';
import 'package:hagglex/pages/signup.screen.dart';
import 'package:hagglex/pages/verify.screen.dart';
import 'package:provider/provider.dart';

import 'view_models/app_data.model.dart';

void main() async {
  await initHiveForFlutter();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppData(),
      child: GraphQLProvider(
        client: Config.initailizeClient(''),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'HaggleX',
          theme: ThemeData(
            primaryColor: Color(0xFF271160),
          ),
          initialRoute: '/',
          routes: {
            '/': (_) => Launcher(),
            '/login': (_) => Signin(),
            '/register': (_) => SignUp(),
            '/country': (_) => CountryScreen(),
            '/verify': (_) => Verify(),
            '/setup': (_) => Setup(),
            '/dashboard': (_) => Dashboard()
          },
        ),
      ),
    );
  }
}
