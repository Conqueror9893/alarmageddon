import 'package:flutter/material.dart';
import 'alarm_storage.dart';
import 'alarm_edit_screen.dart';
import 'alarm_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AlarmListScreen extends StatelessWidget {
  const AlarmListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Alarms')),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<Alarm>(AlarmStorage.boxName).listenable(),
        builder: (context, Box<Alarm> box, _) {
          if (box.values.isEmpty) {
            return const Center(child: Text('No alarms yet!'));
          }
          final alarms = box.values.toList();
          return ListView.builder(
            itemCount: alarms.length,
            itemBuilder: (context, index) {
              final alarm = alarms[index];
              return ListTile(
                leading: Icon(
                  alarm.enabled ? Icons.alarm_on : Icons.alarm_off,
                  color: alarm.enabled ? Colors.red : Colors.grey,
                ),
                title: Text(
                  alarm.label.isNotEmpty ? alarm.label : 'Alarm',
                  style: const TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  '${alarm.time.hour.toString().padLeft(2, '0')}:${alarm.time.minute.toString().padLeft(2, '0')} - ${_recurrenceString(alarm.recurrence)}',
                  style: const TextStyle(color: Colors.white70),
                ),
                trailing: Switch(
                  value: alarm.enabled,
                  onChanged: (val) {
                    alarm.enabled = val;
                    AlarmStorage.update(alarm);
                  },
                  activeColor: Colors.red,
                ),
                onLongPress: () async {
                  await AlarmStorage.delete(alarm.id);
                },
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => AlarmEditScreen(alarm: alarm),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => const AlarmEditScreen()));
        },
        child: const Icon(Icons.add_alarm),
      ),
    );
  }

  String _recurrenceString(List<int> recurrence) {
    if (recurrence.isEmpty) return 'One-time';
    const days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    return recurrence.map((i) => days[i % 7]).join(', ');
  }
}
