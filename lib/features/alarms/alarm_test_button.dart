import 'package:flutter/material.dart';
import 'alarm_model.dart';
import 'alarm_storage.dart';

class AlarmTestButton extends StatelessWidget {
  const AlarmTestButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: const Text('Set Test Alarm (1 min from now)'),
      onPressed: () async {
        final now = DateTime.now();
        final alarm = Alarm(
          id: DateTime.now().millisecondsSinceEpoch,
          time: now.add(const Duration(minutes: 1)),
          recurrence: [],
          enabled: true,
          label: 'Test Alarm',
        );
        await AlarmStorage.add(alarm);
        await AlarmStorage.scheduleAlarm(alarm);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Test alarm set for 1 minute from now!')),
        );
      },
    );
  }
}