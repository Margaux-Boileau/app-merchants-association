import 'dart:convert';
import 'package:app_merchants_association/src/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/navigator_routes.dart';
import '../model/PushNotificaton.dart';
import '../utils/helpers/notification_manager.dart';

class PushNotificationProvider {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  ///GESTION DE ALMACENAR NOTIFICACIONES
  getPshNotifications() async {
    List<PushNotification> notificationsList = [];

    final prefs = await SharedPreferences.getInstance();
    var prefsNotifications = await prefs.getString("push_notifications");

    if (prefsNotifications != null) {
      notificationsList = jsonDecode(prefsNotifications).map((i) =>
          PushNotification.fromJson(i)).toList();
    }

    return notificationsList;
  }

  ///CONFIGURACION DE LAS NOTIFICACIONES
  initNotifications() {
    _firebaseMessaging.requestPermission();
    _firebaseMessaging.getToken().then((token) =>
    {
      print('=====TOKEN====='),
      print(token)
    });
    initPushNotifications();
  }

  Future initPushNotifications() async {

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        NotificationManager.savePushNotification(message.notification?.title, message.notification?.body);
      }
    });

    FirebaseMessaging.instance.getInitialMessage().then(handleInitialMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  }

  void handleMessage(RemoteMessage? message) {
    print('=====ON OPEN HANDLER=====');
    if (message == null) return;
    print('Title: ${message.notification?.title}');
    navigatorKey.currentState?.pushNamed(
        NavigatorRoutes.mainHolder, arguments: message);
  }



  void handleInitialMessage(RemoteMessage? message) {
    print("LLega notificacion----");
  }

  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();
  }

}

