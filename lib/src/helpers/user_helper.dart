import 'package:shared_preferences/shared_preferences.dart';
import '../model/user.dart';

class UserHelper {

  /// Dades de l'usuari que ha iniciat sessió si es person.
  static User? _user;

  /// Access token de l'usuari que ha iniciat la sessió.
  static String? _accessToken;


  /// Retorna dades de l'usuari que ha iniciat sessió.
  static User? get user => _user;

  /// Retorna l'access token de l'usuari que ha iniciat la sessió.
  static String? get accessToken => _accessToken;

  static setUser(Map<String, dynamic> json) async{
    ///En caso de que haya cambios dede la BBDD de un usuario que puedan romperlo, finaliza la sesión
    try {
      _user = User.fromJson(json);
    }catch(e){
     print(".:USER HELPER ERROR AT SET USER $e");
    }
  }

  static setAccessToken(String token) {
    _accessToken = token;
  }

  static void saveTokenOnSharedPreferences(String accesToken) async {
    print("TOCKEN GUARDADO");
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("access_token", accesToken);
    _accessToken = accessToken;
  }

  static getTokenFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("access_token");
    print("TOCKEN IN SHARED $token");
    _accessToken = token;
  }

  static Future deleteTokenFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("access_token");
    _accessToken = null;
  }
}