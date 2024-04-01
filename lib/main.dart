import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:restaurant/config/app_routes.dart';
import 'package:restaurant/config/helper/notification_helper.dart';
import 'package:restaurant/data/adapter/restaurant_favorite_adapter.dart';
import 'package:restaurant/data/models/restaurant_favorite_model.dart';
import 'package:timezone/data/latest.dart' as tz;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory appDirectory;
  if (Platform.isIOS) {
    appDirectory = await getApplicationDocumentsDirectory();
  } else {
    appDirectory = (await getExternalStorageDirectory())!;
  }

  Hive.init(appDirectory.path);
  Hive.registerAdapter(FavoriteRestaurantAdapter());
  await Hive.openBox<FavoriteRestaurant>('favorite');
  PermissionStatus status = await Permission.notification.request();
  if (status.isGranted) {
    final NotificationHelper notificationHelper = NotificationHelper();
    await notificationHelper.initNotification(flutterLocalNotificationsPlugin);
    notificationHelper.requestIOSPermissions(flutterLocalNotificationsPlugin);
    tz.initializeTimeZones();
  } else if (status.isDenied) {
    debugPrint("DENIED PERMISSION NOTIF");
  } else if (status.isPermanentlyDenied) {
    debugPrint("SET MANUALLY PERMISSION NOTIF");
    openAppSettings();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splash,
      routes: AppRoutes().route,
      theme: ThemeData(),
    );
  }
}
