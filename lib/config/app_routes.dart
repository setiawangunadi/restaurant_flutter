import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant/blocs/detail/detail_bloc.dart';
import 'package:restaurant/blocs/home/home_bloc.dart';
import 'package:restaurant/blocs/list_favorite/list_favorite_bloc.dart';
import 'package:restaurant/blocs/list_menu/list_menu_bloc.dart';
import 'package:restaurant/blocs/splash/splash_bloc.dart';
import 'package:restaurant/screens/detail_screen.dart';
import 'package:restaurant/screens/home_screen.dart';
import 'package:restaurant/screens/list_favorite_screen.dart';
import 'package:restaurant/screens/list_menu_screen.dart';
import 'package:restaurant/screens/setting_screen.dart';
import 'package:restaurant/screens/splash_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String splash = '/splash';
  static const String detail = '/detail';
  static const String listFoodAndDrink = '/list-food-drink';
  static const String listFavorite = '/list-favorite';
  static const String settings = '/settings';

  final route = <String, WidgetBuilder>{
    AppRoutes.splash: (BuildContext context) {
      return BlocProvider(
        create: (context) => SplashBloc(),
        child: const SplashScreen(),
      );
    },
    AppRoutes.home: (BuildContext context) {
      return BlocProvider(
        create: (context) => HomeBloc(),
        child: const HomeScreen(),
      );
    },
    AppRoutes.detail: (BuildContext context) {
      var arguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

      return BlocProvider(
        create: (context) => DetailBloc(),
        child: DetailScreen(
          id: arguments["id"],
          detailType: arguments['detailType'],
          index: arguments["index"],
        ),
      );
    },
    AppRoutes.listFoodAndDrink: (BuildContext context) {
      var arguments =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

      return BlocProvider(
        create: (context) => ListMenuBloc(),
        child: ListMenuScreen(
          title: arguments["title"],
          listMenu: arguments["listMenu"],
        ),
      );
    },
    AppRoutes.listFavorite: (BuildContext context) {
      return BlocProvider(
        create: (context) => ListFavoriteBloc(),
        child: const ListFavoriteScreen(),
      );
    },
    AppRoutes.settings: (BuildContext context) {
      return const SettingScreen();
    },
  };
}
