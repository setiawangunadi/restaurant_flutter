import 'package:dio/dio.dart';
import 'package:restaurant/config/cannonical_path.dart';
import 'package:restaurant/config/service_network.dart';

class RestaurantRepository{

  Future<Response> doGetListRestaurant() async {
    final response = ServiceNetwork().get(
      path: CanonicalPath.getListRestaurant,
    );
    return response;
  }

  Future<Response> doGetDetailRestaurant(String id) async {
    final response = ServiceNetwork().get(
      path: CanonicalPath.getDetailRestaurant + id,
    );
    return response;
  }
}