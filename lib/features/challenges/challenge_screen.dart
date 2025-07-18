import 'package:flutter/material.dart';
import 'math_challenge.dart';
import '../alarms/alarm_storage.dart';

class ChallengeScreen extends StatelessWidget {
  const ChallengeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Wake Up Challenge')),
      body: Center(
        child: MathChallenge(
          onSolved: () {
            AlarmStorage.stopAlarmSound();
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}
