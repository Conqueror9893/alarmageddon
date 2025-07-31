import 'dart:math';
import 'package:flutter/material.dart';

class ColorSequenceChallenge extends StatefulWidget {
  final VoidCallback onSolved;
  const ColorSequenceChallenge({super.key, required this.onSolved});

  @override
  State<ColorSequenceChallenge> createState() => _ColorSequenceChallengeState();
}

class _ColorSequenceChallengeState extends State<ColorSequenceChallenge> {
  final List<Color> _availableColors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.orange,
    Colors.purple,
  ];

  late List<Color> _sequence; // The correct sequence
  late List<Color> _shuffledColors; // Displayed buttons
  int _currentTapIndex = 0;

  @override
  void initState() {
    super.initState();
    _generateChallenge();
  }

  void _generateChallenge() {
    _sequence = List<Color>.from(_availableColors)..shuffle();
    _shuffledColors = List<Color>.from(_sequence)..shuffle();
    _currentTapIndex = 0;
  }

  void _handleTap(Color color) {
    if (color == _sequence[_currentTapIndex]) {
      setState(() {
        _currentTapIndex++;
      });
      if (_currentTapIndex == _sequence.length) {
        widget.onSolved();
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Wrong order! Try again.")),
      );
      setState(() {
        _currentTapIndex = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        const Text('Memorize the sequence:', style: TextStyle(fontSize: 18)),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _sequence.map((color) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(backgroundColor: color, radius: 15),
            );
          }).toList(),
        ),
        const SizedBox(height: 30),
        const Text('Tap in the same order:', style: TextStyle(fontSize: 16)),
        const SizedBox(height: 10),
        Wrap(
          spacing: 15,
          runSpacing: 15,
          children: _shuffledColors.map((color) {
            return GestureDetector(
              onTap: () => _handleTap(color),
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  border: Border.all(width: 2, color: Colors.black),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
