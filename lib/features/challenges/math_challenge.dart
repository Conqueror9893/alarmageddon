// // // // import 'dart:math';
// // // // import 'package:flutter/material.dart';

// // // // class MathChallenge extends StatefulWidget {
// // // //   final VoidCallback onSolved;
// // // //   const MathChallenge({super.key, required this.onSolved});

// // // //   @override
// // // //   State<MathChallenge> createState() => _MathChallengeState();
// // // // }

// // // // class _MathChallengeState extends State<MathChallenge> {
// // // //   late int a;
// // // //   late int b;
// // // //   late String op;
// // // //   late int answer;
// // // //   final TextEditingController _controller = TextEditingController();
// // // //   String? _error;

// // // //   @override
// // // //   void initState() {
// // // //     super.initState();
// // // //     final rand = Random();
// // // //     a = rand.nextInt(50) + 1;
// // // //     b = rand.nextInt(50) + 1;
// // // //     if (rand.nextBool()) {
// // // //       op = '+';
// // // //       answer = a + b;
// // // //     } else {
// // // //       op = '-';
// // // //       // Ensure no negative answers
// // // //       if (a < b) {
// // // //         final tmp = a;
// // // //         a = b;
// // // //         b = tmp;
// // // //       }
// // // //       answer = a - b;
// // // //     }
// // // //   }

// // // //   void _checkAnswer() {
// // // //     if (int.tryParse(_controller.text) == answer) {
// // // //       widget.onSolved();
// // // //     } else {
// // // //       setState(() {
// // // //         _error = 'Wrong answer! Try again.';
// // // //       });
// // // //     }
// // // //   }

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Card(
// // // //       color: Colors.black,
// // // //       child: Padding(
// // // //         padding: const EdgeInsets.all(16.0),
// // // //         child: Column(
// // // //           mainAxisSize: MainAxisSize.min,
// // // //           children: [
// // // //             Text(
// // // //               'Solve: $a $op $b = ?',
// // // //               style: const TextStyle(fontSize: 24, color: Colors.red),
// // // //             ),
// // // //             const SizedBox(height: 16),
// // // //             TextField(
// // // //               controller: _controller,
// // // //               keyboardType: TextInputType.number,
// // // //               style: const TextStyle(color: Colors.white),
// // // //               decoration: InputDecoration(
// // // //                 labelText: 'Your answer',
// // // //                 labelStyle: const TextStyle(color: Colors.white70),
// // // //                 errorText: _error,
// // // //                 enabledBorder: const OutlineInputBorder(
// // // //                   borderSide: BorderSide(color: Colors.red),
// // // //                 ),
// // // //                 focusedBorder: const OutlineInputBorder(
// // // //                   borderSide: BorderSide(color: Colors.deepOrange),
// // // //                 ),
// // // //               ),
// // // //               onSubmitted: (_) => _checkAnswer(),
// // // //             ),
// // // //             const SizedBox(height: 16),
// // // //             ElevatedButton(
// // // //               onPressed: _checkAnswer,
// // // //               child: const Text('Submit'),
// // // //             ),
// // // //           ],
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }
// // // // }

// // // import 'dart:async';
// // // import 'dart:math';

// // // import 'package:flutter/material.dart';
// // // import 'package:google_fonts/google_fonts.dart';

// // // class MathChallenge extends StatefulWidget {
// // //   final VoidCallback onSolved;
// // //   const MathChallenge({super.key, required this.onSolved});

// // //   @override
// // //   State<MathChallenge> createState() => _MathChallengeState();
// // // }

// // // class _MathChallengeState extends State<MathChallenge> {
// // //   late int a;
// // //   late int b;
// // //   late String op;
// // //   late int answer;
// // //   String input = '';
// // //   String? _error;
// // //   double timeLeft = 60;
// // //   Timer? timer;

// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     final rand = Random();
// // //     a = rand.nextInt(50) + 1;
// // //     b = rand.nextInt(50) + 1;
// // //     if (rand.nextBool()) {
// // //       op = '+';
// // //       answer = a + b;
// // //     } else {
// // //       op = '-';
// // //       if (a < b) {
// // //         final tmp = a;
// // //         a = b;
// // //         b = tmp;
// // //       }
// // //       answer = a - b;
// // //     }
// // //     timer = Timer.periodic(const Duration(seconds: 1), (t) {
// // //       setState(() {
// // //         timeLeft--;
// // //         if (timeLeft <= 0) {
// // //           t.cancel();
// // //           _error = 'Time\'s up!';
// // //         }
// // //       });
// // //     });
// // //   }

