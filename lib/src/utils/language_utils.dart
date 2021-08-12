import 'package:afghanistan_law_app/src/localization/app_localizations.dart';
import 'package:flutter/material.dart';

String getTranslated(BuildContext context, String key) {
  return AppLocalizations.of(context)!.translate(key);
}
