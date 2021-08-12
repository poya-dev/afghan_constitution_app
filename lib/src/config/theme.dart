import 'package:flutter/material.dart';

enum AppTheme { ligthTheme, darkTheme }

class AppThemes {
  static final appThemeData = {
    AppTheme.ligthTheme: ThemeData(
      appBarTheme: AppBarTheme(
        color: Colors.red[300],
        elevation: 3.0,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        elevation: 2.0,
        selectedItemColor: Colors.red,
      ),
      primarySwatch: Colors.red,
      primaryColor: Colors.white,
      backgroundColor: Color(0xffF1F5FB),
      indicatorColor: Color(0xffCBDCF8),
      buttonColor: Color(0xffF1F5FB),
      hintColor: Color(0xffEECED3),
      highlightColor: Color(0xffFCE192),
      hoverColor: Color(0xff4285F4),
      focusColor: Color(0xffA8DAB5),
      disabledColor: Colors.grey,
      cardColor: Colors.white,
      canvasColor: Colors.grey[50],
      brightness: Brightness.light,
    ),
    AppTheme.darkTheme: ThemeData(
      primarySwatch: Colors.red,
      primaryColor: Colors.black,
      backgroundColor: Colors.black,
      accentColor: Colors.blue,
      indicatorColor: Color(0xff0E1D36),
      buttonColor: Color(0xff3B3B3B),
      hintColor: Color(0xff280C0B),
      highlightColor: Color(0xff372901),
      hoverColor: Color(0xff3A3A3B),
      focusColor: Color(0xff0B2512),
      disabledColor: Colors.grey,
      cardColor: Color(0xFF151515),
      canvasColor: Colors.black,
      brightness: Brightness.dark,
    ),
  };
}