// // //   @override
// // //   void dispose() {
// // //     timer?.cancel();
// // //     super.dispose();
// // //   }

// // //   void _onKeyTap(String value) {
// // //     if (_error != null) return;
// // //     setState(() {
// // //       if (value == 'CLEAR') {
// // //         input = '';
// // //       } else if (value == 'SUBMIT') {
// // //         if (input.isEmpty) return;
// // //         if (int.tryParse(input) == answer) {
// // //           widget.onSolved();
// // //         } else {
// // //           _error = 'Wrong answer! Try again.';
// // //         }
// // //       } else {
// // //         // Limit input to 6 digits
// // //         if (input.length < 6) input += value;
// // //       }
// // //     });
// // //   }

// // //   Widget _buildKey(String symbol, {double? width}) {
// // //     final bool isAction = symbol == 'CLEAR' || symbol == 'SUBMIT';
// // //     return SizedBox(
// // //       width: width ?? 64,
// // //       height: 48,
// // //       child: ElevatedButton(
// // //         style: ElevatedButton.styleFrom(
// // //           backgroundColor: isAction
// // //               ? (symbol == 'SUBMIT'
// // //                   ? Colors.red.shade700
// // //                   : Colors.red.shade900)
// // //               : Colors.black.withOpacity(0.65),
// // //           foregroundColor: Colors.white,
// // //           shape: RoundedRectangleBorder(
// // //             borderRadius: BorderRadius.circular(9),
// // //             side: BorderSide(
// // //                 color: Colors.redAccent.withOpacity(0.7), width: 1.2),
// // //           ),
// // //           elevation: isAction ? 6 : 2,
// // //           textStyle: GoogleFonts.orbitron(fontSize: 22, letterSpacing: 1),
// // //         ),
// // //         onPressed: () => _onKeyTap(symbol),
// // //         child: Text(
// // //           symbol,
// // //           style: GoogleFonts.orbitron(
// // //             color: isAction ? Colors.white : Colors.redAccent,
// // //             fontWeight: FontWeight.bold,
// // //             fontSize: isAction ? 17 : 22,
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       backgroundColor: const Color(0xFF170A17),
// // //       body: Center(
// // //         child: Container(
// // //           width: 350,
// // //           decoration: BoxDecoration(
// // //             gradient: LinearGradient(
// // //               colors: [
// // //                 Colors.black.withOpacity(0.93),
// // //                 Colors.red.shade900.withOpacity(0.85)
// // //               ],
// // //               begin: Alignment.topLeft,
// // //               end: Alignment.bottomRight,
// // //             ),
// // //             borderRadius: BorderRadius.circular(20),
// // //             boxShadow: [
// // //               BoxShadow(
// // //                 color: Colors.redAccent.withOpacity(0.3),
// // //                 blurRadius: 40,
// // //                 spreadRadius: 4,
// // //               ),
// // //             ],
// // //           ),
// // //           child: Padding(
// // //             padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
// // //             child: Column(
// // //               mainAxisSize: MainAxisSize.min,
// // //               children: [
// // //                 // Header
// // //                 Row(
// // //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //                   children: [
// // //                     Text(
// // //                       "MATHEMATICAL TORMENT",
// // //                       style: GoogleFonts.orbitron(
// // //                         color: Colors.redAccent,
// // //                         fontWeight: FontWeight.bold,
// // //                         fontSize: 15,
// // //                         letterSpacing: 1.2,
// // //                       ),
// // //                     ),
// // //                     const Icon(Icons.calculate_rounded,
// // //                         color: Colors.redAccent, size: 26),
// // //                   ],
// // //                 ),
// // //                 const SizedBox(height: 12),
// // //                 // Timer bar
// // //                 Stack(
// // //                   children: [
// // //                     Container(
// // //                       height: 12,
// // //                       decoration: BoxDecoration(
// // //                         color: Colors.red.shade900,
// // //                         borderRadius: BorderRadius.circular(6),
// // //                       ),
// // //                     ),
// // //                     AnimatedContainer(
// // //                       duration: const Duration(milliseconds: 250),
// // //                       height: 12,
// // //                       width: max(0, (timeLeft / 60 * 320)),
// // //                       decoration: BoxDecoration(
// // //                         color: Colors.redAccent,
// // //                         borderRadius: BorderRadius.circular(6),
// // //                       ),
// // //                     ),
// // //                   ],
// // //                 ),
// // //                 Align(
// // //                   alignment: Alignment.topRight,
// // //                   child: Padding(
// // //                     padding: const EdgeInsets.only(top: 2.5, right: 2.5),
// // //                     child: Text(
// // //                       "${timeLeft.ceil()}s",
// // //                       style: GoogleFonts.robotoMono(
// // //                         color: Colors.white,
// // //                         fontWeight: FontWeight.bold,
// // //                         fontSize: 13,
// // //                       ),
// // //                     ),
// // //                   ),
// // //                 ),
// // //                 const SizedBox(height: 20),
// // //                 // Equation
// // //                 Text(
// // //                   "$a $op $b = ?",
// // //                   style: GoogleFonts.orbitron(
// // //                     color: Colors.white,
// // //                     fontWeight: FontWeight.bold,
// // //                     fontSize: 27,
// // //                   ),
// // //                 ),
// // //                 const SizedBox(height: 22),
// // //                 // Input box
// // //                 Container(
// // //                   width: 120,
// // //                   padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
// // //                   decoration: BoxDecoration(
// // //                       color: Colors.black.withOpacity(0.8),
// // //                       borderRadius: BorderRadius.circular(10),
// // //                       border: Border.all(color: Colors.redAccent, width: 2),
// // //                       boxShadow: [
// // //                         BoxShadow(
// // //                             color: Colors.red.shade900.withOpacity(0.13),
// // //                             blurRadius: 5)
// // //                       ]),
// // //                   child: Center(
// // //                     child: Text(
// // //                       input.isEmpty ? '____' : input,
// // //                       style: GoogleFonts.orbitron(
// // //                         color: Colors.white,
// // //                         fontSize: 28,
// // //                         fontWeight: FontWeight.bold,
// // //                         letterSpacing: 4,
// // //                       ),
// // //                     ),
// // //                   ),
// // //                 ),
// // //                 if (_error != null) ...[
// // //                   const SizedBox(height: 10),
// // //                   Text(_error!,
// // //                       style: const TextStyle(
// // //                           color: Colors.redAccent, fontWeight: FontWeight.bold)),
// // //                 ],
// // //                 const SizedBox(height: 22),
// // //                 // Keypad
// // //                 ...[
// // //                   ["1", "2", "3"],
// // //                   ["4", "5", "6"],
// // //                   ["7", "8", "9"],
// // //                   ["CLEAR", "0", "SUBMIT"]
// // //                 ].map((row) => Padding(
// // //                       padding: const EdgeInsets.symmetric(vertical: 3),
// // //                       child: Row(
// // //                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// // //                         children: row
// // //                             .map((symbol) => _buildKey(symbol,
// // //                                 width: symbol.length > 1 ? 81 : 64))
// // //                             .toList(),
// // //                       ),
// // //                     )),
// // //               ],
// // //             ),
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }

