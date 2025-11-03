import 'package:hive/hive.dart';
import 'package:logging/logging.dart';
import 'alarm_model.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import '../challenges/challenge_screen.dart';
import 'package:audioplayers/audioplayers.dart';
import '../../utils/logger.dart';

final logger = Logger('AlarmStorage');


class AlarmStorage {
  static const String boxName = 'alarms';
  static final AudioPlayer _player = AudioPlayer();
  static bool shouldShowChallengeScreen = false;

  static Future<void> init() async {
    Hive.registerAdapter(AlarmAdapter());
    await Hive.openBox<Alarm>(boxName);
  }

  static Box<Alarm> get _box => Hive.box<Alarm>(boxName);

  static List<Alarm> getAll() => _box.values.toList();

  static Future<void> add(Alarm alarm) async {
    int key = await _box.add(alarm);
    alarm.id = key;
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
      int daysToAdd = 0;
      while (!alarm.recurrence.contains((nextTime.weekday % 7))) {
        nextTime = nextTime.add(const Duration(days: 1));
        daysToAdd++;
        if (daysToAdd > 7) break;
      }
      if (nextTime.isBefore(now)) {
        nextTime = nextTime.add(const Duration(days: 7));
      }
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

  static Future<void> cancelAlarm(int id) async {
    await AndroidAlarmManager.cancel(id);
  }

  /// Background isolate callback — cannot touch UI here.
  static Future<void> alarmCallback() async {
    WidgetsFlutterBinding.ensureInitialized();

    await _player.setReleaseMode(ReleaseMode.loop);
    await _player.play(AssetSource('Die_For_You.mp3')); 

    shouldShowChallengeScreen = true;
    logger.info('Alarm triggered, should show challenge screen set to true.');
    print('🔔 Alarm triggered (background isolate)');
  }

  static Future<void> stopAlarmSound() async {
    await _player.stop();
  }

  /// This should be called in your main/resume logic to show challenge screen
  static void maybeShowChallengeScreen(BuildContext context) {
    if (shouldShowChallengeScreen) {
      shouldShowChallengeScreen = false;
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => ChallengeScreen(
            onSolved: () async {
              await stopAlarmSound();
              Navigator.of(context).pop();
            },
          ),
        ),
      );
    }
  }
}
