// // // import 'dart:math';
// // // import 'package:flutter/material.dart';

// // // class ColorSequenceChallenge extends StatefulWidget {
// // //   final VoidCallback onSolved;
// // //   const ColorSequenceChallenge({super.key, required this.onSolved});

// // //   @override
// // //   State<ColorSequenceChallenge> createState() => _ColorSequenceChallengeState();
// // // }

// // // class _ColorSequenceChallengeState extends State<ColorSequenceChallenge> {
// // //   final List<Color> _availableColors = [
// // //     Colors.red,
// // //     Colors.green,
// // //     Colors.blue,
// // //     Colors.orange,
// // //     Colors.purple,
// // //   ];

// // //   late List<Color> _sequence; // The correct sequence
// // //   late List<Color> _shuffledColors; // Displayed buttons
// // //   int _currentTapIndex = 0;

// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     _generateChallenge();
// // //   }

// // //   void _generateChallenge() {
// // //     _sequence = List<Color>.from(_availableColors)..shuffle();
// // //     _shuffledColors = List<Color>.from(_sequence)..shuffle();
// // //     _currentTapIndex = 0;
// // //   }

// // //   void _handleTap(Color color) {
// // //     if (color == _sequence[_currentTapIndex]) {
// // //       setState(() {
// // //         _currentTapIndex++;
// // //       });
// // //       if (_currentTapIndex == _sequence.length) {
// // //         widget.onSolved();
// // //       }
// // //     } else {
// // //       ScaffoldMessenger.of(context).showSnackBar(
// // //         const SnackBar(content: Text("Wrong order! Try again.")),
// // //       );
// // //       setState(() {
// // //         _currentTapIndex = 0;
// // //       });
// // //     }
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Column(
// // //       children: [
// // //         const SizedBox(height: 20),
// // //         const Text('Memorize the sequence:', style: TextStyle(fontSize: 18)),
// // //         const SizedBox(height: 10),
// // //         Row(
// // //           mainAxisAlignment: MainAxisAlignment.center,
// // //           children: _sequence.map((color) {
// // //             return Padding(
// // //               padding: const EdgeInsets.all(8.0),
// // //               child: CircleAvatar(backgroundColor: color, radius: 15),
// // //             );
// // //           }).toList(),
// // //         ),
// // //         const SizedBox(height: 30),
// // //         const Text('Tap in the same order:', style: TextStyle(fontSize: 16)),
// // //         const SizedBox(height: 10),
// // //         Wrap(
// // //           spacing: 15,
// // //           runSpacing: 15,
// // //           children: _shuffledColors.map((color) {
// // //             return GestureDetector(
// // //               onTap: () => _handleTap(color),
// // //               child: Container(
// // //                 width: 60,
// // //                 height: 60,
// // //                 decoration: BoxDecoration(
// // //                   color: color,
// // //                   shape: BoxShape.circle,
// // //                   border: Border.all(width: 2, color: Colors.black),
// // //                 ),
// // //               ),
// // //             );
// // //           }).toList(),
// // //         ),
// // //       ],
// // //     );
// // //   }
// // // }

// // import 'dart:math';
// // import 'package:flutter/material.dart';
// // import 'package:google_fonts/google_fonts.dart';
// // import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// // class ColorSequenceChallenge extends StatefulWidget {
// //   final VoidCallback onSolved;
// //   const ColorSequenceChallenge({super.key, required this.onSolved});

// //   @override
// //   State<ColorSequenceChallenge> createState() => _ColorSequenceChallengeState();
// // }

// // class _ColorSequenceChallengeState extends State<ColorSequenceChallenge> {
// //   final List<_NamedColor> _allColors = [
// //     _NamedColor("BLOOD", Colors.red.shade900),
// //     _NamedColor("SHADOW", const Color(0xFF39313A)),
// //     _NamedColor("BONE", Colors.white70),
// //     _NamedColor("POISON", Colors.green.shade700),
// //   ];

// //   late List<_NamedColor> _sequence;
// //   late List<_NamedColor> _shuffled;
// //   int _currentTap = 0;
// //   int _round = 1;
// //   static const int _totalRounds = 3;
// //   bool memorizing = true;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _newChallenge();
// //   }

// //   void _newChallenge() {
// //     setState(() {
// //       final rand = Random();
// //       final length = 3 + rand.nextInt(4); // random length between 3 and 6
// //       _sequence = List<_NamedColor>.generate(
// //         length,
// //         (_) => _allColors[rand.nextInt(_allColors.length)],
// //       );
// //       _shuffled = List<_NamedColor>.from(_allColors)..shuffle();
// //       _currentTap = 0;
// //       memorizing = true;
// //     });
// //     Future.delayed(const Duration(seconds: 2), () {
// //       setState(() => memorizing = false);
// //     });
// //   }

// //   void _handleTap(_NamedColor color) {
// //     if (memorizing) return;
// //     if (color == _sequence[_currentTap]) {
// //       setState(() {
// //         _currentTap++;
// //       });
// //       if (_currentTap == _sequence.length) {
// //         if (_round == _totalRounds) {
// //           widget.onSolved();
// //         } else {
// //           setState(() {
// //             _round++;
// //           });
// //           _newChallenge();
// //         }
// //       }
// //     } else {
// //       setState(() {
// //         _currentTap = 0;
// //         memorizing = true;
// //       });
// //       Future.delayed(const Duration(seconds: 2), () {
// //         setState(() => memorizing = false);
// //       });
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: const Color(0xFF170A1F),
// //       body: SafeArea(
// //         child: Center(
// //           child: SingleChildScrollView(
// //             child: Column(
// //               children: [
// //                 // Top bar (simulated app bar)
// //                 Container(
// //                   width: 320,
// //                   padding: const EdgeInsets.symmetric(
// //                     vertical: 10,
// //                     horizontal: 18,
// //                   ),
// //                   decoration: BoxDecoration(
// //                     color: Colors.black.withOpacity(0.91),
// //                     borderRadius: BorderRadius.circular(14),
// //                     boxShadow: [
// //                       BoxShadow(
// //                         color: Colors.redAccent.withOpacity(0.12),
// //                         blurRadius: 14,
// //                         offset: const Offset(0, 5),
// //                       ),
// //                     ],
// //                   ),
// //                   child: Row(
// //                     crossAxisAlignment: CrossAxisAlignment.center,
// //                     children: [
// //                       FaIcon(
// //                         FontAwesomeIcons.eye,
// //                         color: Colors.redAccent,
// //                         size: 20,
// //                       ),
// //                       const SizedBox(width: 10),
// //                       Text(
// //                         "MEMORY OF THE DAMNED",
// //                         style: GoogleFonts.orbitron(
// //                           color: Colors.redAccent,
// //                           fontWeight: FontWeight.bold,
// //                           fontSize: 17,
// //                           letterSpacing: 1.1,
// //                         ),
// //                       ),
// //                       const Spacer(),
// //                       ElevatedButton(
// //                         style: ElevatedButton.styleFrom(
// //                           backgroundColor: Colors.redAccent.shade700,
// //                           foregroundColor: Colors.white,
// //                           padding: const EdgeInsets.symmetric(
// //                             horizontal: 13,
// //                             vertical: 4,
// //                           ),
// //                           shape: RoundedRectangleBorder(
// //                             borderRadius: BorderRadius.circular(10),
// //                           ),
// //                         ),
// //                         onPressed: () {
// //                           setState(() => memorizing = true);
// //                           Future.delayed(const Duration(seconds: 2), () {
// //                             setState(() => memorizing = false);
// //                           });
// //                         },
// //                         child: Text(
// //                           'MEMORIZE...',
// //                           style: GoogleFonts.robotoMono(
// //                             fontSize: 13,
// //                             fontWeight: FontWeight.bold,
// //                           ),
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //                 const SizedBox(height: 13),

// //                 // Round Indicator
// //                 Container(
// //                   width: 320,
// //                   padding: const EdgeInsets.symmetric(
// //                     vertical: 6,
// //                     horizontal: 8,
// //                   ),
// //                   child: Row(
// //                     children: [
// //                       Text(
// //                         "ROUND $_round/$_totalRounds",
// //                         style: GoogleFonts.robotoMono(
// //                           color: Colors.redAccent,
// //                           fontWeight: FontWeight.bold,
// //                           fontSize: 13,
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ),