// // import 'dart:async';
// // import 'dart:math';
// // import 'package:flutter/material.dart';
// // import 'package:google_fonts/google_fonts.dart';

// // class MathChallenge extends StatefulWidget {
// //   final VoidCallback onSolved;
// //   const MathChallenge({super.key, required this.onSolved});

// //   @override
// //   State<MathChallenge> createState() => _MathChallengeState();
// // }

// // class _MathChallengeState extends State<MathChallenge> {
// //   late int a;
// //   late int b;
// //   late String op;
// //   late int answer;
// //   String input = '';
// //   String? _error;
// //   double timeLeft = 60;
// //   Timer? timer;

// //   @override
// //   void initState() {
// //     super.initState();
// //     final rand = Random();
// //     a = rand.nextInt(50) + 1;
// //     b = rand.nextInt(50) + 1;
// //     if (rand.nextBool()) {
// //       op = '+';
// //       answer = a + b;
// //     } else {
// //       op = '-';
// //       if (a < b) {
// //         final tmp = a;
// //         a = b;
// //         b = tmp;
// //       }
// //       answer = a - b;
// //     }
// //     timer = Timer.periodic(const Duration(seconds: 1), (t) {
// //       setState(() {
// //         timeLeft--;
// //         if (timeLeft < 0) {
// //           t.cancel();
// //           timeLeft = 0;
// //           _error = 'Time\'s up!';
// //         }
// //       });
// //     });
// //   }

// //   @override
// //   void dispose() {
// //     timer?.cancel();
// //     super.dispose();
// //   }

