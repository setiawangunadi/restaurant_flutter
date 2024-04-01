part of 'list_favorite_bloc.dart';

@immutable
abstract class ListFavoriteState {}

class ListFavoriteInitial extends ListFavoriteState {}

class OnLoadingListFavorite extends ListFavoriteState {}

class OnSuccessListFavorite extends ListFavoriteState {
  final dynamic dataBox;

  OnSuccessListFavorite(this.dataBox);
}

class OnErrorListFavorite extends ListFavoriteState {
  final String? errorMessage;

  OnErrorListFavorite(this.errorMessage);
}
