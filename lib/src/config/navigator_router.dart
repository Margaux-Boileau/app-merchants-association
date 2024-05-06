import 'package:app_merchants_association/src/model/forums.dart';
import 'package:app_merchants_association/src/ui/screens/post/comments.dart';
import 'package:app_merchants_association/src/ui/screens/post/create_post.dart';
import 'package:app_merchants_association/src/ui/screens/user/edit_shop.dart';
import 'package:app_merchants_association/src/ui/screens/user/user_manage.dart';
import 'package:flutter/material.dart';
import '../model/post.dart';
import '../ui/screens/auth/sign_in.dart';
import '../ui/screens/main_holder/home.dart';
import '../ui/screens/main_holder/main_holder.dart';
import '../ui/screens/main_holder/notices.dart';
import '../ui/screens/main_holder/notifications.dart';
import '../ui/screens/main_holder/profile.dart';
import '../ui/screens/post/post_detail.dart';
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
            List<dynamic> args = settings.arguments as List<dynamic>;
            // Pasar post seleccionado a la pantalla de detalle
            final Post argumentsPost = args[0] as Post;
            final Forums forum = args[1] as Forums;
            return PostDetail(post: argumentsPost, forum: forum);
          },
        );

      case NavigatorRoutes.comments:
        return MaterialPageRoute(
          builder: (context) {
            List<dynamic> args = settings.arguments as List<dynamic>;
            // Pasar post seleccionado a la pantalla de detalle
            final Post post = args[0] as Post;
            final Forums forum = args[1] as Forums;

            return CommentsScreen(post: post, forum: forum);
          },
        );

      /// Create Post
      case NavigatorRoutes.createPost:
        return MaterialPageRoute(
          builder: (context) {
            // Pasar forum por argumentos
            final Forums forum = settings.arguments as Forums;
            return CreatePost(forum: forum);
          },
        );

      case NavigatorRoutes.userManage:
        return MaterialPageRoute(
          builder: (context) {
            return const UserManage();
          },
        );

      case NavigatorRoutes.editShop:
        return MaterialPageRoute(
          builder: (context) {
            return const EditShop();
          },
        );
    }
  }
}
