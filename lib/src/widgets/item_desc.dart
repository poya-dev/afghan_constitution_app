import 'dart:ui';
import 'package:afghanistan_law_app/src/data/repository.dart';
import 'package:afghanistan_law_app/src/models/favorite.dart';
import 'package:afghanistan_law_app/src/preferences/language_preferences.dart';
import 'package:afghanistan_law_app/src/utils/language_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

class ItemDescription extends StatefulWidget {
  final sections;
  final appBarTitle;
  ItemDescription({
    Key? key,
    this.appBarTitle,
    this.sections,
  }) : super(key: key);

  @override
  _ItemDescriptionState createState() => _ItemDescriptionState();
}

class _ItemDescriptionState extends State<ItemDescription> {
  final Repository _repository = Repository();
  String? lang;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    lang = loadLang();
    checkFavorite();
  }

  String loadLang() => LanguagePreferences.getLocale().toString();

  void checkFavorite() async {
    for (int i = 0; i < widget.sections.length; i++) {
      final res =
          await _repository.isFavorite(widget.sections[i]['m_name'], lang!);
      if (res) {
        widget.sections[i]['favorite'] = true;
      } else {
        widget.sections[i]['favorite'] = false;
      }
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.appBarTitle.toString(),
            style: TextStyle(letterSpacing: 5)),
        centerTitle: true,
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.separated(
              itemCount: widget.sections.length,
              separatorBuilder: (context, index) => SizedBox(height: 16.0),
              itemBuilder: (context, index) {
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
                                  widget.sections[index]['m_name'],
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              subtitle: Text(
                                widget.sections[index]['text'].toString(),
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
                                  widget.sections[index]['favorite']
                                      ? Icons.favorite
                                      : Icons.favorite_outline_sharp,
                                  color: widget.sections[index]!['favorite']
                                      ? Colors.red
                                      : Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .color,
                                ),
                                onPressed: () {
                                  final result = _repository.insertFavorite(
                                    FavoriteModel(
                                        id: null,
                                        title: widget.sections[index]['m_name'],
                                        content: widget.sections[index]['text'],
                                        lang: lang!),
                                  );
                                  result.then((value) {
                                    if (value == 0) {
                                      _repository.deleteFavorite(
                                          widget.sections[index]['m_name'],
                                          lang!);
                                      Fluttertoast.showToast(
                                          msg: getTranslated(
                                              context, 'removed_from_favorite'),
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          fontSize: 16.0);
                                      checkFavorite();
                                    } else {
                                      Fluttertoast.showToast(
                                        msg: getTranslated(
                                            context, 'added_to_favorite'),
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        fontSize: 16.0,
                                      );
                                      checkFavorite();
                                    }
                                  });
                                },
                              ),
                              SizedBox(width: 18.0),
                              IconButton(
                                icon: Icon(Icons.copy_sharp),
                                onPressed: () {
                                  Clipboard.setData(
                                    ClipboardData(
                                      text: widget.sections[index]['text'],
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
                                  widget.sections[index]['text'],
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
            ),
    );
  }
}
