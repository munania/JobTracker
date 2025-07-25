import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_tracker_app/src/features/jobs/data/models/job_model.dart';
import 'package:job_tracker_app/src/features/jobs/presentation/screens/add_job_screen.dart';
import 'package:job_tracker_app/src/features/jobs/presentation/screens/job_details_screen.dart';
import 'package:job_tracker_app/src/services/isar_service.dart';

final jobsProvider =
    StateNotifierProvider<JobsNotifier, AsyncValue<List<Job>>>((ref) {
  return JobsNotifier(ref.watch(isarServiceProvider));
});

class JobsNotifier extends StateNotifier<AsyncValue<List<Job>>> {
  final IsarService _isarService;
  String _searchTerm = '';
  JobStage? _filterStage;

  JobsNotifier(this._isarService) : super(AsyncValue.loading()) {
    _fetchJobs();
  }

  Future<void> _fetchJobs() async {
    try {
      state = AsyncValue.loading();
      final jobs = await _isarService.getAllJobs();
      var filteredJobs = jobs;
      if (_searchTerm.isNotEmpty) {
        filteredJobs = filteredJobs
            .where((job) =>
                job.company.toLowerCase().contains(_searchTerm.toLowerCase()) ||
                job.position.toLowerCase().contains(_searchTerm.toLowerCase()))
            .toList();
      }
      if (_filterStage != null) {
        filteredJobs =
            filteredJobs.where((job) => job.stage == _filterStage).toList();
      }
      state = AsyncValue.data(filteredJobs);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  void search(String searchTerm) {
    _searchTerm = searchTerm;
    _fetchJobs();
  }

  void filterByStage(JobStage? stage) {
    _filterStage = stage;
    _fetchJobs();
  }
}

class JobListScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jobsAsyncValue = ref.watch(jobsProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('My Jobs'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddJobScreen()),
              ).then((_) => ref.refresh(jobsProvider));
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search by company or position',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                ref.read(jobsProvider.notifier).search(value);
              },
            ),
          ),
          // TODO: Add filter chips
          Expanded(
            child: jobsAsyncValue.when(
              data: (jobs) => ListView.builder(
                itemCount: jobs.length,
                itemBuilder: (context, index) {
                  final job = jobs[index];
                  return ListTile(
                    title: Text(job.position),
                    subtitle: Text(job.company),
                    trailing: Text(job.stage.toString().split('.').last),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => JobDetailsScreen(job: job)),
                      );
                    },
                  );
                },
              ),
              loading: () => Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err')),
            ),
          ),
        ],
      ),
    );
  }
}
