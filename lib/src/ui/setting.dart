import 'package:afghanistan_law_app/src/blocs/items/items_bloc.dart';
import 'package:afghanistan_law_app/src/blocs/items/items_event.dart';
import 'package:afghanistan_law_app/src/blocs/locale/locale_bloc.dart';
import 'package:afghanistan_law_app/src/blocs/locale/locale_event.dart';
import 'package:afghanistan_law_app/src/blocs/locale/locale_state.dart';
import 'package:afghanistan_law_app/src/blocs/theme/theme_bloc.dart';
import 'package:afghanistan_law_app/src/blocs/theme/theme_event.dart';
import 'package:afghanistan_law_app/src/blocs/theme/theme_state.dart';
import 'package:afghanistan_law_app/src/config/theme.dart';
import 'package:afghanistan_law_app/src/preferences/language_preferences.dart';
import 'package:afghanistan_law_app/src/preferences/theme_preferences.dart';
import 'package:afghanistan_law_app/src/ui/about_us.dart';
import 'package:afghanistan_law_app/src/utils/language_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:launch_review/launch_review.dart';
import 'package:line_icons/line_icons.dart';

enum Languages { english, persian, pashto }

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  Languages _languages = LanguagePreferences.getLocale() ?? Languages.english;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return BlocBuilder<LocaleBloc, LocaleState>(
          builder: (context, state) {
            return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ListTile(
                      leading: Icon(LineIcons.language),
                      title: Text(getTranslated(context, 'lang_menu')),
                      subtitle: state.lang == Languages.english
                          ? Text('Enghish')
                          : state.lang == Languages.persian
                              ? Text('دری')
                              : Text('پشتو'),
                      onTap: () {
                        _showDialog(context);
                      }),
                  Divider(),
                  ListTile(
                    leading: Icon(LineIcons.adjust),
                    title: Text(getTranslated(context, 'appearance')),
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return BlocBuilder<ThemeBloc, ThemeState>(builder:
                                (BuildContext context, ThemeState themeState) {
                              return Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ListTile(
                                      trailing: ThemePrefrences.getTheme() ==
                                              AppTheme.ligthTheme
                                          ? Icon(Icons.check)
                                          : Text(''),
                                      title: Text(
                                        getTranslated(context, 'light'),
                                      ),
                                      onTap: () {
                                        AppTheme theme = AppTheme.ligthTheme;
                                        context.read<ThemeBloc>()
                                          ..add(ThemeEvent(appTheme: theme));
                                        ThemePrefrences.saveTheme(theme);
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    ListTile(
                                      trailing: ThemePrefrences.getTheme() ==
                                              AppTheme.darkTheme
                                          ? Icon(Icons.check)
                                          : Text(''),
                                      title: Text(
                                        getTranslated(context, 'dark'),
                                      ),
                                      onTap: () {
                                        AppTheme theme = AppTheme.darkTheme;
                                        context.read<ThemeBloc>()
                                          ..add(ThemeEvent(appTheme: theme));
                                        ThemePrefrences.saveTheme(theme);
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                ),
                              );
                            });
                          });
                    },
                  ),
                  ListTile(
                    leading: Icon(LineIcons.star),
                    title: Text(getTranslated(context, 'rate_my_app')),
                    onTap: () => LaunchReview.launch(
                        androidAppId: 'com.afghan_law_app.afghanistan_law_app'),
                  ),
                  ListTile(
                    leading: Icon(LineIcons.info),
                    title: Text(getTranslated(context, 'about_menu')),
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AboutUs(),
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(LineIcons.infoCircle),
                    title: Text(getTranslated(context, 'version_name')),
                    onTap: () {
                      _showAboutDialog(context);
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<dynamic> _showAboutDialog(BuildContext context) {
    return showDialog(
      context: context,
      useSafeArea: true,
      builder: (_) => AlertDialog(
        content: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                getTranslated(context, 'app_bar'),
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12.0),
              Container(
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  image: DecorationImage(
                    image: ExactAssetImage(
                      'assets/img/afghanistan_flag.jpg',
                    ),
                  ),
                ),
              ),
              SizedBox(height: 6.0),
              Text('${getTranslated(context, "version_name")} ' +
                  '${getTranslated(context, "version_id")}')
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> _showDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: new Text(getTranslated(context, 'select_lang')),
        content: StatefulBuilder(
          builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RadioListTile<Languages?>(
                  value: Languages.english,
                  groupValue: _languages,
                  onChanged: (Languages? lang) {
                    state(() {
                      _languages = lang!;
                    });
                  },
                  title: Text(getTranslated(context, 'english')),
                ),
                RadioListTile<Languages?>(
                  value: Languages.persian,
                  groupValue: _languages,
                  onChanged: (Languages? lang) {
                    state(() {
                      _languages = lang!;
                    });
                  },
                  title: Text(getTranslated(context, 'persian')),
                ),
                RadioListTile<Languages?>(
                  value: Languages.pashto,
                  groupValue: _languages,
                  onChanged: (Languages? lang) {
                    state(() {
                      _languages = lang!;
                    });
                  },
                  title: Text(getTranslated(context, 'pashto')),
                ),
              ],
            );
          },
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: TextButton(
              child: Text(
                getTranslated(context, 'confirm_lang'),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              onPressed: () {
                context.read<LocaleBloc>()
                  ..add(LocaleEvent(langCode: _languages));
                context.read<ItemsBloc>()
                  ..add(FetchItemsEvent(lang: _languages));
                LanguagePreferences.setLocale(_languages);
                Navigator.of(context).pop();
              },
            ),
          )
        ],
      ),
    );
  }
}
