import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/index.dart';
import '../../data/repositories/index.dart';

/// Provider for job repository
final jobRepositoryProvider = Provider<JobRepository>((ref) {
  return JobRepositoryImpl();
});

/// Provider for all jobs
final jobsProvider = FutureProvider.autoDispose
    .family<List<Job>, Map<String, dynamic>?>((ref, filters) async {
      final repository = ref.watch(jobRepositoryProvider);
      return repository.getAllJobs(
        searchQuery: filters?['searchQuery'] as String?,
        location: filters?['location'] as String?,
        subjects: filters?['subjects'] as List<String>?,
        jobType: filters?['jobType'] as String?,
      );
    });

/// Provider for a single job by ID
final jobProvider = FutureProvider.autoDispose.family<Job?, String>((
  ref,
  jobId,
) async {
  final repository = ref.watch(jobRepositoryProvider);
  return repository.getJobById(jobId);
});

/// Provider for jobs by institution ID
final institutionJobsProvider = FutureProvider.autoDispose
    .family<List<Job>, String>((ref, institutionId) async {
      final repository = ref.watch(jobRepositoryProvider);
      return repository.getJobsByInstitution(institutionId);
    });

/// Provider for job applications for a specific job
final jobApplicationsProvider = FutureProvider.autoDispose
    .family<List<JobApplication>, String>((ref, jobId) async {
      final repository = ref.watch(jobRepositoryProvider);
      return repository.getJobApplications(jobId);
    });

/// Provider for a user's job applications
final userApplicationsProvider = FutureProvider.autoDispose
    .family<List<JobApplication>, String>((ref, userId) async {
      final repository = ref.watch(jobRepositoryProvider);
      return repository.getUserApplications(userId);
    });
