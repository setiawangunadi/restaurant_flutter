import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';

enum StorageConstants { favorite }

class LocalStorage {
  LocalStorage();

  Future<void> putJson(
      {required String boxName, required Map<String, dynamic> json}) async {
    List<int> hiveKey = await hiveKeys;
    Box box =
    await Hive.openBox(boxName, encryptionCipher: HiveAesCipher(hiveKey));
    await box.putAll(json);
    await box.close();
    debugPrint("DONE PUT JSON HIVE");
    return;
  }

  Future<void> putString(
      {required String boxName,
        required String key,
        required String value}) async {
    List<int> hiveKey = await hiveKeys;
    Box box =
    await Hive.openBox(boxName, encryptionCipher: HiveAesCipher(hiveKey));
    await box.put(key, value);
    await box.close();
    return;
  }

  Future<void> putBox(
      {required String boxName,
        required String key,
        required dynamic data}) async {
    List<int> hiveKey = await hiveKeys;
    Box box =
    await Hive.openBox(boxName, encryptionCipher: HiveAesCipher(hiveKey));
    final String stringJson = json.encode(data);
    await box.put(key, stringJson);
    await box.close();
    return;
  }

  Future<void> updateBox(
      {required String boxName,
        required Map<String, dynamic> value,
        required int index}) async {
    List<int> hiveKey = await hiveKeys;
    Box box =
    await Hive.openBox(boxName, encryptionCipher: HiveAesCipher(hiveKey));
    await box.putAt(index, value);
    await box.close();
  }

  Future<dynamic> getData(
      {required String boxName, required String key}) async {
    List<int> hiveKey = await hiveKeys;
    Box box =
    await Hive.openBox(boxName, encryptionCipher: HiveAesCipher(hiveKey));
    final value = await box.get(key);
    await box.close();
    return value;
  }

  Future<List> getList({required String boxName}) async {
    List<int> hiveKey = await hiveKeys;
    Box box =
    await Hive.openBox(boxName, encryptionCipher: HiveAesCipher(hiveKey));
    await box.close();
    return box.values.toList();
  }

  Future<void> deleteBox({required String name}) async {
    List<int> hiveKey = await hiveKeys;
    Box box =
    await Hive.openBox(name, encryptionCipher: HiveAesCipher(hiveKey));
    await box.deleteFromDisk();
    await box.close();
    return;
  }

  Future<List<dynamic>> getListData({required String boxName}) async {
    List<int> hiveKey = await hiveKeys;

    Box box =
    await Hive.openBox(boxName, encryptionCipher: HiveAesCipher(hiveKey));
    return box.values.toList();
  }

  Future<dynamic> getBox({required String boxName}) async {
    List<int> hiveKey = await hiveKeys;

    Box box =
    await Hive.openBox(boxName, encryptionCipher: HiveAesCipher(hiveKey));
    await box.close();
    return box.values;
  }

  Future<void> deleteDataIndex({required String name, int index = 0}) async {
    List<int> hiveKey = await hiveKeys;
    Box box =
    await Hive.openBox(name, encryptionCipher: HiveAesCipher(hiveKey));
    await box.deleteAt(index);
    await box.close();
    return;
  }

  Future<void> putBool(
      {required String boxName,
        required String key,
        required bool value}) async {
    List<int> hiveKey = await hiveKeys;
    Box box =
    await Hive.openBox(boxName, encryptionCipher: HiveAesCipher(hiveKey));
    await box.put(key, value);
    await box.close();
  }

  Future<bool> getBool({required String boxName, required String key}) async {
    List<int> hiveKey = await hiveKeys;
    Box box =
    await Hive.openBox(boxName, encryptionCipher: HiveAesCipher(hiveKey));
    bool? value = await box.get(key);
    await box.close();
    if (value == null) {
      return false;
    } else {
      return value;
    }
  }

  Future<String?> getString(
      {required String boxName, required String key}) async {
    List<int> hiveKey = await hiveKeys;
    Box box =
    await Hive.openBox(boxName, encryptionCipher: HiveAesCipher(hiveKey));
    String? value = await box.get(key);
    await box.close();
    return value;
  }

  Future<dynamic> get hiveKeys async {
    const ss = FlutterSecureStorage();
    try {
      String? stringKey = await ss.read(key: 'boxKey');
      List<int> hiveKey;
      if (stringKey != null) {
        hiveKey = stringKey.codeUnits;
      } else {
        hiveKey = Hive.generateSecureKey();
        Uint8List bytes = Uint8List.fromList(hiveKey);
        stringKey = String.fromCharCodes(bytes);
        await ss.write(key: 'boxKey', value: stringKey);
      }
      return hiveKey;
    } catch (e) {
      debugPrint("Error : $e");
      return e;
    }
  }
}

final localStorage = LocalStorage();
