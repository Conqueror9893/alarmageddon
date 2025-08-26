// // import 'package:flutter/material.dart';
// // import 'alarm_storage.dart';
// // import 'alarm_edit_screen.dart';
// // import 'alarm_model.dart';
// // import 'package:hive_flutter/hive_flutter.dart';
// // import 'alarm_test_button.dart';
// // import 'alarm_callback.dart';
// // import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';

// // class AlarmListScreen extends StatelessWidget {
// //   const AlarmListScreen({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: const Text('Alarmageddon')),
// //       body: Column(
// //         children: [
// //           ElevatedButton(
// //             onPressed: () {
// //               AndroidAlarmManager.oneShot(
// //                 const Duration(seconds: 5),
// //                 1, // Use unique ID
// //                 alarmCallback,
// //                 exact: true,
// //                 wakeup: true,
// //                 rescheduleOnReboot: true,
// //               );
// //             },
// //             child: Text("Test Alarm"),
// //           ),
// //           const Padding(padding: EdgeInsets.all(8.0), child: AlarmTestButton()),
// //           Expanded(
// //             child: ValueListenableBuilder(
// //               valueListenable: Hive.box<Alarm>(
// //                 AlarmStorage.boxName,
// //               ).listenable(),
// //               builder: (context, Box<Alarm> box, _) {
// //                 if (box.values.isEmpty) {
// //                   return const Center(child: Text('No alarms yet!'));
// //                 }
// //                 final alarms = box.values.toList();
// //                 return ListView.builder(
// //                   itemCount: alarms.length,
// //                   itemBuilder: (context, index) {
// //                     final alarm = alarms[index];
// //                     return ListTile(
// //                       leading: Icon(
// //                         alarm.enabled ? Icons.alarm_on : Icons.alarm_off,
// //                         color: alarm.enabled ? Colors.red : Colors.grey,
// //                       ),
// //                       title: Text(
// //                         alarm.label.isNotEmpty ? alarm.label : 'Alarm',
// //                         style: const TextStyle(color: Colors.white),
// //                       ),
// //                       subtitle: Text(
// //                         '${alarm.time.hour.toString().padLeft(2, '0')}:${alarm.time.minute.toString().padLeft(2, '0')} - ${_recurrenceString(alarm.recurrence)}',
// //                         style: const TextStyle(color: Colors.white70),
// //                       ),
// //                       trailing: Switch(
// //                         value: alarm.enabled,
// //                         onChanged: (val) {
// //                           alarm.enabled = val;
// //                           AlarmStorage.update(alarm);
// //                         },
// //                         activeColor: Colors.red,
// //                       ),
// //                       onLongPress: () async {
// //                         await AlarmStorage.delete(alarm.id);
// //                       },
// //                       onTap: () {
// //                         Navigator.of(context).push(
// //                           MaterialPageRoute(
// //                             builder: (_) => AlarmEditScreen(alarm: alarm),
// //                           ),
// //                         );
// //                       },
// //                     );
// //                   },
// //                 );
// //               },
// //             ),
// //           ),
// //         ],
// //       ),
// //       floatingActionButton: FloatingActionButton(
// //         onPressed: () {
// //           Navigator.of(
// //             context,
// //           ).push(MaterialPageRoute(builder: (_) => const AlarmEditScreen()));
// //         },
// //         child: const Icon(Icons.add_alarm),
// //       ),
// //     );
// //   }

// //   String _recurrenceString(List<int> recurrence) {
// //     if (recurrence.isEmpty) return 'One-time';
// //     const days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
// //     return recurrence.map((i) => days[i % 7]).join(', ');
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'alarm_storage.dart';
// import 'alarm_edit_screen.dart';
// import 'alarm_model.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'alarm_test_button.dart';
// import 'alarm_callback.dart';
// import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';

