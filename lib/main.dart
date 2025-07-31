// // import 'package:flutter/material.dart';
// // import 'theme/app_theme.dart';
// // import 'features/alarms/alarm_list_screen.dart';
// // import 'package:audioplayers/audioplayers.dart';
// // import 'package:hive_flutter/hive_flutter.dart';
// // import 'features/alarms/alarm_storage.dart';
// // import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
// // import 'features/challenges/challenge_screen.dart';
// // import 'package:permission_handler/permission_handler.dart';
// // import 'dart:isolate';
// // import 'dart:ui';

// // final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// // void main() async {
// //   WidgetsFlutterBinding.ensureInitialized();
// //   await _askPermissions();
// //   Future<void> _askPermissions() async {
// //   // Ask exact alarm permission
// //   if (await Permission.scheduleExactAlarm.isDenied) {
// //     await Permission.scheduleExactAlarm.request();
// //   }

// //   // Ask notification permission
// //   if (await Permission.notification.isDenied) {
// //     await Permission.notification.request();
// //   }

// //   // Ask to ignore battery optimization (optional)
// //   await Permission.ignoreBatteryOptimizations.request();
// // }
// //   // Init Hive and Alarms
// //   await Hive.initFlutter();
// //   await AlarmStorage.init();
// //   await AndroidAlarmManager.initialize();
// //   final player = AudioPlayer();
// //   // Set up communication from background isolate
// //   final receivePort = ReceivePort();
// //   final portName = 'alarm_port';

// //   // Remove old port mapping if exists
// //   IsolateNameServer.removePortNameMapping(portName);
// //   IsolateNameServer.registerPortWithName(receivePort.sendPort, portName);

// //   // Listen for isolate messages
// //   receivePort.listen((message) async {
// //     if (message == 'trigger_challenge') {
// //       // Play alarm
// //       await player.play(
// //         AssetSource('alarm.mp3'),
// //       ); // Ensure alarm.mp3 is added in assets

// //       // Show challenge screen
// //       navigatorKey.currentState?.push(
// //         MaterialPageRoute(builder: (context) => ChallengeScreen()),
// //       );
// //     }
// //   });

// //   runApp(const AlarmageddonApp());
// // }

// // class AlarmageddonApp extends StatelessWidget {
// //   const AlarmageddonApp({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Alarmageddon',
// //       theme: AppTheme.hellTheme,
// //       debugShowCheckedModeBanner: false,
// //       home: const AlarmListScreen(),
// //       navigatorKey: navigatorKey,
// //     );
// //   }
// // }


// import 'package:flutter/material.dart';
// import 'theme/app_theme.dart';
// import 'features/alarms/alarm_list_screen.dart';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'features/alarms/alarm_storage.dart';
// import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'features/challenges/challenge_screen.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'dart:isolate';
// import 'dart:ui';

// final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   await _askPermissions(); // ✅ Moved this call *after* function declared
//   await _initializeNotifications();
//   await Hive.initFlutter();
//   await AlarmStorage.init();
//   await AndroidAlarmManager.initialize();

//   final player = AudioPlayer();

//   final receivePort = ReceivePort();
//   final portName = 'alarm_port';

//   IsolateNameServer.removePortNameMapping(portName);
//   IsolateNameServer.registerPortWithName(receivePort.sendPort, portName);

//   receivePort.listen((message) async {
//     if (message == 'trigger_challenge') {
//       await player.play(AssetSource('alarm.mp3'));

//       navigatorKey.currentState?.push(
//         MaterialPageRoute(
//           builder: (context) => ChallengeScreen(
//             onSolved: () async {
//               await player.stop(); // ✅ Stop the alarm once challenge is solved
//             },
//           ),
//         ),
//       );
//     }
//   });

//   runApp(const AlarmageddonApp());
// }
// Future<void> _initializeNotifications() async {
//   const AndroidInitializationSettings initializationSettingsAndroid =
//       AndroidInitializationSettings('@mipmap/ic_launcher');

//   const InitializationSettings initializationSettings = InitializationSettings(
//     android: initializationSettingsAndroid,
//   );

//   await flutterLocalNotificationsPlugin.initialize(
//     initializationSettings,
//     onDidReceiveNotificationResponse: (response) async {
//       if (response.payload == 'challenge') {
//         navigatorKey.currentState?.push(
//           MaterialPageRoute(
//             builder: (context) => ChallengeScreen(
//               onSolved: () async {
//                 final player = AudioPlayer();
//                 await player.stop();
//               },
//             ),
//           ),
//         );
//       }
//     },
//   );
// }

// // ✅ Define this BEFORE calling
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


import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'features/alarms/alarm_scheduler.dart';
import 'features/challenges/challenge_screen.dart';

final FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();

  await _initializeNotifications();
  runApp(const AlarmApp());
}

Future<void> _initializeNotifications() async {
  const AndroidInitializationSettings androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');

  final InitializationSettings initSettings = InitializationSettings(android: androidSettings);

  await notificationsPlugin.initialize(
    initSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) async {
      if (response.payload == 'trigger_challenge') {
        navigatorKey.currentState?.push(
          MaterialPageRoute(
            builder: (_) => ChallengeScreen(onSolved: () async {
              await AlarmScheduler.stopAlarmSound();
            }),
          ),
        );
        AlarmScheduler.playAlarmSound();
      }
    },
  );
}

class AlarmApp extends StatelessWidget {
  const AlarmApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alarmageddon',
      navigatorKey: navigatorKey,
      home: Scaffold(
        appBar: AppBar(title: const Text('Alarmageddon')),
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              final now = DateTime.now();
              final alarmTime = now.add(const Duration(seconds: 10)); // 10 seconds later
              await AlarmScheduler.scheduleAlarm(alarmTime);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Alarm set for ${alarmTime.hour}:${alarmTime.minute}:${alarmTime.second}')),
              );
            },
            child: const Text('Set Alarm (in 10s)'),
          ),
        ),
      ),
    );
  }
}
