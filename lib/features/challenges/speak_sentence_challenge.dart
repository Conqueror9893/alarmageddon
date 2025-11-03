// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class SpeakSentenceChallenge extends StatefulWidget {
//   final VoidCallback onSolved;
//   const SpeakSentenceChallenge({super.key, required this.onSolved});

//   @override
//   State<SpeakSentenceChallenge> createState() => _SpeakSentenceChallengeState();
// }

// class _SpeakSentenceChallengeState extends State<SpeakSentenceChallenge> {
//   static const _speechChannel = MethodChannel('alarmageddon/speech');
//   String _recognizedText = '';
//   String _germanSentence = '';
//   String _englishSentence = '';
//   final Map<String, String> _sentences = {
//     'Guten Morgen': 'Good morning',
//     'Wie geht es Ihnen': 'How are you',
//     'Ich liebe dich': 'I love you',
//     'Danke schön': 'Thank you very much',
//   };

//   @override
//   void initState() {
//     super.initState();
//     _selectRandomSentence();
//   }

//   void _selectRandomSentence() {
//     final random = Random();
//     final index = random.nextInt(_sentences.length);
//     setState(() {
//       _germanSentence = _sentences.keys.elementAt(index);
//       _englishSentence = _sentences.values.elementAt(index);
//       _recognizedText = '';
//     });
//   }

//   Future<void> _startListening() async {
//     try {
//       final result = await _speechChannel.invokeMethod<String>(
//         'startListening',
//         {'prompt': 'Speak: $_germanSentence', 'language': 'de-DE'},
//       );
//       if (result != null) {
//         setState(() {
//           _recognizedText = result;
//         });
//         if (_recognizedText.toLowerCase().trim() ==
//             _germanSentence.toLowerCase().trim()) {
//           widget.onSolved();
//         }
//       }
//     } on PlatformException catch (e) {
//       debugPrint('Speech error: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: Colors.black,
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const Text(
//               'Speak the German sentence:',
//               style: TextStyle(fontSize: 20, color: Colors.red),
//             ),
//             const SizedBox(height: 16),
//             Text(
//               _germanSentence,
//               style: const TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//             ),
//             Text(
//               'English: $_englishSentence',
//               style: const TextStyle(fontSize: 16, color: Colors.white70),
//             ),
//             const SizedBox(height: 24),
//             FloatingActionButton(
//               onPressed: _startListening,
//               child: const Icon(Icons.mic),
//             ),
//             const SizedBox(height: 16),
//             Text(
//               _recognizedText,
//               style: const TextStyle(fontSize: 18, color: Colors.white),
//             ),
//             const SizedBox(height: 8),
//             ElevatedButton(
//               onPressed: _selectRandomSentence,
//               child: const Text('New Sentence'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


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
  int _attemptsLeft = 3;
  bool _isListening = false;

  final Map<String, String> _sentences = {
    'Guten Morgen': 'Good morning',
    'Wie geht es Ihnen': 'How are you',
    'Ich liebe dich': 'I love you',
    'Danke schön': 'Thank you very much',
    'Wo ist der Bahnhof': 'Where is the train station',
    'Ich habe Hunger': 'I am hungry',
    'Ich bin müde': 'I am tired',
    'Heute ist ein schöner Tag': 'Today is a beautiful day',
    'Ich trinke Wasser': 'I drink water',
    'Ich lerne Deutsch': 'I am learning German',
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
      _attemptsLeft = 3;
    });
  }

  /// Normalize German text for comparison
  String _normalize(String input) {
    return input
        .toLowerCase()
        .replaceAll(RegExp(r'[^\w\säöüß]'), '') // remove punctuation except umlauts
        .replaceAll('ä', 'a')
        .replaceAll('ö', 'o')
        .replaceAll('ü', 'u')
        .replaceAll('ß', 'ss')
        .replaceAll(RegExp(r'\s+'), ' ') // normalize spaces
        .trim();
  }

  Future<void> _startListening() async {
    if (_isListening) return;
    setState(() => _isListening = true);

    try {
      final result = await _speechChannel.invokeMethod<String>(
        'startListening',
        {'prompt': 'Speak: $_germanSentence', 'language': 'de-DE'},
      );

      if (result != null) {
        final recognized = _normalize(result);
        final target = _normalize(_germanSentence);

        setState(() {
          _recognizedText = result;
        });

        // ✅ Check match within tolerance
        if (_compareStrings(recognized, target)) {
          setState(() => _isListening = false);
          widget.onSolved();
        } else {
          setState(() {
            _attemptsLeft--;
          });

          if (_attemptsLeft <= 0) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Too many failed attempts! Moving to next challenge."),
                backgroundColor: Colors.red,
              ),
            );
            widget.onSolved(); // trigger next challenge
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Incorrect. Try again ($_attemptsLeft left)."),
                backgroundColor: Colors.orange,
              ),
            );
          }
        }
      }
    } on PlatformException catch (e) {
      debugPrint('Speech error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Speech recognition failed."),
          backgroundColor: Colors.redAccent,
        ),
      );
    } finally {
      setState(() => _isListening = false);
    }
  }

  /// Compare strings with tolerance (allowing small mismatches)
  bool _compareStrings(String a, String b) {
    if (a == b) return true;
    // Allow small differences (Levenshtein distance <= 2)
    final dist = _levenshtein(a, b);
    return dist <= 2; // tolerate 2-character mismatch
  }

  int _levenshtein(String s, String t) {
    if (s == t) return 0;
    if (s.isEmpty) return t.length;
    if (t.isEmpty) return s.length;

    List<int> v0 = List<int>.generate(t.length + 1, (i) => i);
    List<int> v1 = List<int>.filled(t.length + 1, 0);

    for (int i = 0; i < s.length; i++) {
      v1[0] = i + 1;
      for (int j = 0; j < t.length; j++) {
        int cost = s[i] == t[j] ? 0 : 1;
        v1[j + 1] = [
          v1[j] + 1,
          v0[j + 1] + 1,
          v0[j] + cost,
        ].reduce((a, b) => a < b ? a : b);
      }
      List<int> temp = v0;
      v0 = v1;
      v1 = temp;
    }
    return v0[t.length];
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '🎤 Speak the German sentence:',
              style: TextStyle(fontSize: 20, color: Colors.redAccent),
            ),
            const SizedBox(height: 16),
            Text(
              _germanSentence,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              'English: $_englishSentence',
              style: const TextStyle(fontSize: 18, color: Colors.white70),
            ),
            const SizedBox(height: 24),
            FloatingActionButton(
              backgroundColor: _isListening ? Colors.grey : Colors.redAccent,
              onPressed: _isListening ? null : _startListening,
              child: const Icon(Icons.mic, size: 28),
            ),
            const SizedBox(height: 16),
            Text(
              _recognizedText.isNotEmpty ? 'You said: $_recognizedText' : '',
              style: const TextStyle(fontSize: 18, color: Colors.white),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _selectRandomSentence,
              child: const Text('New Sentence'),
            ),
            const SizedBox(height: 8),
            Text(
              'Attempts left: $_attemptsLeft',
              style: const TextStyle(fontSize: 16, color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }
}