// //                 // Challenge Card
// //                 Container(
// //                   width: 320,
// //                   decoration: BoxDecoration(
// //                     gradient: LinearGradient(
// //                       colors: [
// //                         Colors.black.withOpacity(0.96),
// //                         Colors.red.shade900.withOpacity(0.83),
// //                       ],
// //                       begin: Alignment.topLeft,
// //                       end: Alignment.bottomRight,
// //                     ),
// //                     borderRadius: BorderRadius.circular(17),
// //                     boxShadow: [
// //                       BoxShadow(
// //                         color: Colors.redAccent.withOpacity(0.26),
// //                         blurRadius: 22,
// //                         offset: const Offset(0, 11),
// //                       ),
// //                     ],
// //                   ),
// //                   padding: const EdgeInsets.symmetric(
// //                     vertical: 25,
// //                     horizontal: 16,
// //                   ),
// //                   child: Column(
// //                     children: [
// //                       FaIcon(
// //                         FontAwesomeIcons.eye,
// //                         color: Colors.redAccent,
// //                         size: 28,
// //                       ),
// //                       const SizedBox(height: 16),
// //                       Text(
// //                         "Sequence Length: ${_sequence.length}",
// //                         style: GoogleFonts.orbitron(
// //                           color: Colors.white,
// //                           fontWeight: FontWeight.bold,
// //                           fontSize: 14,
// //                         ),
// //                       ),
// //                       const SizedBox(height: 3),
// //                       Text(
// //                         "Progress: $_currentTap/${_sequence.length}",
// //                         style: GoogleFonts.robotoMono(
// //                           color: Colors.redAccent,
// //                           fontWeight: FontWeight.w600,
// //                           fontSize: 13,
// //                         ),
// //                       ),
// //                       const SizedBox(height: 19),

