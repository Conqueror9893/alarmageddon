import 'dart:isolate';
import 'dart:ui';
import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:alarmageddon/features/challenges/math_challenge.dart';
import 'package:alarmageddon/features/challenges/color_sequence_challenge.dart';
import 'package:alarmageddon/features/challenges/speak_sentence_challenge.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'features/alarms/alarm_list_screen.dart';
import 'features/alarms/alarm_storage.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'features/alarms/alarm_lock.dart';
import 'features/challenges/challenge_screen.dart';
import 'theme/app_theme.dart';
import 'package:alarmageddon/features/alarms/alarm_splash_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _askPermissions();

  await Hive.initFlutter();
  await AlarmStorage.init();
  await AlarmLockService.init();

  // Initialize alarm manager only on Android
  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }

  final receivePort = ReceivePort();
  const portName = 'alarm_port';

  // Ensure no old port mapping exists
  if (IsolateNameServer.lookupPortByName(portName) != null) {
    IsolateNameServer.removePortNameMapping(portName);
  }
  IsolateNameServer.registerPortWithName(receivePort.sendPort, portName);

  receivePort.listen((message) async {
    if (message == 'trigger_challenge') {
      final player = AudioPlayer();
      await player.setReleaseMode(ReleaseMode.loop);
      await player.play(AssetSource('Die_For_You.mp3'), volume: 1.0);

      // Start lock foreground service
      await AlarmLockService.startLock();

      navigatorKey.currentState?.push(
        MaterialPageRoute(
          builder: (context) => ChallengeScreen(
            onSolved: () async {
              await player.stop();
              await AlarmLockService.stopLock(); // stop lock service
              if (navigatorKey.currentState!.canPop()) {
                navigatorKey.currentState!.pop();
              }
            },
          ),
        ),
      );
    }
  });

  runApp(const ProviderScope(child: AlarmageddonApp()));
}

Future<void> _askPermissions() async {
  if (!Platform.isAndroid) return; // Skip on non-Android platforms

  if (await Permission.scheduleExactAlarm.isDenied) {
    await Permission.scheduleExactAlarm.request();
  }

  if (await Permission.notification.isDenied) {
    await Permission.notification.request();
  }

  await Permission.ignoreBatteryOptimizations.request();
}

class AlarmageddonApp extends StatelessWidget {
  const AlarmageddonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alarmageddon',
      theme: AppTheme.hellTheme,
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      navigatorKey: navigatorKey,
      routes: {
        '/alarm_list': (context) => const AlarmListScreen(),
        '/mathematical_torment': (context) => MathChallenge(
          onSolved: () {
            Navigator.of(context).pop();
          },
        ),
        '/memory_of_the_damned': (context) => ColorSequenceChallenge(
          onSolved: () {
            Navigator.of(context).pop();
          },
        ),
        '/the_cursed_utterance': (context) => SpeakSentenceChallenge(
          onSolved: () {
            Navigator.of(context).pop();
          },
        ),
      },
    );
  }
}
