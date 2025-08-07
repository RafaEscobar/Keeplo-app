import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences preference;
  static Future<void> initPreferences() async {
    preference = await SharedPreferences.getInstance();
  }

  static String get token => preference.getString('_token') ?? 'token';
  static set token(String newToken) => preference.setString('_token', newToken);
}