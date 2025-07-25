import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences preference;
  static Future<void> initPreferences() async {
    preference = await SharedPreferences.getInstance();
  }
}