import 'package:afghanistan_law_app/src/blocs/items/items_bloc.dart';
import 'package:afghanistan_law_app/src/blocs/items/items_event.dart';
import 'package:afghanistan_law_app/src/blocs/locale/locale_bloc.dart';
import 'package:afghanistan_law_app/src/blocs/locale/locale_event.dart';
import 'package:afghanistan_law_app/src/blocs/theme/theme_bloc.dart';
import 'package:afghanistan_law_app/src/blocs/theme/theme_event.dart';
import 'package:afghanistan_law_app/src/preferences/language_preferences.dart';
import 'package:afghanistan_law_app/src/preferences/theme_preferences.dart';
import 'package:afghanistan_law_app/src/ui/favorite.dart';
import 'package:afghanistan_law_app/src/ui/setting.dart';
import 'package:afghanistan_law_app/src/utils/language_utils.dart';
import 'package:afghanistan_law_app/src/widgets/itme_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    super.initState();
    _loadTheme();
    _loadItems(_loadLang());
  }

  _loadTheme() {
    context.read<ThemeBloc>()
      ..add(ThemeEvent(appTheme: ThemePrefrences.getTheme()));
  }

  _loadItems(Languages lang) {
    context.read<ItemsBloc>()..add(FetchItemsEvent(lang: lang));
  }

  _loadLang() {
    final lang = LanguagePreferences.getLocale();
    context.read<LocaleBloc>()..add(LocaleEvent(langCode: lang!));
    return lang;
  }

  int _selectedIndex = 0;

  List<Widget> _pages = <Widget>[
    ItemList(),
    Favorite(),
    Setting(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getTranslated(context, 'app_bar')),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: BottomAppBar(
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTaped,
          selectedIconTheme: IconThemeData(
            size: 26.0,
          ),
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(LineIcons.home),
              label: getTranslated(context, 'bottom_home_menu'),
            ),
            BottomNavigationBarItem(
              icon: Icon(LineIcons.heart),
              label: getTranslated(context, 'bottom_favorite_menu'),
            ),
            BottomNavigationBarItem(
              icon: Icon(LineIcons.cog),
              label: getTranslated(context, 'bottom_setting_menu'),
            ),
          ],
        ),
      ),
    );
  }

  void _onItemTaped(int value) {
    setState(() {
      _selectedIndex = value;
    });
  }
}
