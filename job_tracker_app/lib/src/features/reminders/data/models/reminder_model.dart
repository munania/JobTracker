import 'package:isar/isar.dart';

part 'reminder_model.g.dart';

@collection
class Reminder {
  Id id = Isar.autoIncrement;
  int jobId;
  String text;
  DateTime date;
  bool isOverdue;

  Reminder({
    required this.jobId,
    required this.text,
    required this.date,
    this.isOverdue = false,
  });
}
