import 'package:afghanistan_law_app/src/blocs/locale/locale_bloc.dart';
import 'package:afghanistan_law_app/src/blocs/locale/locale_event.dart';
import 'package:afghanistan_law_app/src/blocs/locale/locale_state.dart';
import 'package:afghanistan_law_app/src/blocs/splash/splash_bloc.dart';
import 'package:afghanistan_law_app/src/blocs/splash/splash_event.dart';
import 'package:afghanistan_law_app/src/preferences/language_preferences.dart';
import 'package:afghanistan_law_app/src/ui/setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';

class LanguageSelection extends StatefulWidget {
  const LanguageSelection({Key? key}) : super(key: key);

  @override
  _LanguageSelectionState createState() => _LanguageSelectionState();
}

class _LanguageSelectionState extends State<LanguageSelection> {
  List<String> langs = ["English", "دری", "پښتو"];
  int? _selectedIndex = 1;

  Widget _buildChips() {
    List<Widget> chips = [];

    for (int i = 0; i < langs.length; i++) {
      ChoiceChip choiceChip = ChoiceChip(
        selected: _selectedIndex == i,
        label: Text(langs[i], style: TextStyle(color: Colors.white)),
        elevation: 3,
        selectedShadowColor: Colors.red,
        padding: EdgeInsets.all(3.0),
        pressElevation: 5,
        backgroundColor: Colors.grey[400],
        avatar: Icon(
          _selectedIndex == i ? LineIcons.checkCircle : LineIcons.timesCircle,
          color: _selectedIndex == i ? Colors.green : Colors.white,
        ),
        tooltip: langs[i],
        selectedColor: Colors.red,
        onSelected: (bool selected) {
          setState(() {
            if (selected) {
              _selectedIndex = i;
            }
          });
        },
      );
      chips.add(choiceChip);
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: chips,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LocaleBloc, LocaleState>(
        builder: (context, state) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildChips(),
                SizedBox(
                  height: 42.0,
                ),
                GestureDetector(
                  onTap: () {
                    if (_selectedIndex == 0) {
                      context.read<LocaleBloc>()
                        ..add(
                          LocaleEvent(langCode: Languages.english),
                        );
                      LanguagePreferences.setLocale(Languages.english);
                      context.read<SplashBloc>()
                        ..add(NavigateToHomeScreenEvent());
                    } else if (_selectedIndex == 1) {
                      context.read<LocaleBloc>()
                        ..add(
                          LocaleEvent(langCode: Languages.persian),
                        );
                      LanguagePreferences.setLocale(Languages.persian);
                      context.read<SplashBloc>()
                        ..add(NavigateToHomeScreenEvent());
                    } else if (_selectedIndex == 2) {
                      context.read<LocaleBloc>()
                        ..add(
                          LocaleEvent(langCode: Languages.pashto),
                        );
                      LanguagePreferences.setLocale(Languages.pashto);
                      context.read<SplashBloc>()
                        ..add(NavigateToHomeScreenEvent());
                    }
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width - 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.lightBlue,
                    ),
                    height: 46.0,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                        child: Text(
                          _selectedIndex == 0
                              ? 'Continue'
                              : _selectedIndex == 1
                                  ? 'ادامه'
                                  : 'دوام',
                          style: TextStyle(color: Colors.white, fontSize: 18.0),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
