import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<DoSplash>(_doSplash);
  }

  Future<void> _doSplash(
      DoSplash event,
      Emitter<SplashState> emit,
      ) async {
    emit(OnLoadingSplash());
    emit(OnSuccessSplash());
    // try {
    //
    // } on SessionExpired catch (e) {
    //   emit(OnErrorSplash(e.message));
    // } on Network catch (e) {
    //   emit(OnErrorSplash(e.responseMessage));
    // } catch (e) {
    //   emit(OnErrorSplash(e.toString()));
    // }
  }
}
