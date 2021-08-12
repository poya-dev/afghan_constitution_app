import 'package:afghanistan_law_app/src/blocs/favorites/favorite_bloc.dart';
import 'package:afghanistan_law_app/src/blocs/favorites/favorite_event.dart';
import 'package:afghanistan_law_app/src/blocs/favorites/favorite_state.dart';
import 'package:afghanistan_law_app/src/data/repository.dart';
import 'package:afghanistan_law_app/src/preferences/language_preferences.dart';
import 'package:afghanistan_law_app/src/utils/language_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share_plus/share_plus.dart';

class Favorite extends StatefulWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  late Repository _repository;
  String? lang;
  @override
  void initState() {
    super.initState();
    _repository = Repository();
    _loadFavorites();
    lang = loadLang();
  }

  String loadLang() => LanguagePreferences.getLocale().toString();

  _loadFavorites() {
    context.read<FavoriteBloc>()..add(FetchFavoriteEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: (BuildContext context, FavoriteState state) {
          if (state.status == FavoriteStatus.initial) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if ((state.status == FavoriteStatus.success ||
                  state.status == FavoriteStatus.empty) &&
              state.favorites.length == 0) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(getTranslated(context, 'no_fovorite')),
                  SizedBox(
                    height: 8.0,
                  ),
                  Icon(
                    Icons.favorite_border_outlined,
                    color: Colors.red,
                    size: 33.0,
                  ),
                ],
              ),
            );
          }
          return ListView.separated(
            itemCount: state.favorites.length,
            separatorBuilder: (context, index) => SizedBox(height: 16.0),
            itemBuilder: (context, index) {
              final favorites = state.favorites;
              return Column(
                children: [
                  Card(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            title: Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: Text(
                                favorites[index].title,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            subtitle: Text(
                              favorites[index].content,
                              style: TextStyle(
                                wordSpacing: 1,
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.favorite,
                                color: Colors.red,
                              ),
                              onPressed: () => {
                                _repository.deleteFavorite(
                                  favorites[index].title,
                                  lang!,
                                ),
                                context.read<FavoriteBloc>()
                                  ..add(FetchFavoriteEvent())
                              },
                            ),
                            SizedBox(width: 18.0),
                            IconButton(
                              icon: Icon(Icons.copy_sharp),
                              onPressed: () {
                                Clipboard.setData(
                                  ClipboardData(
                                    text: favorites[index].content,
                                  ),
                                );
                                Fluttertoast.showToast(
                                  msg: getTranslated(
                                      context, 'add_to_clipboard'),
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  fontSize: 16.0,
                                );
                              },
                            ),
                            SizedBox(width: 18.0),
                            IconButton(
                              icon: Icon(Icons.share_sharp),
                              onPressed: () => Share.share(
                                favorites[index].content,
                                subject:
                                    'From: https://play.google.com/store/apps/details?id=<com.afghan_law_app.afghanistan_law_app>',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
