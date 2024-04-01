import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:restaurant/config/exception/network.dart';
import 'package:restaurant/config/exception/session_expired.dart';
import 'package:restaurant/data/models/detail_restaurant_response_model.dart';
import 'package:restaurant/data/repositories/restaurant_repository.dart';

part 'detail_event.dart';

part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final RestaurantRepository _restaurantRepository = RestaurantRepository();

  DetailBloc() : super(DetailInitial()) {
    on<GetDetailRestaurant>(_getDetailRestaurant);
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
}
