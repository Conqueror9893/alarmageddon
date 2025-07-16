import 'package:hive/hive.dart';
part 'alarm_model.g.dart';

@HiveType(typeId: 0)
class Alarm extends HiveObject {
  @HiveField(0)
  int id;

  @HiveField(1)
  DateTime time;

  @HiveField(2)
  List<int> recurrence; // 0=Sun, 1=Mon, ... 6=Sat

  @HiveField(3)
  bool enabled;

  @HiveField(4)
  String label;

  Alarm({
    required this.id,
    required this.time,
    required this.recurrence,
    this.enabled = true,
    this.label = '',
  });
}
