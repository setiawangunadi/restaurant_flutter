part of 'detail_bloc.dart';

@immutable
abstract class DetailEvent {}

class GetDetailRestaurant extends DetailEvent {
  final String id;

  GetDetailRestaurant(this.id);
}