// //   void _onKeyTap(String value) {
// //     setState(() {
// //       if (value == 'CLEAR') {
// //         input = '';
// //         _error = null;
// //       } else if (value == 'SUBMIT') {
// //         if (input.isEmpty) return;
// //         if (int.tryParse(input) == answer) {
// //           widget.onSolved();
// //         } else {
// //           _error = 'Wrong answer! Try again.';
// //         }
// //       } else {
// //         if (input.length < 6) input += value;
// //         _error = null;
// //       }
// //     });
// //   }

// //   Widget _buildKey(String symbol) {
// //     final bool isAction = symbol == 'CLEAR' || symbol == 'SUBMIT';
// //     return Expanded(
// //       flex: symbol == '0' ? 2 : 1,
// //       child: Padding(
// //         padding: const EdgeInsets.all(4.0),
// //         child: ElevatedButton(
// //           style: ElevatedButton.styleFrom(
// //             backgroundColor: isAction
// //                 ? (symbol == 'SUBMIT'
// //                     ? Colors.red.shade700
// //                     : Colors.red.shade900)
// //                 : Colors.transparent,
// //             foregroundColor: Colors.white,
// //             shape: RoundedRectangleBorder(
// //               borderRadius: BorderRadius.circular(10),
// //               side: BorderSide(
// //                 color: isAction
// //                     ? Colors.redAccent.withOpacity(0.6)
// //                     : Colors.redAccent.withOpacity(0.4),
// //                 width: 1.4,
// //               ),
// //             ),
// //             elevation: 0,
// //             textStyle: GoogleFonts.orbitron(fontSize: 22, letterSpacing: 1),
// //           ),
// //           onPressed: () => _onKeyTap(symbol),
// //           child: Text(
// //             symbol,
// //             style: GoogleFonts.orbitron(
// //               color: isAction ? Colors.white : Colors.redAccent,
// //               fontWeight: FontWeight.bold,
// //               fontSize: isAction ? 15 : 22,
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: const Color(0xFF0A0104),
// //       body: SafeArea(
// //         child: Center(
// //           child: SingleChildScrollView(
// //             child: Column(
// //               children: [
// //                 // Timer Card
// //                 Container(
// //                   width: 320,
// //                   margin: const EdgeInsets.only(bottom: 18, top: 22),
// //                   decoration: BoxDecoration(
// //                     color: Colors.black.withOpacity(0.91),
// //                     borderRadius: BorderRadius.circular(16),
// //                     boxShadow: [
// //                       BoxShadow(
// //                         color: Colors.redAccent.withOpacity(0.22),
// //                         blurRadius: 22,
// //                         spreadRadius: 1,
// //                         offset: const Offset(0, 5),
// //                       ),
// //                     ],
// //                   ),
// //                   padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
// //                   child: Column(
// //                     children: [
// //                       Row(
// //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                         children: [
// //                           Text(
// //                             "MATHEMATICAL TORMENT",
// //                             style: GoogleFonts.orbitron(
// //                               color: Colors.redAccent,
// //                               fontWeight: FontWeight.bold,
// //                               fontSize: 15,
// //                               letterSpacing: 1.2,
// //                             ),
// //                           ),
// //                           Text(
// //                             "${timeLeft.ceil()}s",
// //                             style: GoogleFonts.robotoMono(
// //                               color: Colors.redAccent,
// //                               fontWeight: FontWeight.bold,
// //                               fontSize: 15,
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                       const SizedBox(height: 8),
// //                       Stack(
// //                         children: [
// //                           Container(
// //                             height: 9,
// //                             decoration: BoxDecoration(
// //                               color: Colors.red.shade900,
// //                               borderRadius: BorderRadius.circular(9),
// //                             ),
// //                           ),
// //                           AnimatedContainer(
// //                             duration: const Duration(milliseconds: 250),
// //                             height: 9,
// //                             width: max(0, (timeLeft / 60 * 288)),
// //                             decoration: BoxDecoration(
// //                               color: Colors.redAccent,
// //                               borderRadius: BorderRadius.circular(9),
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //                 // Main Card
// //                 Container(
// //                   width: 320,
// //                   margin: const EdgeInsets.only(bottom: 16),
// //                   decoration: BoxDecoration(
// //                     color: Colors.black.withOpacity(0.91),
// //                     borderRadius: BorderRadius.circular(18),
// //                     boxShadow: [
// //                       BoxShadow(
// //                         color: Colors.redAccent.withOpacity(0.26),
// //                         blurRadius: 28,
// //                         spreadRadius: 1,
// //                         offset: const Offset(0, 9),
// //                       ),
// //                     ],
// //                   ),
// //                   padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 24),
// //                   child: Column(
// //                     children: [
// //                       const Icon(Icons.calculate_rounded,
// //                           color: Colors.redAccent, size: 32),
// //                       const SizedBox(height: 13),
// //                       Text(
// //                         "$a $op $b = ?",
// //                         style: GoogleFonts.orbitron(
// //                           color: Colors.white,
// //                           fontWeight: FontWeight.bold,
// //                           fontSize: 28,
// //                         ),
// //                       ),
// //                       const SizedBox(height: 22),
// //                       Container(
// //                         width: 130,
// //                         padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 9),
// //                         decoration: BoxDecoration(
// //                           color: Colors.black,
// //                           borderRadius: BorderRadius.circular(12),
// //                           border: Border.all(color: Colors.redAccent, width: 2),
// //                           boxShadow: [
// //                             BoxShadow(
// //                               color: Colors.red.shade900.withOpacity(0.13),
// //                               blurRadius: 7,
// //                             ),
// //                           ],
// //                         ),
// //                         child: Center(
// //                           child: Text(
// //                             input.isEmpty ? '____' : input,
// //                             style: GoogleFonts.orbitron(
// //                               color: Colors.white,
// //                               fontSize: 27,
// //                               fontWeight: FontWeight.bold,
// //                               letterSpacing: 4,
// //                             ),
// //                           ),
// //                         ),
// //                       ),
// //                       if (_error != null) ...[
// //                         const SizedBox(height: 10),
// //                         Text(_error!,
// //                             style: const TextStyle(
// //                               color: Colors.redAccent,
// //                               fontWeight: FontWeight.bold,
// //                             )),
// //                       ],
// //                     ],
// //                   ),
// //                 ),
// //                 // Keypad Card
// //                 Container(
// //                   width: 320,
// //                   decoration: BoxDecoration(
// //                     color: Colors.black.withOpacity(0.945),
// //                     borderRadius: BorderRadius.circular(18),
// //                     boxShadow: [
// //                       BoxShadow(
// //                         color: Colors.redAccent.withOpacity(0.15),
// //                         blurRadius: 24,
// //                         spreadRadius: 1,
// //                         offset: const Offset(0, 11),
// //                       ),
// //                     ],
// //                   ),
// //                   padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
// //                   child: Column(
// //                     children: [
// //                       Row(
// //                         children: [
// //                           _buildKey('1'),
// //                           _buildKey('2'),
// //                           _buildKey('3'),
// //                         ],
// //                       ),
// //                       Row(
// //                         children: [
// //                           _buildKey('4'),
// //                           _buildKey('5'),
// //                           _buildKey('6'),
// //                         ],
// //                       ),
// //                       Row(
// //                         children: [
// //                           _buildKey('7'),
// //                           _buildKey('8'),
// //                           _buildKey('9'),
// //                         ],
// //                       ),
// //                       Row(
// //                         children: [
// //                           _buildKey('CLEAR'),
// //                           _buildKey('0'),
// //                           _buildKey('SUBMIT'),
// //                         ],
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

