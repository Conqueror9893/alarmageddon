// import 'package:alarmageddon/features/alarms/alarm_callback.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'dart:isolate';
// import 'dart:ui';
// import 'package:audioplayers/audioplayers.dart';

// import 'features/alarms/alarm_list_screen.dart';
// import 'features/alarms/alarm_storage.dart';
// import 'features/challenges/challenge_screen.dart';
// import 'theme/app_theme.dart';

// final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   await _askPermissions();

//   await Hive.initFlutter();
//   await AlarmStorage.init();
//   await AndroidAlarmManager.initialize();

//   final player = AudioPlayer();

//   final receivePort = ReceivePort();
//   const portName = 'alarm_port';

//   // Ensure no old port mapping exists
//   if (IsolateNameServer.lookupPortByName(portName) != null) {
//     IsolateNameServer.removePortNameMapping(portName);
//   }
//   IsolateNameServer.registerPortWithName(receivePort.sendPort, portName);

//   receivePort.listen((message) async {
//     if (message == 'trigger_challenge') {
//       // When the background isolate sends a message, show the challenge screen
//       // and play the alarm sound.
//       await player.play(AssetSource('Die_For_You.mp3'), volume: 1.0);

//       navigatorKey.currentState?.push(
//         MaterialPageRoute(
//           builder: (context) => ChallengeScreen(
//             onSolved: () async {
//               await player.stop();
//               // Potentially navigate back or show a success message
//               if (navigatorKey.currentState!.canPop()) {
//                 navigatorKey.currentState!.pop();
//               }
//             },
//           ),
//         ),
//       );
//     }
//   });

//   runApp(const ProviderScope(child: AlarmageddonApp()));

//   // After the app is running, you can schedule alarms.
//   // For example, schedule the callback.
//   // This is just an example; the actual scheduling will happen in the UI.
//   // await AndroidAlarmManager.oneShot(
//   //   const Duration(seconds: 5),
//   //   0, // Alarm ID
//   //   alarmCallback,
//   //   exact: true,
//   //   wakeup: true,
//   // );
// }

// Future<void> _askPermissions() async {
//   if (await Permission.scheduleExactAlarm.isDenied) {
//     await Permission.scheduleExactAlarm.request();
//   }

//   if (await Permission.notification.isDenied) {
//     await Permission.notification.request();
//   }

//   await Permission.ignoreBatteryOptimizations.request();
// }

// class AlarmageddonApp extends StatelessWidget {
//   const AlarmageddonApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Alarmageddon',
//       theme: AppTheme.hellTheme,
//       debugShowCheckedModeBanner: false,
//       home: const AlarmListScreen(),
//       navigatorKey: navigatorKey,
//     );
//   }
// }

import 'dart:isolate';
import 'dart:ui';
import 'dart:io' show Platform;

import 'package:alarmageddon/features/alarms/alarm_callback.dart';
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
import 'features/challenges/challenge_screen.dart';
import 'theme/app_theme.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _askPermissions();

  await Hive.initFlutter();
  await AlarmStorage.init();

  // Initialize alarm manager only on Android
  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }

  final player = AudioPlayer();

  final receivePort = ReceivePort();
  const portName = 'alarm_port';

  // Ensure no old port mapping exists
  if (IsolateNameServer.lookupPortByName(portName) != null) {
    IsolateNameServer.removePortNameMapping(portName);
  }
  IsolateNameServer.registerPortWithName(receivePort.sendPort, portName);

  receivePort.listen((message) async {
    if (message == 'trigger_challenge') {
      await player.play(AssetSource('Die_For_You.mp3'), volume: 1.0);

      navigatorKey.currentState?.push(
        MaterialPageRoute(
          builder: (context) => ChallengeScreen(
            onSolved: () async {
              await player.stop();
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
      home: const AlarmListScreen(),
      navigatorKey: navigatorKey,
      routes: {
        '/mathematical_torment': (context) => MathChallenge(
          onSolved: () {
            Navigator.of(context).pop();
          },
        ),
        '/memory_of_the_damned': (context) =>  ColorSequenceChallenge(
          onSolved: () {
            Navigator.of(context).pop();
          },
        ),
        '/the_cursed_utterance': (context) =>  SpeakSentenceChallenge(
          onSolved: () {
            Navigator.of(context).pop();
          },
        ),
      },
    );
  }
}
