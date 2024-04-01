
import 'package:hive/hive.dart';
import 'package:restaurant/data/models/restaurant_favorite_model.dart';

class FavoriteRestaurantAdapter extends TypeAdapter<FavoriteRestaurant> {
  @override
  final int typeId = 0; // Unique ID for this adapter

  @override
  FavoriteRestaurant read(BinaryReader reader) {
    return FavoriteRestaurant(
      id: reader.read(),
      rating: reader.read(),
      name: reader.read(),
      city: reader.read(),
      description: reader.read(),
      pictureId: reader.read(),
    );
  }

  @override
  void write(BinaryWriter writer, FavoriteRestaurant obj) {
    writer.write(obj.id);
    writer.write(obj.rating);
    writer.write(obj.name);
    writer.write(obj.city);
    writer.write(obj.description);
    writer.write(obj.pictureId);
  }
}