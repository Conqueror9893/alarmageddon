import 'alarm_model.dart';
import 'alarm_storage.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AlarmEditScreen extends StatefulWidget {
  final Alarm? alarm;
  const AlarmEditScreen({Key? key, this.alarm}) : super(key: key);

  @override
  State<AlarmEditScreen> createState() => _AlarmEditScreenState();
}

class _AlarmEditScreenState extends State<AlarmEditScreen> {
  late TimeOfDay _time;
  List<int> _recurrence = [];
  bool _enabled = true;
  String _label = '';

  @override
  void initState() {
    super.initState();
    if (widget.alarm != null) {
      _time = TimeOfDay(
        hour: widget.alarm!.time.hour,
        minute: widget.alarm!.time.minute,
      );
      _recurrence = List<int>.from(widget.alarm!.recurrence);
      _enabled = widget.alarm!.enabled;
      _label = widget.alarm!.label;
    } else {
      _time = TimeOfDay.now();
    }
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(context: context, initialTime: _time);
    if (picked != null) {
      setState(() {
        _time = picked;
      });
    }
  }

  void _toggleDay(int day) {
    setState(() {
      if (_recurrence.contains(day)) {
        _recurrence.remove(day);
      } else {
        _recurrence.add(day);
      }
    });
  }

  Future<void> _saveAlarm() async {
    final now = DateTime.now();
    final alarmTime = DateTime(
      now.year,
      now.month,
      now.day,
      _time.hour,
      _time.minute,
    );
    final id = widget.alarm?.id ?? DateTime.now().millisecondsSinceEpoch;
    final alarm = Alarm(
      id: id,
      time: alarmTime,
      recurrence: _recurrence,
      enabled: _enabled,
      label: _label,
    );
    await AlarmStorage.add(alarm);
    if (_enabled) {
      await AlarmStorage.scheduleAlarm(alarm);
    } else {
      await AlarmStorage.cancelAlarm(alarm.id);
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.alarm == null ? 'Set Alarm' : 'Edit Alarm'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text('Time: ${_time.format(context)}'),
              trailing: Icon(Icons.access_time, color: Colors.red),
              onTap: _pickTime,
            ),
            const SizedBox(height: 16),
            Text('Repeat on:', style: Theme.of(context).textTheme.bodyLarge),
            Wrap(
              spacing: 8,
              children: List.generate(7, (i) {
                const days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
                final selected = _recurrence.contains(i);
                return ChoiceChip(
                  label: Text(days[i]),
                  selected: selected,
                  selectedColor: Colors.red,
                  onSelected: (_) => _toggleDay(i),
                );
              }),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Label',
                border: OutlineInputBorder(),
              ),
              onChanged: (val) => setState(() => _label = val),
              controller: TextEditingController(text: _label),
            ),
            const Spacer(),
            Row(
              children: [
                const Text('Enabled', style: TextStyle(color: Colors.white)),
                Switch(
                  value: _enabled,
                  onChanged: (val) => setState(() => _enabled = val),
                  activeColor: Colors.red,
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: _saveAlarm,
                  child: const Text('Save'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
