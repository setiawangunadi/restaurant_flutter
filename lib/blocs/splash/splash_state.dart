part of 'splash_bloc.dart';

@immutable
abstract class SplashState {}

class SplashInitial extends SplashState {}

class OnLoadingSplash extends SplashState {}

class OnSuccessSplash extends SplashState {}

class OnErrorSplash extends SplashState {
  final String? errorMessage;

  OnErrorSplash(this.errorMessage);
}
