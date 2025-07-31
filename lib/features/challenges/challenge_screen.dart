// import 'package:flutter/material.dart';
// import 'math_challenge.dart';
// import 'color_sequence_challenge.dart';
// import '../alarms/alarm_storage.dart';
// import 'dart:math';

// class ChallengeScreen extends StatelessWidget {
//   const ChallengeScreen({super.key, required Future<Null> Function() onSolved});

//   void _handleSolved(BuildContext context) {
//     AlarmStorage.stopAlarmSound();
//     Navigator.of(context).pop();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final List<Widget Function()> challengeBuilders = [
//       () => MathChallenge(onSolved: () => _handleSolved(context)),
//       () => ColorSequenceChallenge(onSolved: () => _handleSolved(context)),
//     ];

//     final random = Random();
//     final challengeWidget = challengeBuilders[random.nextInt(challengeBuilders.length)]();

//     return Scaffold(
//       appBar: AppBar(title: const Text('Wake Up Challenge')),
//       body: Center(child: challengeWidget),
//     );
//   }
// }


import 'package:flutter/material.dart';

class ChallengeScreen extends StatelessWidget {
  final VoidCallback onSolved;

  const ChallengeScreen({super.key, required this.onSolved});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Solve to Stop')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            onSolved();
            Navigator.of(context).pop();
          },
          child: const Text('I Solved the Challenge!'),
        ),
      ),
    );
  }
}
