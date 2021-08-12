import 'package:equatable/equatable.dart';

abstract class SplashScreenEvent extends Equatable {
  List<Object?> get props => [];
}

class NavigateToHomeScreenEvent extends SplashScreenEvent {}
