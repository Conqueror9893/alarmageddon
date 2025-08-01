import 'dart:math';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeakSentenceChallenge extends StatefulWidget {
  final VoidCallback onSolved;
  const SpeakSentenceChallenge({super.key, required this.onSolved});

  @override
  State<SpeakSentenceChallenge> createState() => _SpeakSentenceChallengeState();
}

class _SpeakSentenceChallengeState extends State<SpeakSentenceChallenge> {
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
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
    _initSpeech();
  }

  void _initSpeech() async {
    await _speech.initialize();
  }

  void _selectRandomSentence() {
    final random = Random();
    final index = random.nextInt(_sentences.length);
    setState(() {
      _germanSentence = _sentences.keys.elementAt(index);
      _englishSentence = _sentences.values.elementAt(index);
    });
  }

  void _startListening() async {
    if (!_isListening) {
      bool available = await _speech.initialize();
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _recognizedText = val.recognizedWords;
            if (_recognizedText.toLowerCase() == _germanSentence.toLowerCase()) {
              widget.onSolved();
            }
          }),
        );
      }
    }
  }

  void _stopListening() async {
    if (_isListening) {
      setState(() => _isListening = false);
      _speech.stop();
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
              onPressed: _isListening ? _stopListening : _startListening,
              child: Icon(_isListening ? Icons.mic_off : Icons.mic),
            ),
            const SizedBox(height: 16),
            Text(
              _recognizedText,
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
