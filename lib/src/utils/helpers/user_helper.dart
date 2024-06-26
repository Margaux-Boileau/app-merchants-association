import 'package:shared_preferences/shared_preferences.dart';
import '../../model/shop.dart';
import '../../model/user.dart';

class UserHelper {

  /// Dades de l'usuari que ha iniciat sessió si es person.
  static User? _user;

  static Shop? _shop;

  /// Access token de l'usuari que ha iniciat la sessió.
  static String? _accessToken;

  /// Retorna dades de l'usuari que ha iniciat sessió.
  static User? get user => _user;
  static Shop? get shop => _shop;

  /// Retorna l'access token de l'usuari que ha iniciat la sessió.
  static String? get accessToken => _accessToken;

  static setUser(Map<String, dynamic> json) async{
    try {
      if(json["user"]!=null){
        print("User JSON -> $json");
        _user = User.fromJson(json["user"]);

        print("User -> ${_user!.name}");
      }if(json["shop"]!=null){
        _shop = Shop.fromJson(json["shop"]);
      }
    }catch(e){
     print(".:USER HELPER ERROR AT SET USER $e");
    }
  }

  static setShop(Map<String, dynamic>? json){
    try {
      if(json != null){
        _shop = Shop.fromJson(json);
      }
    }catch(e){
      print(".:USER HELPER ERROR AT SET SHOP $e");
    }
  }

  static setAccessToken(String token) {
    _accessToken = token;
  }

  static deleteAllFromShared() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("access_token");
    await prefs.remove("username");
  }

  static saveTokenOnSharedPreferences(String accesToken, String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("access_token", accesToken);
    await prefs.setString("username", username);
    _accessToken = accessToken;
  }

  static getUsernameFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    var username = prefs.getString("username");
    print("Username: $username");
    return username;
  }

  static getTokenFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("access_token");
    _accessToken = token;
  }

  static Future deleteTokenFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("access_token");
    _accessToken = null;
  }
}