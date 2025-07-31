import 'package:flutter/material.dart';
import 'math_challenge.dart';
import 'color_sequence_challenge.dart';
import 'dart:math';

class ChallengeScreen extends StatelessWidget {
  final VoidCallback onSolved;

  const ChallengeScreen({super.key, required this.onSolved});

  void _handleSolved(BuildContext context) {
    onSolved();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget Function()> challengeBuilders = [
      () => MathChallenge(onSolved: () => _handleSolved(context)),
      () => ColorSequenceChallenge(onSolved: () => _handleSolved(context)),
    ];

    final random = Random();
    final challengeWidget =
        challengeBuilders[random.nextInt(challengeBuilders.length)]();

    return Scaffold(
      appBar: AppBar(title: const Text('Wake Up Challenge')),
      body: Center(child: challengeWidget),
    );
  }
}
