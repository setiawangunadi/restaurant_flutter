import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:restaurant/config/exception/network.dart';
import 'package:restaurant/config/exception/session_expired.dart';

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
    try {
      emit(OnLoadingSplash());
      emit(OnSuccessSplash());
      // await SharedPrefsStorage.setTimeAlarm(
      //     timeAlarm: Handler().formatDate(now).toString());
      // await SharedPrefsStorage.setStatusAlarm(statusAlarm: true);
      // await SharedPrefsStorage.setStatusMens(statusMens: true);
      // await SharedPrefsStorage.setTotalAlarm(totalAlarm: 0);
    } on SessionExpired catch (e) {
      emit(OnErrorSplash(e.message));
    } on Network catch (e) {
      emit(OnErrorSplash(e.responseMessage));
    } catch (e) {
      emit(OnErrorSplash(e.toString()));
    }
  }
}
