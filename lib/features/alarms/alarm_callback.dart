// // // alarm_callback.dart
// // import 'dart:isolate';
// // import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
// // import 'package:flutter/material.dart';
// // import 'package:audioplayers/audioplayers.dart';
// // import '../challenges/challenge_screen.dart'; // Import your challenge screen
// // import '../../main.dart'; // For access to navigatorKey

// // final AudioPlayer _audioPlayer = AudioPlayer();

// // Future<void> alarmCallback() async {
// //   print('🔔 Alarm triggered!');
// //   _audioPlayer.play(
// //     AssetSource('assets/Die_For_You.mp3'),
// //   ); // Replace with actual file

// //   // Use navigatorKey to push challenge screen
// //   navigatorKey.currentState?.push(
// //     MaterialPageRoute(
// //       builder: (context) => ChallengeScreen(
// //         onSolved: () async {
// //           await _audioPlayer.stop();
// //           navigatorKey.currentState?.pop(); // Dismiss the challenge screen
// //         },
// //       ),
// //     ),
// //   );
// // }


// // alarm_callback.dart
// import 'dart:isolate';
// import 'dart:ui';
// import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:flutter/foundation.dart';

// final AudioPlayer _audioPlayer = AudioPlayer();

// // Background callback
// Future<void> alarmCallback() async {
//   print('🔔 Alarm triggered in background isolate!');

//   // Playing alarm sound
//   await _audioPlayer.play(
//     AssetSource('assets/Die_For_You.mp3'),
//   );

//   // You cannot push a screen from here.
//   // Instead, send a message to the main isolate.
//   final port = IsolateNameServer.lookupPortByName('alarm_port');
//   port?.send('trigger_challenge');
// }


import 'dart:isolate';
import 'package:flutter/services.dart';
import 'dart:ui';

void alarmCallback() {
  final SendPort? sendPort = IsolateNameServer.lookupPortByName('alarm_port');

  if (sendPort != null) {
    sendPort.send('trigger_challenge');
  }

  // Play sound using platform channel or use isolate-safe sound package
  // You CANNOT use audioplayers directly here, instead trigger sound from main isolate via message
}
