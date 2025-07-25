import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_tracker_app/src/features/jobs/data/models/job_model.dart';
import 'package:job_tracker_app/src/services/isar_service.dart';
import 'package:file_picker/file_picker.dart';

final isarServiceProvider = Provider((ref) => IsarService());

class AddJobScreen extends ConsumerStatefulWidget {
  @override
  _AddJobScreenState createState() => _AddJobScreenState();
}

class _AddJobScreenState extends ConsumerState<AddJobScreen> {
  final _formKey = GlobalKey<FormState>();
  final _companyController = TextEditingController();
  final _positionController = TextEditingController();
  final _locationController = TextEditingController();
  final _salaryController = TextEditingController();
  final _sourceUrlController = TextEditingController();
  JobStage _selectedStage = JobStage.saved;
  String? _resumePath;
  String? _coverLetterPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Job')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _companyController,
                decoration: InputDecoration(labelText: 'Company'),
                validator: (value) => value!.isEmpty ? 'Please enter a company' : null,
              ),
              TextFormField(
                controller: _positionController,
                decoration: InputDecoration(labelText: 'Position'),
                validator: (value) => value!.isEmpty ? 'Please enter a position' : null,
              ),
              TextFormField(
                controller: _locationController,
                decoration: InputDecoration(labelText: 'Location'),
              ),
              TextFormField(
                controller: _salaryController,
                decoration: InputDecoration(labelText: 'Salary'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _sourceUrlController,
                decoration: InputDecoration(labelText: 'Source URL'),
              ),
              DropdownButtonFormField<JobStage>(
                value: _selectedStage,
                items: JobStage.values
                    .map((stage) => DropdownMenuItem(
                          value: stage,
                          child: Text(stage.toString().split('.').last),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedStage = value!;
                  });
                },
                decoration: InputDecoration(labelText: 'Stage'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  FilePickerResult? result = await FilePicker.platform.pickFiles();
                  if (result != null) {
                    setState(() {
                      _resumePath = result.files.single.path;
                    });
                  }
                },
                child: Text('Upload Resume'),
              ),
              if (_resumePath != null) Text('Resume: $_resumePath'),
              ElevatedButton(
                onPressed: () async {
                  FilePickerResult? result = await FilePicker.platform.pickFiles();
                  if (result != null) {
                    setState(() {
                      _coverLetterPath = result.files.single.path;
                    });
                  }
                },
                child: Text('Upload Cover Letter'),
              ),
              if (_coverLetterPath != null) Text('Cover Letter: $_coverLetterPath'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final newJob = Job(
                        company: _companyController.text,
                        position: _positionController.text,
                        location: _locationController.text,
                        salary: double.tryParse(_salaryController.text),
                        sourceUrl: _sourceUrlController.text,
                        stage: _selectedStage,
                        resumePath: _resumePath,
                        coverLetterPath: _coverLetterPath,
                        dateAdded: DateTime.now(),
                        activityLog: [
                          Activity(
                              description: 'Job created',
                              date: DateTime.now())
                        ]);
                    ref.read(isarServiceProvider).saveJob(newJob);
                    Navigator.pop(context);
                  }
                },
                child: Text('Save Job'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
