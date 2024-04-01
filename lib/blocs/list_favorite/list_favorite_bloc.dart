import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:restaurant/config/exception/network.dart';
import 'package:restaurant/config/exception/session_expired.dart';
import 'package:restaurant/data/models/restaurant_favorite_model.dart';

part 'list_favorite_event.dart';
part 'list_favorite_state.dart';

class ListFavoriteBloc extends Bloc<ListFavoriteEvent, ListFavoriteState> {
  ListFavoriteBloc() : super(ListFavoriteInitial()) {
    on<GetListRestaurant>(_getListRestaurant);
  }

  Future<void> _getListRestaurant(
      GetListRestaurant event,
      Emitter<ListFavoriteState> emit,
      ) async {
    try {
      emit(OnLoadingListFavorite());

      var result = await Hive.openBox<FavoriteRestaurant>('favorite');
      debugPrint("THIS RESULT  $result");
      emit(OnSuccessListFavorite(result.values.toList()));

    } on SessionExpired catch (e) {
      emit(OnErrorListFavorite(e.message));
    } on Network catch (e) {
      emit(OnErrorListFavorite(e.responseMessage));
    } catch (e) {
      emit(OnErrorListFavorite(e.toString()));
    }
  }
}
