import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences preference;
  static Future<void> initPreferences() async {
    preference = await SharedPreferences.getInstance();
  }

  static String get token => preference.getString('_token') ?? '';
  static set token(String newToken) => preference.setString('_token', newToken);

  static bool get displayedSplash => preference.getBool('_displayedSplash') ?? false;
  static set displayedSplash(bool newValue) => preference.setBool('_displayedSplash', newValue);
}