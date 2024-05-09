import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../model/PushNotificaton.dart';

class NotificationManager{

  static List<Map<String, dynamic>> pushNotificationListToJson(List<PushNotification> notifications) {
    List<Map<String, dynamic>> jsonList = [];
    for (var notification in notifications) {
      jsonList.add(notification.toJson());
    }
    return jsonList;
  }

  static savePushNotification(String? title, String? content) async {

    List<PushNotification> notificationsList = [];

    final prefs = await SharedPreferences.getInstance();
    var prefsNotifications =  await prefs.getString("push_notifications");

    if(prefsNotifications != null){
      var decodedList = jsonDecode(prefsNotifications) as List<dynamic>;
      notificationsList = decodedList.map((json) => PushNotification.fromJson(json)).toList();
    }

    notificationsList.insert(0, PushNotification(title, content));

    try{
      List<Map<String, dynamic>> jsonList = pushNotificationListToJson(notificationsList);
      String jsonString = jsonEncode(jsonList);

      await prefs.remove("push_notifications");
      print("JSON QUE SE GUARDA ${jsonString}");
      await prefs.setString("push_notifications", jsonString);
    }
    catch(e){
      print("Error al guardar las nuevas notificaciones");
    }

  }

  ///TODO obtener las notificaciones y retornarlas como lista
  static getNotifications(){

  }

  static deleteNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("push_notifications");
  }

}