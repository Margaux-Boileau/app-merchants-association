import 'package:app_merchants_association/src/app.dart';
import 'package:app_merchants_association/src/provider/navigator_provider.dart';
import 'package:app_merchants_association/src/provider/push_notification_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('====BACKGROUND HANDLER====');
  print(message);
  print('Title: ${message.notification?.title}');
  print('Body: ${message.notification?.body}');
  print('Payload: ${message.data}');
  print('Category: ${message.category}');
  print('Message Type: ${message.messageType}');
}
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  runApp(
    /// Providers
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => NavigationNotifier())],
      child: const AppComerciants()),
  );
}