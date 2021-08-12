import 'package:afghanistan_law_app/src/models/favorite.dart';
import 'package:equatable/equatable.dart';

enum FavoriteStatus { initial, success, empty, failure }

class FavoriteState extends Equatable {
  final FavoriteStatus status;
  final List<FavoriteModel> favorites;

  FavoriteState({
    this.status = FavoriteStatus.initial,
    this.favorites = const <FavoriteModel>[],
  });

  FavoriteState copyWith(
      {FavoriteStatus? status, List<FavoriteModel>? favorites}) {
    return FavoriteState(
      status: status ?? this.status,
      favorites: favorites ?? this.favorites,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, items: $favorites }''';
  }

  @override
  List<Object?> get props => [status, favorites];
}
