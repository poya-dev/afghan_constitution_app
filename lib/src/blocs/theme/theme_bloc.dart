import 'package:afghanistan_law_app/src/blocs/theme/theme_event.dart';
import 'package:afghanistan_law_app/src/blocs/theme/theme_state.dart';
import 'package:afghanistan_law_app/src/config/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc()
      : super(ThemeState(
            themeData: AppThemes.appThemeData[AppTheme.ligthTheme]!));

  @override
  Stream<ThemeState> mapEventToState(ThemeEvent event) async* {
    if (event is ThemeEvent) {
      yield ThemeState(
        themeData: AppThemes.appThemeData[event.appTheme]!,
      );
    }
  }
}
