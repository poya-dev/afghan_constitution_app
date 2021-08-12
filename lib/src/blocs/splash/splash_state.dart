import 'package:equatable/equatable.dart';

abstract class SplashScreenState extends Equatable {
  List<Object?> get props => [];
}

class SplashInitialState extends SplashScreenState {}

class SplashLoadingState extends SplashScreenState {}

class SplashLanguageSelectionState extends SplashScreenState {}

class SplashLoadedState extends SplashScreenState {}