// //                       // Button grid
// //                       Row(
// //                         mainAxisAlignment: MainAxisAlignment.center,
// //                         children: _allColors.map((namedColor) {
// //                           // Find display name and color from sequence
// //                           bool showActive = _shuffled.contains(namedColor);
// //                           return Padding(
// //                             padding: const EdgeInsets.symmetric(
// //                               horizontal: 7,
// //                               vertical: 2,
// //                             ),
// //                             child: GestureDetector(
// //                               onTap: showActive && !memorizing
// //                                   ? () => _handleTap(namedColor)
// //                                   : null,
// //                               child: Container(
// //                                 width: 72,
// //                                 height: 54,
// //                                 decoration: BoxDecoration(
// //                                   color: namedColor.color,
// //                                   borderRadius: BorderRadius.circular(12),
// //                                   border: Border.all(
// //                                     width: 2,
// //                                     color: Colors.redAccent,
// //                                   ),
// //                                   boxShadow: [
// //                                     BoxShadow(
// //                                       color: Colors.redAccent.withOpacity(0.14),
// //                                       blurRadius: 7,
// //                                       offset: const Offset(0, 3),
// //                                     ),
// //                                   ],
// //                                 ),
// //                                 child: Center(
// //                                   child: Text(
// //                                     namedColor.name,
// //                                     style: GoogleFonts.orbitron(
// //                                       color: namedColor.name == "BONE"
// //                                           ? Colors.black
// //                                           : Colors.white,
// //                                       fontWeight: FontWeight.bold,
// //                                       fontSize: 13,
// //                                       letterSpacing: 1,
// //                                     ),
// //                                   ),
// //                                 ),
// //                               ),
// //                             ),
// //                           );
// //                         }).toList(),
// //                       ),
// //                       const SizedBox(height: 25),
// //                       // Sequence bar (bottom progress, colored squares)
// //                       Wrap(
// //                         alignment: WrapAlignment.center,
// //                         spacing: 3,
// //                         children: _sequence.map((c) {
// //                           return Container(
// //                             width: 22,
// //                             height: 22,
// //                             margin: const EdgeInsets.symmetric(vertical: 2),
// //                             decoration: BoxDecoration(
// //                               color: c.color,
// //                               borderRadius: BorderRadius.circular(6),
// //                               border: Border.all(
// //                                 color: Colors.redAccent,
// //                                 width: 1.2,
// //                               ),
// //                             ),
// //                           );
// //                         }).toList(),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// // // Helper - name, color pair
// // class _NamedColor {
// //   final String name;
// //   final Color color;
// //   const _NamedColor(this.name, this.color);
// // }


// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// class ColorSequenceChallenge extends StatefulWidget {
//   final VoidCallback onSolved;
//   const ColorSequenceChallenge({super.key, required this.onSolved});

//   @override
//   State<ColorSequenceChallenge> createState() => _ColorSequenceChallengeState();
// }

// class _ColorSequenceChallengeState extends State<ColorSequenceChallenge> {
//   final List<_NamedColor> _colorOptions = [
//     _NamedColor("BLOOD", Colors.red.shade900),
//     _NamedColor("SHADOW", const Color(0xFF39313A)),
//     _NamedColor("BONE", Colors.grey.shade300),
//     _NamedColor("POISON", Colors.green.shade700),
//   ];

//   late List<_NamedColor> _sequence;
//   int _currentTap = 0;
//   int _round = 1;
//   static const int _totalRounds = 3;
//   bool _showSequence = true;

//   @override
//   void initState() {
//     super.initState();
//     _generateNewRound();
//   }

//   void _generateNewRound() {
//     _currentTap = 0;
//     _showSequence = true;
//     final random = DateTime.now().millisecondsSinceEpoch;
//     _sequence = List<_NamedColor>.generate(
//       3 + (random % 2), // length 3 or 4 for variability
//       (index) => _colorOptions[random % _colorOptions.length],
//     );
//     Future.delayed(const Duration(seconds: 5), () {
//       setState(() {
//         _showSequence = false;
//       });
//     });
//   }

//   void _handleTap(_NamedColor color) {
//     if (_showSequence) return; // Don't accept input while showing sequence
//     if (color == _sequence[_currentTap]) {
//       setState(() {
//         _currentTap++;
//       });
//       if (_currentTap >= _sequence.length) {
//         if (_round >= _totalRounds) {
//           widget.onSolved();
//         } else {
//           setState(() {
//             _round++;
//           });
//           _generateNewRound();
//         }
//       }
//     } else {
//       setState(() {
//         _currentTap = 0;
//         _showSequence = true;
//       });
//       Future.delayed(const Duration(seconds: 5), () {
//         setState(() {
//           _showSequence = false;
//         });
//       });
//     }
//   }

//   Widget _buildColorButton(_NamedColor c) {
//     return GestureDetector(
//       onTap: () => _handleTap(c),
//       child: Container(
//         width: 140,
//         height: 80,
//         decoration: BoxDecoration(
//           color: c.color,
//           borderRadius: BorderRadius.circular(18),
//           border: Border.all(color: Colors.redAccent, width: 1.5),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.redAccent.withOpacity(0.14),
//               blurRadius: 12,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Center(
//           child: Text(
//             c.name,
//             style: GoogleFonts.orbitron(
//                 color: c.name == "BONE" ? Colors.black87 : Colors.white,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 18,
//                 letterSpacing: 1.4),
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final cardWidth = screenWidth * 0.9 > 320 ? 320 : screenWidth * 0.9;

//     return Scaffold(
//       backgroundColor: const Color(0xFF170A1F),
//       body: SafeArea(
//         child: Center(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(vertical: 24),
//             child: Column(
//               children: [
//                 // Title & subtitles
//                 Container(
//                   width: cardWidth.toDouble(),
//                   padding: const EdgeInsets.symmetric(vertical: 4),
//                   child: Column(
//                     children: [
//                       Text(
//                         "MEMORY OF THE DAMNED",
//                         style: GoogleFonts.orbitron(
//                           color: Colors.redAccent,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 22,
//                           letterSpacing: 1.3,
//                         ),
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         "Remember the sequence to survive",
//                         style: GoogleFonts.robotoMono(
//                           color: Colors.white70,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 14,
//                           letterSpacing: 1,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 18),

