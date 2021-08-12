import 'package:equatable/equatable.dart';

abstract class FavoriteEvent extends Equatable {
  @override
  List<Object?> get props => [];

  get status => null;
}

class FetchFavoriteEvent extends FavoriteEvent {}
