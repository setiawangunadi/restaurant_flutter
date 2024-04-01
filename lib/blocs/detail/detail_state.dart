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

class OnSuccessAddFavorite extends DetailState {}

class OnErrorDetail extends DetailState {
  final String? errorMessage;

  OnErrorDetail(this.errorMessage);
}