// import 'dart:async';
// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// class MathChallenge extends StatefulWidget {
//   final VoidCallback onSolved;
//   const MathChallenge({super.key, required this.onSolved});

//   @override
//   State<MathChallenge> createState() => _MathChallengeState();
// }

// class _MathChallengeState extends State<MathChallenge> {
//   late int a;
//   late int b;
//   late String op;
//   late int answer;
//   String input = '';
//   String? _error;
//   double timeLeft = 60;
//   Timer? timer;

//   @override
//   void initState() {
//     super.initState();
//     final rand = Random();
//     a = rand.nextInt(50) + 1;
//     b = rand.nextInt(50) + 1;
//     if (rand.nextBool()) {
//       op = '+';
//       answer = a + b;
//     } else {
//       op = '-';
//       if (a < b) {
//         final tmp = a;
//         a = b;
//         b = tmp;
//       }
//       answer = a - b;
//     }
//     timer = Timer.periodic(const Duration(seconds: 1), (t) {
//       setState(() {
//         timeLeft--;
//         if (timeLeft < 0) {
//           t.cancel();
//           timeLeft = 0;
//           _error = 'Time\'s up!';
//         }
//       });
//     });
//   }

//   @override
//   void dispose() {
//     timer?.cancel();
//     super.dispose();
//   }

