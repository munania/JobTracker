import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_tracker_app/src/features/jobs/data/models/job_model.dart';
import 'package:job_tracker_app/src/services/isar_service.dart';
import 'package:intl/intl.dart';

class JobDetailsScreen extends ConsumerStatefulWidget {
  final Job job;

  JobDetailsScreen({required this.job});

  @override
  _JobDetailsScreenState createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends ConsumerState<JobDetailsScreen> {
  final _noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.job.position)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text('Company: ${widget.job.company}'),
            Text('Location: ${widget.job.location}'),
            if (widget.job.salary != null) Text('Salary: \$${widget.job.salary}'),
            Text('Stage: ${widget.job.stage.toString().split('.').last}'),
            SizedBox(height: 20),
            Text('Notes', style: Theme.of(context).textTheme.headline6),
            ...widget.job.notes.map((note) => ListTile(
                  title: Text(note.text),
                  subtitle: Text(DateFormat.yMd().add_jm().format(note.date)),
                )),
            TextField(
              controller: _noteController,
              decoration: InputDecoration(labelText: 'Add a note'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  widget.job.notes.add(Note(
                    text: _noteController.text,
                    date: DateTime.now(),
                  ));
                  ref.read(isarServiceProvider).saveJob(widget.job);
                  _noteController.clear();
                });
              },
              child: Text('Add Note'),
            ),
            SizedBox(height: 20),
            Text('Activity Log', style: Theme.of(context).textTheme.headline6),
            ...widget.job.activityLog.map((activity) => ListTile(
                  title: Text(activity.description),
                  subtitle: Text(DateFormat.yMd().add_jm().format(activity.date)),
                )),
          ],
        ),
      ),
    );
  }
}
