import 'package:hive/hive.dart';
import 'package:logging/logging.dart';
import 'alarm_model.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'alarm_callback.dart';

final logger = Logger('AlarmStorage');

class AlarmStorage {
  static const String boxName = 'alarms';

  static Future<void> init() async {
    Hive.registerAdapter(AlarmAdapter());
    await Hive.openBox<Alarm>(boxName);
  }

  static Box<Alarm> get _box => Hive.box<Alarm>(boxName);

  static List<Alarm> getAll() => _box.values.toList();

  static Future<void> add(Alarm alarm) async {
    if (alarm.key == null) {
      int key = await _box.add(alarm);
      alarm.id = key;
    }
    await alarm.save();
  }

  static Future<void> update(Alarm alarm) async {
    await alarm.save();
  }

  static Future<void> delete(int id) async {
    await _box.delete(id);
  }

  static Future<void> scheduleAlarm(Alarm alarm) async {
    if (!alarm.enabled) return;

    final now = DateTime.now();
    DateTime nextTime = DateTime(
      now.year,
      now.month,
      now.day,
      alarm.time.hour,
      alarm.time.minute,
    );

    if (alarm.recurrence.isEmpty) {
      if (nextTime.isBefore(now)) {
        nextTime = nextTime.add(const Duration(days: 1));
      }
    } else {
      nextTime = _findNextRecurrentTime(nextTime, alarm.recurrence);
    }

    print('Scheduling alarm at: $nextTime with id ${alarm.id}'); // Debug print

    await AndroidAlarmManager.oneShotAt(
      nextTime,
      alarm.id,
      alarmCallback,
      exact: true,
      wakeup: true,
      rescheduleOnReboot: true,
    );
  }

  static DateTime _findNextRecurrentTime(
      DateTime baseTime, List<int> recurrence) {
    final now = DateTime.now();
    DateTime nextTime = baseTime;

    while (!recurrence.contains(nextTime.weekday % 7)) {
      nextTime = nextTime.add(const Duration(days: 1));
    }

    if (nextTime.isBefore(now)) {
      nextTime = nextTime.add(const Duration(days: 7));
      while (!recurrence.contains(nextTime.weekday % 7)) {
        nextTime = nextTime.add(const Duration(days: 1));
      }
    }
    return nextTime;
  }

  static Future<void> cancelAlarm(int id) async {
    await AndroidAlarmManager.cancel(id);
  }
}
