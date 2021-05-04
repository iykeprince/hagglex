import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class CustomColor {
  static final Color kGoldColor = Color(0xFFFFC175);
  static final Color kPrimaryColor = Color(0xFF271160);
}

class Config {
  static final HttpLink httpLink = HttpLink(
    'https://hagglex-backend-staging.herokuapp.com/graphql',
  );

  static ValueNotifier<GraphQLClient> initailizeClient(String token) {
    AuthLink authLink = AuthLink(getToken: () => "Bearer $token");
    Link link = authLink.concat(httpLink);

    ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        cache: GraphQLCache(
          store: HiveStore(),
        ),
        link: link,
      ),
    );
    return client;
  }
}
