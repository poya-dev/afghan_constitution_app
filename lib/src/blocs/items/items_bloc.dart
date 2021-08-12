import 'package:afghanistan_law_app/src/blocs/items/items_event.dart';
import 'package:afghanistan_law_app/src/blocs/items/items_state.dart';
import 'package:afghanistan_law_app/src/data/repository.dart';
import 'package:afghanistan_law_app/src/models/item.dart';
import 'package:afghanistan_law_app/src/ui/setting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemsBloc extends Bloc<ItemsEvent, ItemState> {
  Repository _repository;

  ItemsBloc(this._repository) : super(ItemState());

  @override
  Stream<ItemState> mapEventToState(ItemsEvent event) async* {
    if (event is FetchItemsEvent) {
      final lang = event.lang == Languages.english
          ? 'en'
          : event.lang == Languages.persian
              ? 'fa'
              : 'ps';
      yield* _mapFetchItemsEventToState(state, lang);
    }
    if (event is RefreshItemsEvent) {
      final lang = event.lang == Languages.english
          ? 'en'
          : event.lang == Languages.persian
              ? 'fa'
              : 'ps';
      yield* _mapRefreshItemsEventToState(state, lang);
    }
  }

  Stream<ItemState> _mapFetchItemsEventToState(
      ItemState state, String lang) async* {
    yield state.copyWith(status: ItemStatus.initial);
    try {
      final querySnapshot = await _repository.readItems(lang);
      final items = querySnapshot!.docs
          .map(
            (e) => Item(
              id: e.id,
              chapter: e.get('f_name'),
              chapterName: e.get('name'),
              section: e.get('sections'),
            ),
          )
          .toList();
      if (items.isEmpty) {
        yield state.copyWith(status: ItemStatus.success);
      }
      yield ItemState(items: items, status: ItemStatus.success);
    } on Exception {
      yield state.copyWith(status: ItemStatus.failure);
    }
  }

  Stream<ItemState> _mapRefreshItemsEventToState(
      ItemState state, String lang) async* {
    yield state.copyWith(status: ItemStatus.initial);
    try {
      final querySnapshot = await _repository.readItems(lang);
      final items = querySnapshot!.docs
          .map(
            (e) => Item(
              id: e.id,
              chapter: e.get('f_name'),
              chapterName: e.get('name'),
              section: e.get('sections'),
            ),
          )
          .toList();
      if (items.isEmpty) {
        yield state.copyWith(status: ItemStatus.success);
      }
      yield ItemState(items: items, status: ItemStatus.success);
    } on Exception {
      yield state.copyWith(status: ItemStatus.failure);
    }
  }
}