//   void _onKeyTap(String value) {
//     setState(() {
//       if (value == 'CLEAR') {
//         input = '';
//         _error = null;
//       } else if (value == 'SUBMIT') {
//         if (input.isEmpty) return;
//         if (int.tryParse(input) == answer) {
//           widget.onSolved();
//         } else {
//           _error = 'Wrong answer! Try again.';
//         }
//       } else {
//         if (input.length < 6) input += value;
//         _error = null;
//       }
//     });
//   }

//   Widget _buildKey(String symbol) {
//     final bool isAction = symbol == 'CLEAR' || symbol == 'SUBMIT';
//     return Expanded(
//       flex: symbol == '0' ? 2 : 1,
//       child: Padding(
//         padding: const EdgeInsets.all(4.0),
//         child: ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: isAction
//                 ? (symbol == 'SUBMIT'
//                     ? Colors.red.shade700
//                     : Colors.red.shade900)
//                 : Colors.transparent,
//             foregroundColor: Colors.white,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10),
//               side: BorderSide(
//                 color: isAction
//                     ? Colors.redAccent.withOpacity(0.7)
//                     : Colors.redAccent.withOpacity(0.4),
//                 width: 1.4,
//               ),
//             ),
//             elevation: 0,
//             textStyle: GoogleFonts.orbitron(fontSize: 22, letterSpacing: 1),
//           ),
//           onPressed: () => _onKeyTap(symbol),
//           child: Text(
//             symbol,
//             style: GoogleFonts.orbitron(
//               color: isAction ? Colors.white : Colors.redAccent,
//               fontWeight: FontWeight.bold,
//               fontSize: isAction ? 15 : 22,
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF0A0104),
//       body: SafeArea(
//         child: Center(
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 // Title and subtitle row with skull
//                 Padding(
//                   padding: const EdgeInsets.only(top: 18, bottom: 8),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       FaIcon(
//                         FontAwesomeIcons.skull,
//                         color: Colors.redAccent,
//                         size: 22,
//                       ),
//                       const SizedBox(width: 10),
//                       Text(
//                         "MATHEMATICAL TORMENT",
//                         style: GoogleFonts.orbitron(
//                           color: Colors.redAccent,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 18,
//                           letterSpacing: 1.3,
//                           shadows: [
//                             Shadow(
//                               color: Colors.red.shade900,
//                               blurRadius: 8,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Text(
//                   "Solve to escape the nightmare",
//                   style: GoogleFonts.robotoMono(
//                     color: Colors.white70,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 13,
//                     letterSpacing: 1,
//                   ),
//                 ),
//                 const SizedBox(height: 18),

//                 // Timer Card (Card 1)
//                 Container(
//                   width: 320,
//                   margin: const EdgeInsets.only(bottom: 18),
//                   decoration: BoxDecoration(
//                     color: Colors.black.withOpacity(0.93),
//                     borderRadius: BorderRadius.circular(15),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.redAccent.withOpacity(0.25),
//                         blurRadius: 16,
//                         offset: const Offset(0, 5),
//                       ),
//                     ],
//                   ),
//                   padding:
//                       const EdgeInsets.symmetric(vertical: 13, horizontal: 22),
//                   child: Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             "TIME REMAINING",
//                             style: GoogleFonts.robotoMono(
//                               color: Colors.redAccent,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 14,
//                             ),
//                           ),
//                           Text(
//                             "${timeLeft.ceil()}s",
//                             style: GoogleFonts.orbitron(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 16,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 7),
//                       Stack(
//                         children: [
//                           Container(
//                             height: 9,
//                             decoration: BoxDecoration(
//                               color: Colors.red.shade900,
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                           ),
//                           AnimatedContainer(
//                             duration: const Duration(milliseconds: 250),
//                             height: 9,
//                             width: max(0, (timeLeft / 60 * 251)),
//                             decoration: BoxDecoration(
//                               color: Colors.redAccent,
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),

