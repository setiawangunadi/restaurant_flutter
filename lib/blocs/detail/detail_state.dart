part of 'detail_bloc.dart';

@immutable
abstract class DetailState {}

class DetailInitial extends DetailState {}

class OnLoadingDetail extends DetailState {}

class OnLoadingAddFavorite extends DetailState {}

class OnSuccessDetail extends DetailState {
  final DetailRestaurantResponseModel detailRestaurantResponseModel;

  OnSuccessDetail(this.detailRestaurantResponseModel);
}

class OnSuccessAddFavorite extends DetailState {
  final String? message;

  OnSuccessAddFavorite(this.message);
}

class OnSuccessDeleteFavorite extends DetailState {
  final String? message;

  OnSuccessDeleteFavorite(this.message);
}

class OnErrorDetail extends DetailState {
  final String? errorMessage;

  OnErrorDetail(this.errorMessage);
}
