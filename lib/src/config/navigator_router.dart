import 'package:app_merchants_association/src/ui/screens/main_holder/main_holder.dart';
import 'package:flutter/material.dart';
import '../ui/screens/auth/sign_in.dart';
import '../ui/screens/main_holder/home.dart';
import '../ui/screens/main_holder/profile.dart';
import 'navigator_routes.dart';

class AppRouter {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {

      /// SignIn
      case NavigatorRoutes.signIn:
        return MaterialPageRoute(
          builder: (context) {
            return SignIn();
          },
        );

        /// Home
      case NavigatorRoutes.home:
        return MaterialPageRoute(
          builder: (context) {
            return const Home();
          },
        );

        /// Main Holder
      case NavigatorRoutes.mainHolder:
        return MaterialPageRoute(
          builder: (context) {
            return const MainHolder();
          },
        );

        /// Profile
      case NavigatorRoutes.profile:
        return MaterialPageRoute(
          builder: (context) {
            return const Profile();
          },
        );
    }
  }
}
