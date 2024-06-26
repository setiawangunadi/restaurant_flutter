import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:restaurant/config/exception/network.dart';
import 'package:restaurant/config/exception/session_expired.dart';
import 'package:restaurant/data/models/list_restaurant_response_model.dart';
import 'package:restaurant/data/models/search_restaurant_response_model.dart';
import 'package:restaurant/data/repositories/restaurant_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final RestaurantRepository _restaurantRepository = RestaurantRepository();

  HomeBloc() : super(HomeInitial()) {
    on<GetListRestaurant>(_getListRestaurant);
    on<DoSearchRestaurant>(_doSearchRestaurant);
  }

  Future<void> _getListRestaurant(
    GetListRestaurant event,
    Emitter<HomeState> emit,
  ) async {
    try {
      emit(OnLoadingHome());

      var response = await _restaurantRepository.doGetListRestaurant();

      if (response.statusCode == 200) {
        var listRestaurant =
            ListRestaurantResponseModel.fromJson(response.data);
        emit(OnSuccessHome(listRestaurant));
      }
    } on SessionExpired catch (e) {
      emit(OnErrorHome(e.message));
    } on Network catch (e) {
      emit(OnErrorHome(e.responseMessage));
    } catch (e) {
      emit(OnErrorHome(e.toString()));
    }
  }

  Future<void> _doSearchRestaurant(
    DoSearchRestaurant event,
    Emitter<HomeState> emit,
  ) async {
    try {
      emit(OnLoadingHome());

      var response =
          await _restaurantRepository.doSearchRestaurant(event.query);

      if (response.statusCode == 200) {
        var listRestaurant =
            SearchRestaurantResponseModel.fromJson(response.data);
        emit(OnSuccessSearch(listRestaurant));
      }
    } on SessionExpired catch (e) {
      emit(OnErrorHome(e.message));
    } on Network catch (e) {
      emit(OnErrorHome(e.responseMessage));
    } catch (e) {
      emit(OnErrorHome(e.toString()));
    }
  }
}
