import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:restaurant/config/exception/network.dart';
import 'package:restaurant/config/exception/session_expired.dart';
import 'package:restaurant/data/models/detail_restaurant_response_model.dart';
import 'package:restaurant/data/models/restaurant_favorite_model.dart';
import 'package:restaurant/data/repositories/restaurant_repository.dart';

part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final RestaurantRepository _restaurantRepository = RestaurantRepository();

  DetailBloc() : super(DetailInitial()) {
    on<GetDetailRestaurant>(_getDetailRestaurant);
    on<DoAddFavorite>(_doAddFavorite);
    on<DoDeleteFavorite>(_doDeleteFavorite);
  }

  Future<void> _getDetailRestaurant(
    GetDetailRestaurant event,
    Emitter<DetailState> emit,
  ) async {
    try {
      emit(OnLoadingDetail());

      var response =
          await _restaurantRepository.doGetDetailRestaurant(event.id);

      if (response.statusCode == 200) {
        var detailRestaurant =
            DetailRestaurantResponseModel.fromJson(response.data);
        emit(OnSuccessDetail(detailRestaurant));
      }
    } on SessionExpired catch (e) {
      emit(OnErrorDetail(e.message));
    } on Network catch (e) {
      emit(OnErrorDetail(e.responseMessage));
    } catch (e) {
      emit(OnErrorDetail(e.toString()));
    }
  }

  Future<void> _doAddFavorite(
    DoAddFavorite event,
    Emitter<DetailState> emit,
  ) async {
    try {
      emit(OnLoadingAddFavorite());
      final Box<FavoriteRestaurant> box =
          Hive.box<FavoriteRestaurant>('favorite');

      debugPrint("THIS BOX :$box");

      final restaurant = FavoriteRestaurant(
        id: event.favoriteRestaurant.id,
        rating: event.favoriteRestaurant.rating,
        name: event.favoriteRestaurant.name,
        city: event.favoriteRestaurant.city,
        description: event.favoriteRestaurant.description,
        pictureId: event.favoriteRestaurant.pictureId,
      );
      final existingItem =
          box.values.firstWhereOrNull((item) => item.id == restaurant.id);
      if (existingItem == null) {
        box.add(restaurant);
        emit(OnSuccessAddFavorite("Successfully added to favorites"));
      } else {
        emit(OnErrorDetail("Restaurant Has Been On Your List Favorite"));
        emit(OnSuccessDetail(event.detailRestaurantResponseModel));
      }
    } on SessionExpired catch (e) {
      emit(OnErrorDetail(e.message));
    } on Network catch (e) {
      emit(OnErrorDetail(e.responseMessage));
    } catch (e) {
      emit(OnErrorDetail(e.toString()));
    }
  }

  Future<void> _doDeleteFavorite(
    DoDeleteFavorite event,
    Emitter<DetailState> emit,
  ) async {
    try {
      emit(OnLoadingAddFavorite());

      final Box<FavoriteRestaurant> box =
          Hive.box<FavoriteRestaurant>('favorite');
      if (event.index < box.length) {
        var key = box.keyAt(event.index);
        await box.delete(key);
        emit(OnSuccessDeleteFavorite("Successfully deleted"));
      } else {
        emit(OnErrorDetail("Invalid Index"));
      }
    } on SessionExpired catch (e) {
      emit(OnErrorDetail(e.message));
    } on Network catch (e) {
      emit(OnErrorDetail(e.responseMessage));
    } catch (e) {
      emit(OnErrorDetail(e.toString()));
    }
  }
}
