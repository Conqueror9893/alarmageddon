import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SpeakSentenceChallenge extends StatefulWidget {
  final VoidCallback onSolved;
  const SpeakSentenceChallenge({super.key, required this.onSolved});

  @override
  State<SpeakSentenceChallenge> createState() => _SpeakSentenceChallengeState();
}

class _SpeakSentenceChallengeState extends State<SpeakSentenceChallenge> {
  static const _speechChannel = MethodChannel('alarmageddon/speech');
  String _recognizedText = '';
  String _germanSentence = '';
  String _englishSentence = '';
  final Map<String, String> _sentences = {
    'Guten Morgen': 'Good morning',
    'Wie geht es Ihnen': 'How are you',
    'Ich liebe dich': 'I love you',
    'Danke schön': 'Thank you very much',
  };

  @override
  void initState() {
    super.initState();
    _selectRandomSentence();
  }

  void _selectRandomSentence() {
    final random = Random();
    final index = random.nextInt(_sentences.length);
    setState(() {
      _germanSentence = _sentences.keys.elementAt(index);
      _englishSentence = _sentences.values.elementAt(index);
      _recognizedText = '';
    });
  }

  Future<void> _startListening() async {
    try {
      final result = await _speechChannel.invokeMethod<String>(
        'startListening',
        {'prompt': 'Speak: $_germanSentence'},
      );
      if (result != null) {
        setState(() {
          _recognizedText = result;
        });
        if (_recognizedText.toLowerCase().trim() ==
            _germanSentence.toLowerCase().trim()) {
          widget.onSolved();
        }
      }
    } on PlatformException catch (e) {
      debugPrint('Speech error: $e');
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
            const Text(
              'Speak the German sentence:',
              style: TextStyle(fontSize: 20, color: Colors.red),
            ),
            const SizedBox(height: 16),
            Text(
              _germanSentence,
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              'English: $_englishSentence',
              style: const TextStyle(fontSize: 16, color: Colors.white70),
            ),
            const SizedBox(height: 24),
            FloatingActionButton(
              onPressed: _startListening,
              child: const Icon(Icons.mic),
            ),
            const SizedBox(height: 16),
            Text(
              _recognizedText,
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _selectRandomSentence,
              child: const Text('New Sentence'),
            )
          ],
        ),
      ),
    );
  }
}
