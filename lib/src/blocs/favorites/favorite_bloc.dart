import 'package:afghanistan_law_app/src/blocs/favorites/favorite_event.dart';
import 'package:afghanistan_law_app/src/blocs/favorites/favorite_state.dart';
import 'package:afghanistan_law_app/src/data/repository.dart';
import 'package:afghanistan_law_app/src/models/favorite.dart';
import 'package:afghanistan_law_app/src/preferences/language_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  Repository _repository;
  FavoriteBloc(this._repository)
      : super(FavoriteState(status: FavoriteStatus.initial));

  @override
  Stream<FavoriteState> mapEventToState(FavoriteEvent event) async* {
    if (event is FetchFavoriteEvent) {
      yield await _mapFetchFavoriteEventToState(state);
    }
  }

  Future<FavoriteState> _mapFetchFavoriteEventToState(
      FavoriteState state) async {
    try {
      final res = await _repository
          .retrieveFavorite(LanguagePreferences.getLocale().toString());
      final favorites = res
          .map(
            (e) => FavoriteModel.fromMap(e),
          )
          .toList();
      if (res.isNotEmpty)
        return FavoriteState(
            favorites: favorites, status: FavoriteStatus.success);
      else
        return FavoriteState(status: FavoriteStatus.empty);
    } on Exception {
      return FavoriteState(status: FavoriteStatus.failure);
    }
  }
}
