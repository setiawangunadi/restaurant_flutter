part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class OnLoadingHome extends HomeState {}

class OnSuccessHome extends HomeState {
  final ListRestaurantResponseModel listRestaurantResponseModel;

  OnSuccessHome(this.listRestaurantResponseModel);
}

class OnErrorHome extends HomeState {
  final String? errorMessage;

  OnErrorHome(this.errorMessage);
}
