import 'package:afghanistan_law_app/src/models/item.dart';
import 'package:equatable/equatable.dart';

enum ItemStatus { initial, success, failure }

class ItemState extends Equatable {
  final ItemStatus? status;
  final List<Item>? items;

  ItemState({
    this.status = ItemStatus.initial,
    this.items = const <Item>[],
  });

  ItemState copyWith({ItemStatus? status, List<Item>? items}) {
    return ItemState(
      status: status ?? this.status,
      items: items ?? this.items,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, items: $items }''';
  }

  @override
  List<Object?> get props => [status, items];
}
