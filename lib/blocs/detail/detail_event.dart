part of 'detail_bloc.dart';

@immutable
abstract class DetailEvent {}

class GetDetailRestaurant extends DetailEvent {
  final String id;

  GetDetailRestaurant(this.id);
}

class DoAddFavorite extends DetailEvent {
  final FavoriteRestaurant favoriteRestaurant;
  final DetailRestaurantResponseModel detailRestaurantResponseModel;

  DoAddFavorite(this.favoriteRestaurant, this.detailRestaurantResponseModel);
}

class DoDeleteFavorite extends DetailEvent {
  final int index;

  DoDeleteFavorite(this.index);
}
