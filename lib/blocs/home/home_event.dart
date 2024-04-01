part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class GetListRestaurant extends HomeEvent {}

class DoSearchRestaurant extends HomeEvent {
  final String query;

  DoSearchRestaurant(this.query);
}
