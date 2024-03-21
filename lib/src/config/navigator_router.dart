import 'package:flutter/material.dart';
import '../ui/screens/auth/sign_in.dart';
import '../ui/screens/main_holder/home.dart';
import 'navigator_routes.dart';

class AppRouter {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case NavigatorRoutes.signIn:
        return MaterialPageRoute(
          builder: (context) {
            return SignIn();
          },
        );
      case NavigatorRoutes.home:
        return MaterialPageRoute(
          builder: (context) {
            return const Home();
          },
        );
    }
  }
}
