import 'package:afghanistan_law_app/src/blocs/locale/locale_event.dart';
import 'package:afghanistan_law_app/src/blocs/locale/locale_state.dart';
import 'package:afghanistan_law_app/src/ui/setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocaleBloc extends Bloc<LocaleEvent, LocaleState> {
  LocaleBloc()
      : super(LocaleState(locale: Locale('en'), lang: Languages.english));

  @override
  Stream<LocaleState> mapEventToState(LocaleEvent event) async* {
    if (event.langCode == Languages.english) {
      yield LocaleState(locale: Locale('en'), lang: Languages.english);
    }
    if (event.langCode == Languages.persian) {
      yield LocaleState(locale: Locale('fa'), lang: Languages.persian);
    }
    if (event.langCode == Languages.pashto) {
      yield LocaleState(locale: Locale('ps'), lang: Languages.pashto);
    }
  }
}
