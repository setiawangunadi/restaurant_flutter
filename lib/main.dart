import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:restaurant/config/app_routes.dart';
import 'package:restaurant/data/adapter/restaurant_favorite_adapter.dart';
import 'package:restaurant/data/models/restaurant_favorite_model.dart';

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
