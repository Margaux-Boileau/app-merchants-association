import 'package:app_merchants_association/src/ui/screens/create_post/create_post.dart';
import 'package:app_merchants_association/src/ui/screens/user/user_manage.dart';
import 'package:flutter/material.dart';
import '../model/post.dart';
import '../ui/screens/auth/sign_in.dart';
import '../ui/screens/main_holder/home.dart';
import '../ui/screens/main_holder/main_holder.dart';
import '../ui/screens/main_holder/notices.dart';
import '../ui/screens/main_holder/notifications.dart';
import '../ui/screens/main_holder/profile.dart';
import '../ui/screens/post_detail/post_detail.dart';
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

      /// Notices
      case NavigatorRoutes.notices:
        return MaterialPageRoute(
          builder: (context) {
            return const Notices();
          },
        );

      /// Notifications
      case NavigatorRoutes.notifications:
        return MaterialPageRoute(
          builder: (context) {
            return const Notifications();
          },
        );

      /// Profile
      case NavigatorRoutes.profile:
        return MaterialPageRoute(
          builder: (context) {
            return const Profile();
          },
        );

      /// Post Detail with args
      case NavigatorRoutes.postDetail:
        return MaterialPageRoute(
          builder: (context) {
            // Pasar post seleccionado a la pantalla de detalle
            final Post args = settings.arguments as Post;
            return PostDetail(post: args);
          },
        );

      /// Create Post
      case NavigatorRoutes.createPost:
        return MaterialPageRoute(
          builder: (context) {
            return const CreatePost();
          },
        );

      case NavigatorRoutes.userManage:
        return MaterialPageRoute(
          builder: (context) {
            return const UserManage();
          },
        );
    }
  }
}
