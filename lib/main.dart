import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:restaurant/config/app_routes.dart';
import 'package:restaurant/config/helper/background_service.dart';
import 'package:restaurant/config/helper/notification_helper.dart';
import 'package:restaurant/data/adapter/restaurant_favorite_adapter.dart';
import 'package:restaurant/data/models/restaurant_favorite_model.dart';
import 'package:restaurant/navigation.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundService service = BackgroundService();
  Directory appDirectory;
  if (Platform.isIOS) {
    appDirectory = await getApplicationDocumentsDirectory();
  } else {
    appDirectory = (await getExternalStorageDirectory())!;
  }

  service.initializeIsolate();
  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  Hive.init(appDirectory.path);
  Hive.registerAdapter(FavoriteRestaurantAdapter());
  await Hive.openBox<FavoriteRestaurant>('favorite');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splash,
      routes: AppRoutes().route,
      theme: ThemeData(),
    );
  }
}
