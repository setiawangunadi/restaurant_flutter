part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class OnLoadingHome extends HomeState {}

class OnSuccessHome extends HomeState {
  final ListRestaurantResponseModel listRestaurantResponseModel;

  OnSuccessHome(this.listRestaurantResponseModel);
}

class OnSuccessSearch extends HomeState {
  final SearchRestaurantResponseModel searchRestaurantResponseModel;

  OnSuccessSearch(this.searchRestaurantResponseModel);
}

class OnSuccessSetNotification extends HomeState {
  final String? id;

  OnSuccessSetNotification(this.id);
}

class OnErrorHome extends HomeState {
  final String? errorMessage;

  OnErrorHome(this.errorMessage);
}
