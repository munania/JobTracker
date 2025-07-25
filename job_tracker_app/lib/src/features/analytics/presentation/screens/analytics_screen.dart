import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_tracker_app/src/features/jobs/data/models/job_model.dart';
import 'package:job_tracker_app/src/services/isar_service.dart';
import 'package:fl_chart/fl_chart.dart';

final analyticsProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  final jobs = await ref.watch(isarServiceProvider).getAllJobs();
  final appliedJobs =
      jobs.where((job) => job.stage == JobStage.applied).length;
  final interviewJobs =
      jobs.where((job) => job.stage == JobStage.interviewing).length;
  final offerJobs = jobs.where((job) => job.stage == JobStage.offer).length;

  return {
    'applied': appliedJobs,
    'interview': interviewJobs,
    'offer': offerJobs,
    'offerRate': appliedJobs > 0 ? offerJobs / appliedJobs : 0.0,
  };
});

class AnalyticsScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final analyticsAsyncValue = ref.watch(analyticsProvider);
    return Scaffold(
      appBar: AppBar(title: Text('Analytics')),
      body: analyticsAsyncValue.when(
        data: (analytics) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text('Jobs Applied: ${analytics['applied']}'),
              Text('Interviews: ${analytics['interview']}'),
              Text('Offers: ${analytics['offer']}'),
              Text(
                  'Offer Rate: ${(analytics['offerRate'] * 100).toStringAsFixed(2)}%'),
              SizedBox(height: 20),
              AspectRatio(
                aspectRatio: 1.5,
                child: BarChart(
                  BarChartData(
                    barGroups: [
                      BarChartGroupData(x: 0, barRods: [
                        BarChartRodData(toY: analytics['applied'].toDouble(), color: Colors.blue)
                      ]),
                      BarChartGroupData(x: 1, barRods: [
                        BarChartRodData(
                            toY: analytics['interview'].toDouble(), color: Colors.orange)
                      ]),
                      BarChartGroupData(x: 2, barRods: [
                        BarChartRodData(toY: analytics['offer'].toDouble(), color: Colors.green)
                      ]),
                    ],
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (double value, TitleMeta meta) {
                            switch (value.toInt()) {
                              case 0:
                                return Text('Applied');
                              case 1:
                                return Text('Interview');
                              case 2:
                                return Text('Offer');
                              default:
                                return Text('');
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        loading: () => Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
