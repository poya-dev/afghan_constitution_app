import 'package:afghanistan_law_app/src/blocs/favorites/favorite_bloc.dart';
import 'package:afghanistan_law_app/src/blocs/items/items_bloc.dart';
import 'package:afghanistan_law_app/src/blocs/locale/locale_bloc.dart';
import 'package:afghanistan_law_app/src/blocs/locale/locale_state.dart';
import 'package:afghanistan_law_app/src/blocs/splash/splash_bloc.dart';
import 'package:afghanistan_law_app/src/blocs/theme/theme_bloc.dart';
import 'package:afghanistan_law_app/src/blocs/theme/theme_state.dart';
import 'package:afghanistan_law_app/src/data/repository.dart';
import 'package:afghanistan_law_app/src/localization/app_localizations_setup.dart';
import 'package:afghanistan_law_app/src/preferences/language_preferences.dart';
import 'package:afghanistan_law_app/src/ui/splash.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => SplashBloc(),
        ),
        BlocProvider(
          create: (BuildContext context) => ItemsBloc(Repository()),
        ),
        BlocProvider(
          create: (BuildContext context) => ThemeBloc(),
        ),
        BlocProvider(
          create: (BuildContext context) => FavoriteBloc(Repository()),
        ),
        BlocProvider(
          create: (BuildContext context) => LocaleBloc(),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (BuildContext context, ThemeState themeState) {
          return BlocBuilder<LocaleBloc, LocaleState>(
            builder: (BuildContext context, LocaleState localeState) {
              return MaterialApp(
                locale: localeState.locale,
                supportedLocales: [
                  Locale("en", "US"),
                  Locale("fa", "IR"),
                  Locale("ps", "PT"),
                ],
                localizationsDelegates:
                    AppLocalizationSetup.localizationsDelegate,
                localeResolutionCallback: (locale, supportedLocales) {
                  for (var supportedLocale in supportedLocales) {
                    if (supportedLocale.languageCode == locale!.languageCode &&
                        supportedLocale.countryCode == locale.countryCode) {
                      return supportedLocale;
                    }
                  }
                },
                debugShowCheckedModeBanner: false,
                theme: themeState.themeData,
                home: SplashScreen(),
              );
            },
          );
        },
      ),
    );
  }
}
