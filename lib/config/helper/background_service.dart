import 'dart:math';
import 'dart:ui';
import 'dart:isolate';
import 'package:restaurant/config/helper/notification_helper.dart';
import 'package:restaurant/data/models/list_restaurant_response_model.dart';
import 'package:restaurant/data/repositories/restaurant_repository.dart';
import 'package:restaurant/main.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _instance;
  static const String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService._internal() {
    _instance = this;
  }

  factory BackgroundService() => _instance ?? BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    print('Alarm fired!');
    final NotificationHelper notificationHelper = NotificationHelper();
    var result = await RestaurantRepository().doGetListRestaurant();
    if (result.statusCode == 200) {
      ListRestaurantResponseModel dataRestaurant =
          ListRestaurantResponseModel.fromJson(result.data);
      int index = Random().nextInt(dataRestaurant.restaurants!.length);
      Restaurant restaurant = dataRestaurant.restaurants![index];
      await notificationHelper.showNotification(
        flutterLocalNotificationsPlugin,
        restaurant,
      );
    }

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}