//                 // Round and Memorize... Card
//                 Container(
//                   width: cardWidth.toDouble(),
//                   padding:
//                       const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
//                   decoration: BoxDecoration(
//                     color: Colors.black.withOpacity(0.92),
//                     borderRadius: BorderRadius.circular(15),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.redAccent.withOpacity(0.25),
//                         blurRadius: 13,
//                         offset: const Offset(0, 5),
//                       ),
//                     ],
//                   ),
//                   child: Row(
//                     children: [
//                       Text(
//                         "ROUND $_round/$_totalRounds",
//                         style: GoogleFonts.robotoMono(
//                           color: Colors.redAccent,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 14,
//                         ),
//                       ),
//                       const Spacer(),
//                       ElevatedButton(
//                         onPressed: () {
//                           setState(() {
//                             _showSequence = true;
//                           });
//                           Future.delayed(const Duration(seconds: 5), () {
//                             setState(() => _showSequence = false);
//                           });
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.redAccent.shade700,
//                           foregroundColor: Colors.white,
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 10, vertical: 6),
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(10)),
//                         ),
//                         child: Text(
//                           "MEMORIZE...",
//                           style: GoogleFonts.robotoMono(
//                             fontSize: 13,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//                 const SizedBox(height: 20),

//                 // Eye Icon
//                 FaIcon(
//                   FontAwesomeIcons.eye,
//                   color: Colors.redAccent,
//                   size: 30,
//                 ),
//                 const SizedBox(height: 12),

//                 // Sequence Length and Progress
//                 Container(
//                   width: cardWidth.toDouble(),
//                   padding:
//                       const EdgeInsets.symmetric(vertical: 2, horizontal: 12),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "Sequence Length: ${_sequence.length}",
//                         style: GoogleFonts.orbitron(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 15,
//                         ),
//                       ),
//                       const SizedBox(height: 6),
//                       Text(
//                         "Progress: $_currentTap/${_sequence.length}",
//                         style: GoogleFonts.robotoMono(
//                           color: Colors.redAccent,
//                           fontWeight: FontWeight.w600,
//                           fontSize: 14,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//                 const SizedBox(height: 26),

//                 // Color Buttons 2x2 Grid
//                 Container(
//                   width: cardWidth.toDouble(),
//                   padding: const EdgeInsets.symmetric(horizontal: 14),
//                   child: Wrap(
//                     spacing: 18,
//                     runSpacing: 14,
//                     children:
//                         _colorOptions.map((color) => _buildColorButton(color)).toList(),
//                   ),
//                 ),

//                 const SizedBox(height: 26),

//                 // Sequence card showing colors for 5 seconds
//                 if (_showSequence)
//                   Container(
//                     width: cardWidth.toDouble(),
//                     padding: const EdgeInsets.symmetric(
//                         vertical: 13, horizontal: 16),
//                     decoration: BoxDecoration(
//                       color: Colors.black.withOpacity(0.92),
//                       borderRadius: BorderRadius.circular(16),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.redAccent.withOpacity(0.3),
//                           blurRadius: 12,
//                           offset: const Offset(0, 6),
//                         ),
//                       ],
//                     ),
//                     child: Wrap(
//                       spacing: 9,
//                       children: _sequence.map((c) {
//                         return Container(
//                           width: 36,
//                           height: 36,
//                           margin: const EdgeInsets.symmetric(vertical: 5),
//                           decoration: BoxDecoration(
//                             color: c.color,
//                             borderRadius: BorderRadius.circular(6),
//                             border: Border.all(color: Colors.redAccent, width: 1.5),
//                           ),
//                         );
//                       }).toList(),
//                     ),
//                   ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _NamedColor {
//   final String name;
//   final Color color;
//   const _NamedColor(this.name, this.color);

//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is _NamedColor &&
//           runtimeType == other.runtimeType &&
//           name == other.name &&
//           color == other.color;

