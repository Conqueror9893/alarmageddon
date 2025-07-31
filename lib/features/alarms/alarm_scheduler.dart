import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:audioplayers/audioplayers.dart';
import '../../main.dart';

class AlarmScheduler {
  static final AudioPlayer _audioPlayer = AudioPlayer();

  static Future<void> scheduleAlarm(DateTime dateTime) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'alarm_channel',
      'Alarm Notifications',
      channelDescription: 'Triggers alarm & challenge',
      importance: Importance.max,
      priority: Priority.high,
      sound: RawResourceAndroidNotificationSound('alarm'),
      playSound: true,
      fullScreenIntent: true,
      visibility: NotificationVisibility.public,
    );

    const NotificationDetails notifDetails = NotificationDetails(android: androidDetails);

    await notificationsPlugin.zonedSchedule(
      0,
      'Wake up!',
      'Solve the challenge to dismiss the alarm.',
      tz.TZDateTime.from(dateTime, tz.local),
      notifDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      payload: 'trigger_challenge',
    );
  }

  static Future<void> playAlarmSound() async {
    await _audioPlayer.play(AssetSource('alarm.mp3'), volume: 1.0);
  }

  static Future<void> stopAlarmSound() async {
    await _audioPlayer.stop();
  }
}
