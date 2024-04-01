import 'package:restaurant/data/local/local_storage.dart';

class FavoriteStorage {
  static Future<void> setJSON(Map<String, dynamic> json) async {
    await localStorage.putJson(boxName: StorageConstants.favorite.name, json: json);
  }

  static Future<String?> getAccessToken() async {
    var box = await localStorage.getData(
        boxName: StorageConstants.favorite.name, key: 'access_token');
    return box;
  }

  static Future<String?> getSessionId() async {
    var box = await localStorage.getData(
        boxName: StorageConstants.favorite.name, key: 'sessionId');
    return box;
  }

  static Future<String?> getPhoneCS() async {
    var box = await localStorage.getData(
        boxName: StorageConstants.favorite.name, key: 'value');
    return box;
  }

  static Future<String> getName() async {
    var box = await localStorage.getData(
        boxName: StorageConstants.favorite.name, key: 'name');
    return box;
  }

  static Future<String> getEmail() async {
    var box = await localStorage.getData(
        boxName: StorageConstants.favorite.name, key: 'email');
    return box;
  }

  static Future<bool> getCustomerActive() async {
    var box = await localStorage.getData(
        boxName: StorageConstants.favorite.name, key: 'customerActive');
    return box;
  }

  static Future<String?> getGroupId() async {
    var box = await localStorage.getData(
        boxName: StorageConstants.favorite.name, key: 'groupId');
    return box;
  }

  static Future<String?> getfavoritename() async {
    var box = await localStorage.getData(
        boxName: StorageConstants.favorite.name, key: 'favoritename');
    return box;
  }

  static Future<String?> getBiometricToken() async {
    var box = await localStorage.getData(
        boxName: StorageConstants.favorite.name, key: 'biometricToken');
    return box;
  }

  static Future<String?> getLatModified() async {
    var box = await localStorage.getData(
        boxName: StorageConstants.favorite.name, key: 'lastModifiedTimestamp');
    return box;
  }

  static Future<void> deleteDatafavorite() async {
    await localStorage.deleteBox(name: StorageConstants.favorite.name);
  }
}