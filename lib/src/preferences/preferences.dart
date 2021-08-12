import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static SharedPreferences? preferences;
  static const SELECTED_THEME_KEY = 'selected_theme_key';

  static const String LAGUAGE_CODE = 'languageCode';

  static const String ENGLISH = 'en';
  static const String FARSI = 'fa';
  static const String PASHTO = 'ps';

  static init() async {
    Preferences.preferences = await SharedPreferences.getInstance();
  }
}
