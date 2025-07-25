import 'package_rename/isar.dart';

part 'job_model.g.dart';

@collection
class Job {
  Id id = Isar.autoIncrement;
  String company;
  String position;
  String location;
  double? salary;
  String? sourceUrl;
  JobStage stage;
  String? resumePath;
  String? coverLetterPath;
  DateTime dateAdded;
  List<Note> notes;
  List<Activity> activityLog;

  Job({
    required this.company,
    required this.position,
    required this.location,
    this.salary,
    this.sourceUrl,
    required this.stage,
    this.resumePath,
    this.coverLetterPath,
    required this.dateAdded,
    this.notes = const [],
    this.activityLog = const [],
  });
}

@embedded
class Note {
  String text;
  DateTime date;

  Note({required this.text, required this.date});
}

@embedded
class Activity {
  String description;
  DateTime date;

  Activity({required this.description, required this.date});
}

enum JobStage {
  saved,
  applied,
  interviewing,
  offer,
  hired,
  rejected,
}
