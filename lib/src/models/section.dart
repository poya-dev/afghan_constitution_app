import 'package:equatable/equatable.dart';

class Section extends Equatable {
  final String article;
  final String body;

  Section({required this.article, required this.body});

  @override
  List<Object?> get props => [article, body];
}
