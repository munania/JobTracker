import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_tracker_app/src/features/reminders/data/models/reminder_model.dart';
import 'package:job_tracker_app/src/services/isar_service.dart';
import 'package:job_tracker_app/src/services/notification_service.dart';

final notificationServiceProvider = Provider((ref) => NotificationService());

class AddReminderScreen extends ConsumerStatefulWidget {
  final int jobId;

  AddReminderScreen({required this.jobId});

  @override
  _AddReminderScreenState createState() => _AddReminderScreenState();
}

class _AddReminderScreenState extends ConsumerState<AddReminderScreen> {
  final _textController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Reminder')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _textController,
              decoration: InputDecoration(labelText: 'Reminder Text'),
            ),
            SizedBox(height: 20),
            Text('Selected Date: ${_selectedDate.toLocal()}'.split(' ')[0]),
            ElevatedButton(
              onPressed: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2101),
                );
                if (picked != null && picked != _selectedDate)
                  setState(() {
                    _selectedDate = picked;
                  });
              },
              child: Text('Select Date'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final newReminder = Reminder(
                  jobId: widget.jobId,
                  text: _textController.text,
                  date: _selectedDate,
                );
                ref.read(isarServiceProvider).saveReminder(newReminder);
                ref.read(notificationServiceProvider).scheduleNotification(
                      id: newReminder.id,
                      title: 'Job Reminder',
                      body: newReminder.text,
                      scheduledDate: newReminder.date,
                    );
                Navigator.pop(context);
              },
              child: Text('Save Reminder'),
            ),
          ],
        ),
      ),
    );
  }
}
