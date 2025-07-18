import 'dart:math';
import 'package:flutter/material.dart';

class MathChallenge extends StatefulWidget {
  final VoidCallback onSolved;
  const MathChallenge({Key? key, required this.onSolved}) : super(key: key);

  @override
  State<MathChallenge> createState() => _MathChallengeState();
}

class _MathChallengeState extends State<MathChallenge> {
  late int a;
  late int b;
  late String op;
  late int answer;
  final TextEditingController _controller = TextEditingController();
  String? _error;

  @override
  void initState() {
    super.initState();
    final rand = Random();
    a = rand.nextInt(50) + 1;
    b = rand.nextInt(50) + 1;
    if (rand.nextBool()) {
      op = '+';
      answer = a + b;
    } else {
      op = '-';
      // Ensure no negative answers
      if (a < b) {
        final tmp = a;
        a = b;
        b = tmp;
      }
      answer = a - b;
    }
  }

  void _checkAnswer() {
    if (int.tryParse(_controller.text) == answer) {
      widget.onSolved();
    } else {
      setState(() {
        _error = 'Wrong answer! Try again.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Solve: $a $op $b = ?',
              style: const TextStyle(fontSize: 24, color: Colors.red),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Your answer',
                labelStyle: const TextStyle(color: Colors.white70),
                errorText: _error,
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepOrange),
                ),
              ),
              onSubmitted: (_) => _checkAnswer(),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _checkAnswer,
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
