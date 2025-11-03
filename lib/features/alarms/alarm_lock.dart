import 'dart:isolate';
import 'dart:ui';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:flutter/material.dart';

class AlarmLockService {
  static const _notificationChannelId = 'alarm_lock_channel';
  static const _notificationId = 2001;
  static bool _isRunning = false;

  static Future<void> init() async {
    FlutterForegroundTask.init(
      androidNotificationOptions: AndroidNotificationOptions(
        channelId: _notificationChannelId,
        channelName: 'Alarm Lock Service',
        channelDescription:
            'Keeps the app active while an alarm challenge is running.',
        channelImportance: NotificationChannelImportance.HIGH,
        priority: NotificationPriority.MAX,
        iconData: const NotificationIconData(
          resType: ResourceType.mipmap,
          resPrefix: ResourcePrefix.ic,
          name: 'launcher',
        ),
        buttons: [
          const NotificationButton(id: 'stop', text: 'Stop Alarm'),
        ],
      ),
      iosNotificationOptions: const IOSNotificationOptions(
        showNotification: true,
        playSound: true,
      ),
      foregroundTaskOptions: const ForegroundTaskOptions(
        interval: 5000, // every 5s background callback
        autoRunOnBoot: false,
        allowWakeLock: true,
        allowWifiLock: true,
      ),
    );
  }

  static Future<void> startLock() async {
    if (_isRunning) return;

    _isRunning = true;
    await FlutterForegroundTask.startService(
      notificationTitle: 'Alarm is Active 🔔',
      notificationText: 'Solve the challenge to stop the alarm!',
      callback: _startCallback,
    );
  }

  static Future<void> stopLock() async {
    if (!_isRunning) return;

    _isRunning = false;
    await FlutterForegroundTask.stopService();
  }

  // Background callback entry point
  @pragma('vm:entry-point')
  static void _startCallback() {
    FlutterForegroundTask.setTaskHandler(AlarmLockTaskHandler());
  }
}

class AlarmLockTaskHandler extends TaskHandler {
  @override
  Future<void> onStart(DateTime timestamp, SendPort? sendPort) async {
    debugPrint('🔒 Alarm Lock Service started at $timestamp');
  }

  @override
  Future<void> onRepeatEvent(DateTime timestamp, SendPort? sendPort) async {
    // You could periodically ensure the app is foregrounded here
    debugPrint('🔁 Alarm lock active at $timestamp');
  }

  @override
  Future<void> onDestroy(DateTime timestamp, SendPort? sendPort) async {
    debugPrint('🧩 Alarm Lock Service destroyed');
  }

  @override
  void onNotificationButtonPressed(String id) {
    if (id == 'stop') {
      FlutterForegroundTask.stopService();
    }
  }
}