//                 // Challenge Card: icon, question, answer, keypad (Card 2)
//                 Container(
//                   width: 320,
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [
//                         Colors.black.withOpacity(0.96),
//                         Colors.red.shade900.withOpacity(0.82)
//                       ],
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomRight,
//                     ),
//                     borderRadius: BorderRadius.circular(18),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.redAccent.withOpacity(0.29),
//                         blurRadius: 25,
//                         offset: const Offset(0, 8),
//                       ),
//                     ],
//                   ),
//                   padding:
//                       const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
//                   child: Column(
//                     children: [
//                       const SizedBox(height: 3),
//                       Icon(Icons.calculate_rounded,
//                           color: Colors.redAccent, size: 30),
//                       const SizedBox(height: 13),
//                       Text(
//                         "$a $op $b = ?",
//                         style: GoogleFonts.orbitron(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 27,
//                         ),
//                       ),
//                       const SizedBox(height: 20),
//                       Container(
//                         width: 120,
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 18, vertical: 10),
//                         decoration: BoxDecoration(
//                           color: Colors.black.withOpacity(0.93),
//                           borderRadius: BorderRadius.circular(11),
//                           border:
//                               Border.all(color: Colors.redAccent, width: 1.8),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.red.shade900.withOpacity(0.12),
//                               blurRadius: 7,
//                             ),
//                           ],
//                         ),
//                         child: Center(
//                           child: Text(
//                             input.isEmpty ? '__' : input,
//                             style: GoogleFonts.orbitron(
//                               color: Colors.white,
//                               fontSize: 25,
//                               fontWeight: FontWeight.bold,
//                               letterSpacing: 3.7,
//                             ),
//                           ),
//                         ),
//                       ),
//                       if (_error != null) ...[
//                         const SizedBox(height: 9),
//                         Text(_error!,
//                             style: const TextStyle(
//                               color: Colors.redAccent,
//                               fontWeight: FontWeight.bold,
//                             )),
//                       ],
//                       const SizedBox(height: 21),
//                       // Keypad
//                       Container(
//                         decoration: BoxDecoration(
//                           color: Colors.black.withOpacity(0.95),
//                           borderRadius: BorderRadius.circular(14),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.redAccent.withOpacity(0.14),
//                               blurRadius: 14,
//                               offset: const Offset(0, 7),
//                             ),
//                           ],
//                         ),
//                         padding: const EdgeInsets.all(12),
//                         child: Column(
//                           children: [
//                             Row(
//                               children: [
//                                 _buildKey('1'),
//                                 _buildKey('2'),
//                                 _buildKey('3'),
//                               ],
//                             ),
//                             Row(
//                               children: [
//                                 _buildKey('4'),
//                                 _buildKey('5'),
//                                 _buildKey('6'),
//                               ],
//                             ),
//                             Row(
//                               children: [
//                                 _buildKey('7'),
//                                 _buildKey('8'),
//                                 _buildKey('9'),
//                               ],
//                             ),
//                             Row(
//                               children: [
//                                 _buildKey('CLEAR'),
//                                 _buildKey('0'),
//                                 _buildKey('SUBMIT'),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MathChallenge extends StatefulWidget {
  final VoidCallback onSolved;
  const MathChallenge({super.key, required this.onSolved});

  @override
  State<MathChallenge> createState() => _MathChallengeState();
}

class _MathChallengeState extends State<MathChallenge> {
  late int a;
  late int b;
  late String op;
  late int answer;
  String input = '';
  String? _error;
  double timeLeft = 15; // set timer to 15 seconds
  Timer? timer;

  @override
  void initState() {
    super.initState();
    _generateNewQuestion();
    _startTimer();
  }

  void _generateNewQuestion() {
    final rand = Random();

    // Use different ranges depending on operation
    final opIndex = rand.nextInt(4); // 0 = +, 1 = -, 2 = ×, 3 = ÷

    if (opIndex == 0) {
      // Addition
      a = rand.nextInt(50) + 1;
      b = rand.nextInt(50) + 1;
      op = '+';
      answer = a + b;
    } else if (opIndex == 1) {
      // Subtraction
      a = rand.nextInt(50) + 1;
      b = rand.nextInt(50) + 1;
      if (a < b) {
        final tmp = a;
        a = b;
        b = tmp;
      }
      op = '-';
      answer = a - b;
    } else if (opIndex == 2) {
      // Multiplication (small numbers only)
      a = rand.nextInt(12) + 1;
      b = rand.nextInt(12) + 1;
      op = '×';
      answer = a * b;
    } else {
      // Division (clean integer division, no fractions)
      b = rand.nextInt(11) + 2; // avoid 0 & 1
      answer = rand.nextInt(12) + 1; // keep quotient small
      a = b * answer; // ensures clean division
      op = '÷';
    }

    timeLeft = 15;
    input = '';
    _error = null;
  }

