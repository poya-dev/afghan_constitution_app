import 'dart:convert';

import 'package:afghanistan_law_app/src/config/theme.dart';
import 'package:afghanistan_law_app/src/preferences/preferences.dart';

class ThemePrefrences extends Preferences {
  static void saveTheme(AppTheme? appTheme) async {
    if (appTheme == null) {
      appTheme = AppTheme.ligthTheme;
    }
    String theme = jsonEncode(appTheme.toString());
    Preferences.preferences!.setString(Preferences.SELECTED_THEME_KEY, theme);
  }

  static AppTheme? getTheme() {
    String? theme =
        Preferences.preferences!.getString(Preferences.SELECTED_THEME_KEY);
    if (theme == null) {
      return AppTheme.ligthTheme;
    }
    return getThemeFromString(json.decode(theme));
  }

  static AppTheme? getThemeFromString(String themeString) {
    for (AppTheme theme in AppTheme.values) {
      if (theme.toString() == themeString) {
        return theme;
      }
    }
    return null;
  }
}
