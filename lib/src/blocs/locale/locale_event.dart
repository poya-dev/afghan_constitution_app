import 'package:afghanistan_law_app/src/ui/setting.dart';
import 'package:equatable/equatable.dart';

class LocaleEvent extends Equatable {
  final Languages langCode;
  LocaleEvent({required this.langCode});

  @override
  List<Object?> get props => [langCode];
}
