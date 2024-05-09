import 'package:app_merchants_association/src/app.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/navigator_routes.dart';



class PushNotificationProvider {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  initNotifications() {
    _firebaseMessaging.requestPermission();
    _firebaseMessaging.getToken().then((token) => {
      print('=====TOKEN====='),
      print(token)
      //dweL9LynSGC8xEcUsh97_H:APA91bFjFCnDFYOHBaIQFZ3xI1Cr5zg8A-cX3lQs6P1vLG7-rHyJo6o5AZvvfybtjynUixXoKYuD8hK8sc-EzrkQWWOzIMygzitd5VBrZI6Xn57dsyE2eBMVo1RSXSTH0gp7Zue17PMS
    });
    initPushNotifications();
  }

  void handleMessage(RemoteMessage? message) {
    print('=====ON OPEN HANDLER=====');
    if (message == null) return;
    print('Title: ${message.notification?.title}');
    navigatorKey.currentState?.pushNamed(NavigatorRoutes.notifications, arguments: message);
  }

  Future initPushNotifications() async {
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }

}

