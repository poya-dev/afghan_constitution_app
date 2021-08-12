import 'package:afghanistan_law_app/src/blocs/splash/splash_event.dart';
import 'package:afghanistan_law_app/src/blocs/splash/splash_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashBloc extends Bloc<SplashScreenEvent, SplashScreenState> {
  SplashBloc() : super(SplashInitialState());

  @override
  Stream<SplashScreenState> mapEventToState(SplashScreenEvent event) async* {
    yield SplashLoadingState();
    await Future.delayed(Duration(seconds: 1));
    yield SplashLanguageSelectionState();
    //
  }
}
