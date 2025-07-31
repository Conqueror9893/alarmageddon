import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:alarmageddon/features/alarms/alarm_callback.dart';

class AlarmScheduler {
  static Future<void> scheduleAlarm(DateTime scheduledTime, int alarmId) async {
    await AndroidAlarmManager.oneShotAt(
      scheduledTime,
      alarmId,
      alarmCallback,
      exact: true,
      wakeup: true,
      alarmClock: true,
    );
  }

  static Future<void> cancelAlarm(int alarmId) async {
    await AndroidAlarmManager.cancel(alarmId);
  }
}
