import 'dart:convert';

import 'package:afghanistan_law_app/src/preferences/preferences.dart';
import 'package:afghanistan_law_app/src/ui/setting.dart';

class LanguagePreferences extends Preferences {
  static void setLocale(Languages? language) {
    if (language == null) {
      language = Languages.persian;
    }
    String lang = jsonEncode(language.toString());
    Preferences.preferences!.setString(
      Preferences.LAGUAGE_CODE,
      lang,
    );
  }

  static Languages? getLocale() {
    String? language =
        Preferences.preferences!.getString(Preferences.LAGUAGE_CODE);
    if (language == null) {
      return null;
    }
    return getLangFromString(jsonDecode(language));
  }

  static Languages? getLangFromString(String lang) {
    for (Languages language in Languages.values) {
      if (language.toString() == lang) {
        return language;
      }
    }
    return null;
  }

  // static Locale _locale(String languageCode) {
  //   switch (languageCode) {
  //     case Preferences.ENGLISH:
  //       return Locale(Preferences.ENGLISH, 'US');
  //     case Preferences.FARSI:
  //       return Locale(Preferences.FARSI, "IR");
  //     case Preferences.PASHTO:
  //       return Locale(Preferences.PASHTO, "PT");
  //     default:
  //       return Locale(Preferences.ENGLISH, 'US');
  //   }
  // }
}
