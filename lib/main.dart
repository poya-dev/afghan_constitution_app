import 'package:afghanistan_law_app/src/app.dart';
import 'package:afghanistan_law_app/src/preferences/preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Preferences.init();
  runApp(App());
}