//   @override
//   int get hashCode => name.hashCode ^ color.hashCode;
// }


import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ColorSequenceChallenge extends StatefulWidget {
  final VoidCallback onSolved;
  const ColorSequenceChallenge({super.key, required this.onSolved});

  @override
  State<ColorSequenceChallenge> createState() => _ColorSequenceChallengeState();
}

class _ColorSequenceChallengeState extends State<ColorSequenceChallenge> {
  final List<_NamedColor> _allColors = [
    _NamedColor("BLOOD", Colors.red.shade900),
    _NamedColor("SHADOW", const Color(0xFF39313A)),
    _NamedColor("BONE", Colors.white70),
    _NamedColor("POISON", Colors.green.shade700),
  ];

  late List<_NamedColor> _sequence;
  int _currentTap = 0;
  int _round = 1;
  static const int _totalRounds = 3;
  bool memorizing = true;

  @override
  void initState() {
    super.initState();
    _newChallenge();
  }

  void _newChallenge() {
    setState(() {
      final rand = Random();
      final length = 3 + rand.nextInt(4); // random length 3–6
      _sequence = List<_NamedColor>.generate(
        length,
        (_) => _allColors[rand.nextInt(_allColors.length)],
      );
      _currentTap = 0;
      memorizing = true;
    });
    Future.delayed(const Duration(seconds: 5), () {
      setState(() => memorizing = false);
    });
  }

  void _handleTap(_NamedColor color) {
    if (memorizing) return;
    if (color == _sequence[_currentTap]) {
      setState(() {
        _currentTap++;
      });
      if (_currentTap == _sequence.length) {
        if (_round == _totalRounds) {
          widget.onSolved();
        } else {
          setState(() => _round++);
          _newChallenge();
        }
      }
    } else {
      setState(() {
        _currentTap = 0;
        memorizing = true;
      });
      Future.delayed(const Duration(seconds: 5), () {
        setState(() => memorizing = false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF170A1F),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Title
              Text(
                "MEMORY OF THE DAMNED",
                style: GoogleFonts.orbitron(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                "Remember the sequence to survive",
                style: GoogleFonts.robotoMono(
                  color: Colors.white70,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 20),

              // Round + Memorize row inside a card
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.85),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.redAccent, width: 1),
                ),
                child: Row(
                  children: [
                    Text(
                      "ROUND $_round/$_totalRounds",
                      style: GoogleFonts.robotoMono(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent.shade700,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        setState(() => memorizing = true);
                        Future.delayed(const Duration(seconds: 5), () {
                          setState(() => memorizing = false);
                        });
                      },
                      child: Text(
                        "MEMORIZE...",
                        style: GoogleFonts.robotoMono(fontSize: 13),
                      ),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Eye + stats
              FaIcon(FontAwesomeIcons.eye, color: Colors.redAccent, size: 28),
              const SizedBox(height: 10),
              Text(
                "Sequence Length: ${_sequence.length}",
                style: GoogleFonts.orbitron(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                "Progress: $_currentTap/${_sequence.length}",
                style: GoogleFonts.robotoMono(
                  color: Colors.redAccent,
                  fontSize: 13,
                ),
              ),

              const SizedBox(height: 24),

              // 2x2 Color grid
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  children: _allColors.map((namedColor) {
                    return GestureDetector(
                      onTap: memorizing ? null : () => _handleTap(namedColor),
                      child: Container(
                        decoration: BoxDecoration(
                          color: namedColor.color,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.redAccent, width: 2),
                        ),
                        child: Center(
                          child: Text(
                            namedColor.name,
                            style: GoogleFonts.orbitron(
                              color: namedColor.name == "BONE"
                                  ? Colors.black
                                  : Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 20),

              // Sequence display card (only during memorization)
              if (memorizing)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.redAccent, width: 1.5),
                  ),
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 6,
                    runSpacing: 6,
                    children: _sequence
                        .map((c) => Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                color: c.color,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: Colors.redAccent,
                                  width: 1.2,
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NamedColor {
  final String name;
  final Color color;
  const _NamedColor(this.name, this.color);
}
