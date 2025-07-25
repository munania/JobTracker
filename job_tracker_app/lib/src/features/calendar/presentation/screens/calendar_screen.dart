import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_tracker_app/src/features/reminders/data/models/reminder_model.dart';
import 'package:job_tracker_app/src/services/isar_service.dart';
import 'package:table_calendar/table_calendar.dart';

final remindersProvider = FutureProvider<List<Reminder>>((ref) async {
  return ref.watch(isarServiceProvider).getAllReminders();
});

class CalendarScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final remindersAsyncValue = ref.watch(remindersProvider);
    return Scaffold(
      appBar: AppBar(title: Text('Calendar')),
      body: remindersAsyncValue.when(
        data: (reminders) {
          final events = {
            for (var reminder in reminders)
              DateTime.utc(reminder.date.year, reminder.date.month,
                  reminder.date.day): [reminder.text]
          };

          return TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: DateTime.now(),
            eventLoader: (day) {
              return events[DateTime.utc(day.year, day.month, day.day)] ?? [];
            },
          );
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