// class AlarmListScreen extends StatelessWidget {
//   const AlarmListScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // Main background gradient
//     return Scaffold(
//       backgroundColor: const Color(0xFF1E0D13),
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [Color(0xFF170A15), Color(0xFF260D18)],
//           ),
//         ),
//         child: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 // Title area
//                 Padding(
//                   padding: const EdgeInsets.only(top: 8),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'ALARMAGEDDON',
//                         style: GoogleFonts.orbitron(
//                           fontSize: 22,
//                           color: Colors.redAccent.shade200,
//                           fontWeight: FontWeight.bold,
//                           letterSpacing: 2.5,
//                           shadows: [
//                             Shadow(
//                               color: Colors.red.shade900,
//                               blurRadius: 12,
//                             ),
//                           ],
//                         ),
//                       ),
//                       Text(
//                         'Your mortal timekeeper',
//                         style: GoogleFonts.robotoMono(
//                           fontSize: 12,
//                           color: Colors.white70,
//                           fontWeight: FontWeight.w500,
//                           letterSpacing: 1.2,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 14),
//                 // Clock & date
//                 Container(
//                   padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
//                   decoration: BoxDecoration(
//                     color: Color(0xFF251117),
//                     borderRadius: BorderRadius.circular(14),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.red.withOpacity(0.2),
//                         blurRadius: 10,
//                         offset: const Offset(0, 4),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     children: [
//                       Text(
//                         _getTimeString(),
//                         style: GoogleFonts.orbitron(
//                           fontSize: 32,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                           letterSpacing: 3,
//                           shadows: [
//                             Shadow(
//                               color: Colors.red.shade600,
//                               blurRadius: 8,
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         _getDateString(),
//                         style: GoogleFonts.robotoMono(
//                           fontSize: 14,
//                           color: Colors.redAccent.shade200,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 18),
//                 // Alarm Challenges Card
//                 Container(
//                   decoration: BoxDecoration(
//                     color: Colors.red.shade900.withOpacity(0.35),
//                     borderRadius: BorderRadius.circular(18),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.redAccent.withOpacity(0.3),
//                         blurRadius: 10,
//                         offset: const Offset(0, 2),
//                       ),
//                     ],
//                   ),
//                   padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "TEST ALARM CHALLENGES",
//                         style: GoogleFonts.robotoMono(
//                           color: Colors.redAccent,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 14,
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           _ChallengeButton(label: "MATHEMATICAL TORMENT"),
//                           _ChallengeButton(label: "MEMORY OF THE DAMNED"),
//                           _ChallengeButton(label: "PROOF OF CONSCIOUSNESS"),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 18),
//                 // Alarms List + Add Alarm
//                 Expanded(
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Color(0xFF251117),
//                       borderRadius: BorderRadius.circular(18),
//                     ),
//                     padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
//                     child: ValueListenableBuilder(
//                       valueListenable: Hive.box<Alarm>(AlarmStorage.boxName).listenable(),
//                       builder: (context, Box<Alarm> box, _) {
//                         final alarms = box.values.toList();
//                         return Column(
//                           crossAxisAlignment: CrossAxisAlignment.stretch,
//                           children: [
//                             Row(
//                               children: [
//                                 Text(
//                                   'ALARMS ',
//                                   style: GoogleFonts.orbitron(
//                                     fontSize: 15,
//                                     color: Colors.redAccent,
//                                     fontWeight: FontWeight.bold,
//                                     letterSpacing: 1.5,
//                                   ),
//                                 ),
//                                 Text(
//                                   '(${alarms.length} active)',
//                                   style: TextStyle(color: Colors.white70, fontSize: 12),
//                                 ),
//                                 const Spacer(),
//                                 ElevatedButton.icon(
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: Colors.redAccent,
//                                     foregroundColor: Colors.white,
//                                     shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.circular(12)),
//                                     padding: const EdgeInsets.symmetric(
//                                         vertical: 8, horizontal: 8),
//                                   ),
//                                   onPressed: () {
//                                     Navigator.of(context).push(MaterialPageRoute(
//                                         builder: (_) => const AlarmEditScreen()));
//                                   },
//                                   icon: const Icon(Icons.add_alarm, size: 18),
//                                   label: const Text("ADD ALARM",
//                                       style: TextStyle(fontWeight: FontWeight.w600)),
//                                 ),
//                               ],
//                             ),
//                             const Divider(color: Colors.redAccent, height: 20),
//                             Expanded(
//                               child: alarms.isEmpty
//                                   ? Center(
//                                       child: Text('No alarms yet!',
//                                           style: TextStyle(
//                                               color: Colors.white60,
//                                               fontStyle: FontStyle.italic)),
//                                     )
//                                   : ListView.builder(
//                                       itemCount: alarms.length,
//                                       itemBuilder: (context, index) {
//                                         final alarm = alarms[index];
//                                         return _AlarmTile(alarm: alarm);
//                                       },
//                                     ),
//                             ),
//                           ],
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   // Fake clock time UI (replace with actual state/time logic if needed)
//   static String _getTimeString() {
//     final now = DateTime.now();
//     final hour = now.hour > 12 ? now.hour - 12 : now.hour;
//     final minute = now.minute.toString().padLeft(2, '0');
//     final ampm = now.hour >= 12 ? 'PM' : 'AM';
//     return '$hour:$minute $ampm';
//   }

