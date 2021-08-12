import 'package:afghanistan_law_app/src/blocs/items/items_bloc.dart';
import 'package:afghanistan_law_app/src/blocs/items/items_event.dart';
import 'package:afghanistan_law_app/src/blocs/items/items_state.dart';
import 'package:afghanistan_law_app/src/blocs/locale/locale_bloc.dart';
import 'package:afghanistan_law_app/src/blocs/locale/locale_event.dart';
import 'package:afghanistan_law_app/src/models/item.dart';
import 'package:afghanistan_law_app/src/preferences/language_preferences.dart';
import 'package:afghanistan_law_app/src/ui/setting.dart';
import 'package:afghanistan_law_app/src/utils/language_utils.dart';
import 'package:afghanistan_law_app/src/widgets/item_desc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';

class ItemList extends StatefulWidget {
  const ItemList({Key? key}) : super(key: key);

  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  late Languages lang;
  @override
  void initState() {
    super.initState();
    lang = _loadLang();
  }

  _loadLang() {
    final lang = LanguagePreferences.getLocale();
    context.read<LocaleBloc>()..add(LocaleEvent(langCode: lang!));
    return lang;
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<ItemsBloc>()
          ..add(RefreshItemsEvent(lang: LanguagePreferences.getLocale()!));
      },
      child: BlocBuilder<ItemsBloc, ItemState>(
        builder: (BuildContext context, ItemState state) {
          switch (state.status) {
            case ItemStatus.failure:
              return Center(
                child: Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.hardEdge,
                  children: <Widget>[
                    ListView(),
                    Center(
                      child: Text(
                        getTranslated(context, 'search_failed'),
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Positioned(
                      top: 20.0,
                      child: ElevatedButton(
                        child: Text(getTranslated(context, 'try_again')),
                        onPressed: () async {
                          context.read<ItemsBloc>()
                            ..add(
                              RefreshItemsEvent(
                                lang: LanguagePreferences.getLocale()!,
                              ),
                            );
                        },
                      ),
                    )
                  ],
                ),
              );
            case ItemStatus.success:
              if (state.items!.isEmpty) {
                return Center(
                  child: Stack(
                    alignment: Alignment.center,
                    clipBehavior: Clip.hardEdge,
                    children: <Widget>[
                      ListView(),
                      Center(
                        child: Text(
                          getTranslated(context, 'search_failed'),
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Positioned(
                        top: (MediaQuery.of(context).size.height / 2),
                        child: ElevatedButton(
                          child: Text(getTranslated(context, 'try_again')),
                          onPressed: () async {
                            context.read<ItemsBloc>()
                              ..add(
                                RefreshItemsEvent(
                                  lang: LanguagePreferences.getLocale()!,
                                ),
                              );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }
              return ListView.builder(
                itemCount: state.items!.length,
                itemBuilder: (BuildContext context, int index) {
                  final items = state.items;
                  return listItems(items: items, index: index, lang: lang);
                },
              );
            default:
              return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class listItems extends StatelessWidget {
  const listItems({
    Key? key,
    required this.items,
    required this.index,
    required this.lang,
  }) : super(key: key);

  final List<Item>? items;
  final int index;
  final lang;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        trailing: Icon(
          lang == Languages.english
              ? LineIcons.angleRight
              : LineIcons.angleLeft,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        title: Container(
          width: MediaQuery.of(context).size.width,
          child: Text(
            '( ${items![index].chapter} ) ${items![index].chapterName}',
          ),
        ),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ItemDescription(
              appBarTitle: items![index].chapter,
              sections: items![index].section,
            ),
          ),
        ),
      ),
    );
  }
}
