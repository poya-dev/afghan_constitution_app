import 'package:afghanistan_law_app/src/ui/setting.dart';
import 'package:equatable/equatable.dart';

abstract class ItemsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchItemsEvent extends ItemsEvent {
  final Languages lang;
  FetchItemsEvent({required this.lang});
}

class RefreshItemsEvent extends ItemsEvent {
  final Languages lang;
  RefreshItemsEvent({required this.lang});
}
