import 'dart:isolate';
import 'dart:ui';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// This is the entrypoint for the alarm isolate.
@pragma('vm:entry-point')
void alarmCallback() async {
  // Initialize plugins.
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Initialize the plugin for the background isolate
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'alarm_channel_id',
    'alarm_channel_name',
    channelDescription: 'alarm_channel_description',
    importance: Importance.max,
    priority: Priority.high,
    showWhen: false,
    fullScreenIntent: true,
  );

  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  // Show a notification
  await flutterLocalNotificationsPlugin.show(
    0,
    'Alarm',
    'Your alarm is ringing!',
    platformChannelSpecifics,
  );

  // Get the SendPort to communicate with the main isolate.
  final SendPort? sendPort = IsolateNameServer.lookupPortByName('alarm_port');
  if (sendPort != null) {
    sendPort.send('trigger_challenge');
  }
}
