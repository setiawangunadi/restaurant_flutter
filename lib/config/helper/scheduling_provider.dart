import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:restaurant/config/helper/background_service.dart';

class SchedulingProvider extends ChangeNotifier {
  bool _isScheduled = false;

  bool get isScheduled => _isScheduled;

  Future<bool> scheduledNews(bool value) async {
    const TimeOfDay everydayTime = TimeOfDay(hour: 11, minute: 00);
    DateTime now = DateTime.now();
    DateTime everydayDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      everydayTime.hour,
      everydayTime.minute,
    );
    _isScheduled = value;
    if (_isScheduled) {
      print('Scheduling Activated');
      notifyListeners();
      return await AndroidAlarmManager.oneShotAt(
        everydayDateTime,
        2,
        BackgroundService.callback,
        exact: true,
        wakeup: true,
      );
    } else {
      print('Scheduling Canceled');
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}
