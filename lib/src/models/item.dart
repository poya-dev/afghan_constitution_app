import 'package:equatable/equatable.dart';

class Item extends Equatable {
  final String id;
  final String chapter;
  final String chapterName;
  final List<dynamic> section;

  Item(
      {required this.id,
      required this.chapter,
      required this.chapterName,
      required this.section});

  Item copyWith(
      {String? id,
      String? chapter,
      String? chapterName,
      List<dynamic>? section}) {
    return Item(
        id: id ?? this.id,
        chapter: chapter ?? this.chapter,
        chapterName: chapterName ?? this.chapterName,
        section: section ?? this.section);
  }

  @override
  List<Object?> get props => [id, chapter, chapterName, section];
}
