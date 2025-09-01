// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:alarmageddon/features/alarms/alarm_list_screen.dart';
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     // Navigate after 3.5 seconds to AlarmListScreen
//     Timer(const Duration(milliseconds: 3500), () {
//       // Use navigatorKey to navigate if needed:
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (_) => const AlarmListScreen()),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF1E0D13),
//       body: Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             FaIcon(
//               FontAwesomeIcons.skull,
//               size: 80,
//               color: Colors.redAccent.shade400,
//               shadows: [Shadow(color: Colors.red.shade900, blurRadius: 20)],
//             ),
//             const SizedBox(height: 20),
//             Text(
//               "ALARMAGEDDON",
//               style: GoogleFonts.orbitron(
//                 fontSize: 32,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.redAccent.shade200,
//                 letterSpacing: 4,
//                 shadows: [Shadow(color: Colors.red.shade900, blurRadius: 12)],
//               ),
//             ),
//             const SizedBox(height: 10),
//             Text(
//               "Your mortal timekeeper",
//               style: GoogleFonts.robotoMono(
//                 fontSize: 14,
//                 color: Colors.white70,
//                 fontWeight: FontWeight.w500,
//                 letterSpacing: 1,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:alarmageddon/features/alarms/alarm_list_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _iconController;
  late Animation<double> _iconGlowAnimation;

  late AnimationController _titleController;
  late Animation<double> _titleFadeAnimation;
  late Animation<double> _titleScaleAnimation;

  late AnimationController _subtitleController;
  late Animation<double> _subtitleFadeAnimation;
  late Animation<Offset> _subtitleSlideAnimation;

  @override
  void initState() {
    super.initState();

    // Icon pulse animation controller
    _iconController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _iconGlowAnimation = Tween<double>(begin: 5, end: 20).animate(
      CurvedAnimation(parent: _iconController, curve: Curves.easeInOut),
    );

    // Title fade and scale animation
    _titleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _titleFadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _titleController, curve: Curves.easeIn));
    _titleScaleAnimation = Tween<double>(begin: 0.8, end: 1).animate(
      CurvedAnimation(parent: _titleController, curve: Curves.easeOutBack),
    );

    // Subtitle fade and slide animation
    _subtitleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _subtitleFadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _subtitleController, curve: Curves.easeIn),
    );
    _subtitleSlideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
          CurvedAnimation(parent: _subtitleController, curve: Curves.easeOut),
        );

    // Start animations with a delay between them
    _titleController.forward().whenComplete(() {
      _subtitleController.forward();
    });

    // Navigate after 3.5 seconds to AlarmListScreen
    Timer(const Duration(milliseconds: 3500), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const AlarmListScreen()),
      );
    });
  }

  @override
  void dispose() {
    _iconController.dispose();
    _titleController.dispose();
    _subtitleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E0D13),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedBuilder(
              animation: _iconGlowAnimation,
              builder: (context, child) {
                return FaIcon(
                  FontAwesomeIcons.skull,
                  size: 80,
                  color: const Color.fromARGB(255, 255, 0, 51),
                  shadows: [
                    BoxShadow(
                      color: Colors.red.shade900,
                      blurRadius: _iconGlowAnimation.value,
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 20),
            AnimatedBuilder(
              animation: _titleController,
              builder: (context, child) {
                return Opacity(
                  opacity: _titleFadeAnimation.value,
                  child: Transform.scale(
                    scale: _titleScaleAnimation.value,
                    child: Text(
                      "ALARMAGEDDON",
                      style: GoogleFonts.orbitron(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent.shade200,
                        letterSpacing: 4,
                        shadows: [
                          Shadow(color: Colors.red.shade900, blurRadius: 12),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
            SlideTransition(
              position: _subtitleSlideAnimation,
              child: FadeTransition(
                opacity: _subtitleFadeAnimation,
                child: Text(
                  "Your mortal timekeeper",
                  style: GoogleFonts.robotoMono(
                    fontSize: 14,
                    color: Colors.white70,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