  void _startTimer() {
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      setState(() {
        timeLeft--;
        if (timeLeft < 0) {
          t.cancel();
          // new question on timeout
          _generateNewQuestion();
          _startTimer();
        }
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void _onKeyTap(String value) {
    setState(() {
      if (value == 'CLEAR') {
        input = '';
        _error = null;
      } else if (value == 'SUBMIT') {
        if (input.isEmpty) return;
        if (int.tryParse(input) == answer) {
          widget.onSolved();
        } else {
          _error = 'Wrong answer! Try again.';
        }
      } else {
        if (input.length < 6) input += value;
        _error = null;
      }
    });
  }

  Widget _buildKey(String symbol) {
    final bool isAction = symbol == 'CLEAR' || symbol == 'SUBMIT';
    return Expanded(
      flex: symbol == '0' ? 2 : 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 2.5),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: Size(
              0,
              isAction ? 34 : 48,
            ), // Decrease button height for actions
            backgroundColor: isAction
                ? (symbol == 'SUBMIT'
                      ? Colors.red.shade700
                      : Colors.red.shade900)
                : Colors.transparent,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(
                color: isAction
                    ? Colors.redAccent.withOpacity(0.7)
                    : Colors.redAccent.withOpacity(0.4),
                width: 1.1,
              ),
            ),
            elevation: 0,
            padding: const EdgeInsets.symmetric(vertical: 2),
            textStyle: GoogleFonts.orbitron(
              fontSize: isAction ? 12 : 20, // Decreased font for actions
              letterSpacing: 1,
            ),
          ),
          onPressed: () => _onKeyTap(symbol),
          child: Text(
            symbol,
            style: GoogleFonts.orbitron(
              color: isAction ? Colors.white : Colors.redAccent,
              fontWeight: FontWeight.w600,
              fontSize: isAction ? 12 : 20, // Decreased font for actions
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0104),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Title and subtitle row with skull
                Padding(
                  padding: const EdgeInsets.only(top: 18, bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.skull,
                        color: Colors.redAccent,
                        size: 22,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "MATHEMATICAL TORMENT",
                        style: GoogleFonts.orbitron(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          letterSpacing: 1.3,
                          shadows: [
                            Shadow(color: Colors.red.shade900, blurRadius: 8),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  "Solve to escape the nightmare",
                  style: GoogleFonts.robotoMono(
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 18),

                // Timer Card (Card 1)
                Container(
                  width: 320,
                  margin: const EdgeInsets.only(bottom: 18),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.93),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.redAccent.withOpacity(0.25),
                        blurRadius: 16,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 13,
                    horizontal: 22,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "TIME REMAINING",
                            style: GoogleFonts.robotoMono(
                              color: Colors.redAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            "${timeLeft.ceil()}s",
                            style: GoogleFonts.orbitron(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 7),
                      Stack(
                        children: [
                          Container(
                            height: 9,
                            decoration: BoxDecoration(
                              color: Colors.red.shade900,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            height: 9,
                            width: max(0, (timeLeft / 15 * 251)),
                            decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Challenge Card: icon, question, answer, keypad (Card 2)
                Container(
                  width: 320,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.96),
                        Colors.red.shade900.withOpacity(0.82),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.redAccent.withOpacity(0.29),
                        blurRadius: 25,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 18,
                    horizontal: 18,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 3),
                      Icon(
                        Icons.calculate_rounded,
                        color: Colors.redAccent,
                        size: 30,
                      ),
                      const SizedBox(height: 13),
                      Text(
                        "$a $op $b = ?",
                        style: GoogleFonts.orbitron(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 27,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: 180, // wider for the answer box
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.93),
                          borderRadius: BorderRadius.circular(11),
                          border: Border.all(
                            color: Colors.redAccent,
                            width: 1.8,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.red.shade900.withOpacity(0.12),
                              blurRadius: 7,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            input.isEmpty ? '____' : input,
                            style: GoogleFonts.orbitron(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 3.7,
                            ),
                          ),
                        ),
                      ),
                      if (_error != null) ...[
                        const SizedBox(height: 9),
                        Text(
                          _error!,
                          style: const TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                      const SizedBox(height: 21),
                      // Keypad
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.95),
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.redAccent.withOpacity(0.14),
                              blurRadius: 14,
                              offset: const Offset(0, 7),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(7),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                _buildKey('1'),
                                _buildKey('2'),
                                _buildKey('3'),
                              ],
                            ),
                            Row(
                              children: [
                                _buildKey('4'),
                                _buildKey('5'),
                                _buildKey('6'),
                              ],
                            ),
                            Row(
                              children: [
                                _buildKey('7'),
                                _buildKey('8'),
                                _buildKey('9'),
                              ],
                            ),
                            Row(
                              children: [
                                _buildKey('CLEAR'),
                                _buildKey('0'),
                                _buildKey('SUBMIT'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
