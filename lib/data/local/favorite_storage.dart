import 'package:restaurant/data/local/local_storage.dart';

class FavoriteStorage {
  static Future<void> setJSON(Map<String, dynamic> json) async {
    await localStorage.putJson(
        boxName: StorageConstants.settings.name, json: json);
  }

  static Future<bool?> getStatusNotification() async {
    var box = await localStorage.getData(
        boxName: StorageConstants.settings.name, key: 'notification');
    return box;
  }

  static Future<void> deleteDataFavorite() async {
    await localStorage.deleteBox(name: StorageConstants.settings.name);
  }
}
