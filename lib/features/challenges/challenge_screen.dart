import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'math_challenge.dart';
import 'color_sequence_challenge.dart';
import 'speak_sentence_challenge.dart';

class ChallengeScreen extends StatefulWidget {
  final VoidCallback onSolved;

  const ChallengeScreen({super.key, required this.onSolved});

  @override
  State<ChallengeScreen> createState() => _ChallengeScreenState();
}

class _ChallengeScreenState extends State<ChallengeScreen> with WidgetsBindingObserver {
  final Random _random = Random();
  int _currentIndex = 0;
  int _challengeCount = 2;
  late List<Widget> _challengesQueue;
  bool _isBackgrounded = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initChallenges();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<void> _initChallenges() async {
    final prefs = await SharedPreferences.getInstance();
    _challengeCount = prefs.getInt('challengeCount') ?? 2;

    final challengeFactories = [
      () => MathChallenge(onSolved: _onChallengeSolved),
      () => ColorSequenceChallenge(onSolved: _onChallengeSolved),
      () => SpeakSentenceChallenge(onSolved: _onChallengeSolved),
    ];

    _challengesQueue = List.generate(
      _challengeCount,
      (_) => challengeFactories[_random.nextInt(challengeFactories.length)](),
    );

    setState(() {});
  }

  void _onChallengeSolved() {
    if (_currentIndex < _challengesQueue.length - 1) {
      setState(() => _currentIndex++);
    } else {
      widget.onSolved();
      Navigator.of(context).pop();
    }
  }

  // 🚫 Prevent minimize or background
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive ||
        state == AppLifecycleState.hidden) {
      _isBackgrounded = true;
      Future.delayed(const Duration(milliseconds: 800), () {
        if (_isBackgrounded) {
          // re-show challenge screen
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => ChallengeScreen(onSolved: widget.onSolved),
            ),
          );
        }
      });
    } else if (state == AppLifecycleState.resumed) {
      _isBackgrounded = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_challengesQueue.isEmpty) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator(color: Colors.redAccent)),
      );
    }

    return WillPopScope(
      onWillPop: () async => false, // disable back button
      child: Scaffold(
        appBar: AppBar(
          title: Text('Challenge ${_currentIndex + 1}/$_challengeCount'),
          automaticallyImplyLeading: false,
        ),
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (child, animation) =>
              FadeTransition(opacity: animation, child: child),
          child: Center(
            key: ValueKey(_currentIndex),
            child: _challengesQueue[_currentIndex],
          ),
        ),
      ),
    );
  }
}
