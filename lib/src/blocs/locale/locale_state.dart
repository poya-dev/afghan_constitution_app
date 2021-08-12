import 'package:afghanistan_law_app/src/ui/setting.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class LocaleState extends Equatable {
  final Locale locale;
  final Languages lang;
  LocaleState({required this.locale, required this.lang});
  @override
  List<Object?> get props => [locale, lang];
}