//   static String _getDateString() {
//     final now = DateTime.now();
//     final days = [
//       "Sunday",
//       "Monday",
//       "Tuesday",
//       "Wednesday",
//       "Thursday",
//       "Friday",
//       "Saturday"
//     ];
//     final dayName = days[now.weekday % 7];
//     final date = "${now.day}".padLeft(2, "0");
//     final month = "${now.month}".padLeft(2, "0");
//     return "$dayName, $month/$date";
//   }
// }

// // --------- Challenge Buttons ---------
// class _ChallengeButton extends StatelessWidget {
//   final String label;
//   const _ChallengeButton({required this.label});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 3),
//       decoration: BoxDecoration(
//         color: Colors.red.shade700.withOpacity(0.8),
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.redAccent.withOpacity(0.8),
//             blurRadius: 10,
//             spreadRadius: 0,
//           ),
//         ],
//       ),
//       padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 9),
//       child: Text(
//         label,
//         textAlign: TextAlign.center,
//         style: GoogleFonts.orbitron(
//           color: Colors.white,
//           fontWeight: FontWeight.bold,
//           fontSize: 11,
//           letterSpacing: 1.2,
//         ),
//       ),
//     );
//   }
// }

// // --------- Alarm ListTile ---------
// class _AlarmTile extends StatelessWidget {
//   final Alarm alarm;
//   const _AlarmTile({required this.alarm});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 7),
//       decoration: BoxDecoration(
//         color: Colors.red.shade900.withOpacity(0.4),
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.redAccent.withOpacity(0.2),
//             blurRadius: 8,
//           ),
//         ],
//       ),
//       child: ListTile(
//         leading: Icon(
//           alarm.enabled ? Icons.alarm_on : Icons.alarm_off,
//           color: alarm.enabled ? Colors.redAccent : Colors.grey.shade700,
//         ),
//         title: Text(
//           alarm.label.isNotEmpty ? alarm.label : 'Alarm',
//           style: GoogleFonts.orbitron(
//               color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
//         ),
//         subtitle: Row(
//           children: [
//             Text(
//               '${alarm.time.hour.toString().padLeft(2, '0')}:${alarm.time.minute.toString().padLeft(2, '0')} ',
//               style: GoogleFonts.robotoMono(
//                   color: Colors.redAccent.shade100, fontSize: 13),
//             ),
//             ..._buildDaysPills(alarm.recurrence),
//           ],
//         ),
//         trailing: Switch(
//           value: alarm.enabled,
//           onChanged: (val) {
//             alarm.enabled = val;
//             AlarmStorage.update(alarm);
//           },
//           activeColor: Colors.redAccent,
//         ),
//         onLongPress: () async {
//           await AlarmStorage.delete(alarm.id);
//         },
//         onTap: () {
//           Navigator.of(context).push(
//             MaterialPageRoute(
//               builder: (_) => AlarmEditScreen(alarm: alarm),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   List<Widget> _buildDaysPills(List<int> recurrence) {
//     if (recurrence.isEmpty) {
//       return [
//         Container(
//           margin: const EdgeInsets.only(left: 6),
//           padding:
//               const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
//           decoration: BoxDecoration(
//             color: Colors.red.shade900,
//             borderRadius: BorderRadius.circular(7),
//           ),
//           child: Text(
//             'Once',
//             style: TextStyle(color: Colors.white, fontSize: 9),
//           ),
//         ),
//       ];
//     }
//     const days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
//     return recurrence
//         .map(
//           (i) => Container(
//             margin: const EdgeInsets.only(left: 5),
//             padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
//             decoration: BoxDecoration(
//               color: Colors.red.shade800,
//               borderRadius: BorderRadius.circular(7),
//             ),
//             child: Text(
//               days[i % 7],
//               style: const TextStyle(color: Colors.white, fontSize: 10),
//             ),
//           ),
//         )
//         .toList();
//   }
// }

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'alarm_storage.dart';
import 'alarm_edit_screen.dart';
import 'alarm_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AlarmListScreen extends StatefulWidget {
  const AlarmListScreen({Key? key}) : super(key: key);

  @override
  State<AlarmListScreen> createState() => _AlarmListScreenState();
}

