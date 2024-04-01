import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class FavoriteRestaurant {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final String pictureId;

  @HiveField(4)
  final String city;

  @HiveField(4)
  final double rating;

  FavoriteRestaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });
}
