import 'package:afghanistan_law_app/src/localization/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class AppLocalizationSetup {
  static const Iterable<Locale> supportedLocale = [
    Locale('en'),
    Locale('fa'),
    Locale('ps'),
  ];

  static const Iterable<LocalizationsDelegate<dynamic>> localizationsDelegate =
      [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate
  ];
}