class _AlarmListScreenState extends State<AlarmListScreen> {
  ThemeMode _themeMode = ThemeMode.dark;

  void _openSettings() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1E0D13),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Settings",
              style: GoogleFonts.orbitron(
                color: Colors.redAccent,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Theme", style: TextStyle(color: Colors.white)),
                DropdownButton<ThemeMode>(
                  value: _themeMode,
                  dropdownColor: Color(0xFF3C1432),
                  items: const [
                    DropdownMenuItem(
                      value: ThemeMode.light,
                      child: Text("Light"),
                    ),
                    DropdownMenuItem(
                      value: ThemeMode.dark,
                      child: Text("Dark"),
                    ),
                  ],
                  style: const TextStyle(color: Colors.white),
                  onChanged: (mode) {
                    if (mode != null) {
                      setState(() => _themeMode = mode);
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 20,
                ),
              ),
              onPressed: () {
                // Insert test alarm call here
                // AndroidAlarmManager.oneShot(...);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Test alarm triggered (not implemented)"),
                  ),
                );
              },
              icon: const Icon(Icons.notifications_active),
              label: const Text("Test Alarm"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: _themeMode,
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF1E0D13),
      ),
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: Scaffold(
        backgroundColor: const Color(0xFF1E0D13),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header with skull and settings
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          // Skull Icon (FontAwesomeIcons.skull or SVG)
                          const FaIcon(
                            FontAwesomeIcons.skull,
                            color: Colors.redAccent,
                            size: 26,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'ALARMAGEDDON',
                            style: GoogleFonts.orbitron(
                              fontSize: 22,
                              color: Colors.redAccent.shade200,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2.5,
                              shadows: [
                                Shadow(
                                  color: Colors.red.shade900,
                                  blurRadius: 12,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.settings,
                          color: Colors.redAccent,
                        ),
                        onPressed: _openSettings,
                        tooltip: "Settings",
                      ),
                    ],
                  ),
                ),
                Text(
                  'Your mortal timekeeper',
                  style: GoogleFonts.robotoMono(
                    fontSize: 12,
                    color: Colors.white70,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 15),

                // Clock Digital Card
                _RedCard(
                  child: Column(
                    children: [
                      Text(
                        _getTimeString(),
                        style: GoogleFonts.orbitron(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 4,
                          shadows: [
                            Shadow(color: Colors.red.shade600, blurRadius: 7),
                          ],
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        _getDateString(),
                        style: GoogleFonts.robotoMono(
                          fontSize: 15,
                          color: Colors.redAccent.shade200,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                // Alarm Challenge Card, VERTICAL stack
                _RedCard(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "TEST ALARM CHALLENGES",
                        style: GoogleFonts.robotoMono(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "Try the challenges that activate when alarms ring",
                        style: GoogleFonts.robotoMono(
                          color: Colors.white70,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(height: 13),
                      _ChallengeCardButton(
                        label: "MATHEMATICAL TORMENT",
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/mathematical_torment',
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      _ChallengeCardButton(
                        label: "MEMORY OF THE DAMNED",
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/memory_of_the_damned',
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      _ChallengeCardButton(
                        label: "THE CURSED UTTERANCE",
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/the_cursed_utterance',
                          );
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                // ALARMS Card List
                Expanded(
                  child: _RedCard(
                    padding: const EdgeInsets.fromLTRB(8, 12, 8, 10),
                    child: ValueListenableBuilder(
                      valueListenable: Hive.box<Alarm>(
                        AlarmStorage.boxName,
                      ).listenable(),
                      builder: (context, Box<Alarm> box, _) {
                        final alarms = box.values.toList();
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'ALARMS ',
                                  style: GoogleFonts.orbitron(
                                    fontSize: 15,
                                    color: Colors.redAccent,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1,
                                  ),
                                ),
                                Text(
                                  '(${alarms.length} active)',
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                                ),
                                const Spacer(),
                                ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.redAccent,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 8,
                                      horizontal: 9,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (_) => const AlarmEditScreen(),
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.add_alarm, size: 18),
                                  label: const Text(
                                    "ADD ALARM",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Divider(
                              color: Colors.redAccent,
                              height: 16,
                              thickness: 1.2,
                            ),
                            Expanded(
                              child: alarms.isEmpty
                                  ? Center(
                                      child: Text(
                                        'No alarms yet!',
                                        style: TextStyle(color: Colors.white60),
                                      ),
                                    )
                                  : ListView.builder(
                                      itemCount: alarms.length,
                                      itemBuilder: (context, index) {
                                        final alarm = alarms[index];
                                        return _AlarmTile(alarm: alarm);
                                      },
                                    ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static String _getTimeString() {
    final now = DateTime.now();
    final hour = now.hour > 12 ? now.hour - 12 : now.hour;
    final minute = now.minute.toString().padLeft(2, '0');
    final ampm = now.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $ampm';
  }

  static String _getDateString() {
    final now = DateTime.now();
    final days = [
      "Sunday",
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday",
    ];
    final dayName = days[now.weekday % 7];
    final date = "${now.day}".padLeft(2, "0");
    final month = "${now.month}".padLeft(2, "0");
    return "$dayName, $month/$date";
  }
}

// --------- Card UI wrapper ---------
class _RedCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  const _RedCard({required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.5),
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF181218).withOpacity(0.94),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.redAccent.withOpacity(0.5),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.redAccent.withOpacity(0.13),
            blurRadius: 20,
            offset: Offset(0, 7),
          ),
        ],
      ),
      child: child,
    );
  }
}

// --------- Large Challenge Vertical Card ---------
class _ChallengeCardButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _ChallengeCardButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      // Use InkWell if inside Material
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14),
        margin: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          color: Colors.redAccent.shade700,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.redAccent.withOpacity(0.4),
              blurRadius: 10,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Text(
            label,
            style: GoogleFonts.orbitron(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 13,
              letterSpacing: 1,
            ),
          ),
        ),
      ),
    );
  }
}

// --------- Alarm ListTile ---------
class _AlarmTile extends StatelessWidget {
  final Alarm alarm;
  const _AlarmTile({required this.alarm});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 7),
      decoration: BoxDecoration(
        color: Color(0xFF2D1423).withOpacity(0.95),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.redAccent.withOpacity(0.5),
          width: 1.15,
        ),
        boxShadow: [
          BoxShadow(color: Colors.redAccent.withOpacity(0.15), blurRadius: 16),
        ],
      ),
      child: ListTile(
        minLeadingWidth: 20,
        leading: Icon(
          alarm.enabled ? Icons.alarm_on : Icons.alarm_off,
          color: alarm.enabled ? Colors.redAccent : Colors.grey.shade700,
        ),
        title: Text(
          alarm.label.isNotEmpty ? alarm.label : 'Alarm',
          style: GoogleFonts.orbitron(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15,
            letterSpacing: 1,
          ),
        ),
        subtitle: Row(
          children: [
            Text(
              '${alarm.time.hour.toString().padLeft(2, '0')}:${alarm.time.minute.toString().padLeft(2, '0')} ',
              style: GoogleFonts.robotoMono(
                color: Colors.redAccent.shade100,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
            ..._buildDaysPills(alarm.recurrence),
          ],
        ),
        trailing: Switch(
          value: alarm.enabled,
          onChanged: (val) {
            alarm.enabled = val;
            AlarmStorage.update(alarm);
          },
          activeColor: Colors.redAccent,
        ),
        onLongPress: () async {
          await AlarmStorage.delete(alarm.id);
        },
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => AlarmEditScreen(alarm: alarm)),
          );
        },
      ),
    );
  }

  List<Widget> _buildDaysPills(List<int> recurrence) {
    if (recurrence.isEmpty) {
      return [
        Container(
          margin: const EdgeInsets.only(left: 6),
          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
          decoration: BoxDecoration(
            color: Colors.red.shade900,
            borderRadius: BorderRadius.circular(7),
          ),
          child: Text(
            'Once',
            style: TextStyle(color: Colors.white, fontSize: 9),
          ),
        ),
      ];
    }
    const days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    return recurrence
        .map(
          (i) => Container(
            margin: const EdgeInsets.only(left: 5),
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.red.shade800,
              borderRadius: BorderRadius.circular(7),
            ),
            child: Text(
              days[i % 7],
              style: const TextStyle(color: Colors.white, fontSize: 10),
            ),
          ),
        )
        .toList();
  }
}
