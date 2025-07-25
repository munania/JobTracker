import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:job_tracker_app/src/features/jobs/data/models/job_model.dart';
import 'package:job_tracker_app/src/features/reminders/data/models/reminder_model.dart';

class IsarService {
  late Future<Isar> db;

  IsarService() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      return await Isar.open(
        [JobSchema, ReminderSchema],
        directory: dir.path,
        inspector: true,
      );
    }
    return Future.value(Isar.getInstance());
  }

  Future<void> saveJob(Job job) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.jobs.putSync(job));
  }

  Future<List<Job>> getAllJobs() async {
    final isar = await db;
    return await isar.jobs.where().findAll();
  }

  Future<void> deleteJob(int id) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.jobs.delete(id);
    });
  }

  Future<void> saveReminder(Reminder reminder) async {
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.reminders.putSync(reminder));
  }

  Future<List<Reminder>> getAllReminders() async {
    final isar = await db;
    return await isar.reminders.where().findAll();
  }
}
