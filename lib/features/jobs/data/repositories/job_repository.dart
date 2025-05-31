import '../models/index.dart';
import 'mock_jobs_data.dart';

/// Repository interface for job-related operations
abstract class JobRepository {
  /// Get all jobs with optional filtering
  Future<List<Job>> getAllJobs({
    String? searchQuery,
    String? location,
    List<String>? subjects,
    String? jobType,
  });

  /// Get job by ID
  Future<Job?> getJobById(String id);

  /// Get jobs posted by an institution
  Future<List<Job>> getJobsByInstitution(String institutionId);

  /// Create a new job posting
  Future<Job> createJob(Job job);

  /// Update an existing job
  Future<Job> updateJob(Job job);

  /// Delete a job
  Future<bool> deleteJob(String id);

  /// Apply for a job
  Future<JobApplication> applyForJob({
    required String jobId,
    required String userId,
    required String userName,
    String? userProfileImage,
    String? coverLetter,
    String? resumeUrl,
  });

  /// Get job applications for a specific job
  Future<List<JobApplication>> getJobApplications(String jobId);

  /// Get job applications by a user
  Future<List<JobApplication>> getUserApplications(String userId);

  /// Update application status
  Future<JobApplication> updateApplicationStatus({
    required String applicationId,
    required String status,
    String? feedback,
  });
}

/// Implementation of JobRepository with mock data
class JobRepositoryImpl implements JobRepository {
  @override
  Future<List<Job>> getAllJobs({
    String? searchQuery,
    String? location,
    List<String>? subjects,
    String? jobType,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    List<Job> jobs = MockJobsData.getMockJobs();

    // Apply filters if provided
    if (searchQuery != null && searchQuery.isNotEmpty) {
      final query = searchQuery.toLowerCase();
      jobs = jobs
          .where(
            (job) =>
                job.title.toLowerCase().contains(query) ||
                job.description.toLowerCase().contains(query) ||
                job.institutionName.toLowerCase().contains(query),
          )
          .toList();
    }

    if (location != null && location.isNotEmpty) {
      final locationQuery = location.toLowerCase();
      jobs = jobs
          .where((job) => job.location.toLowerCase().contains(locationQuery))
          .toList();
    }

    if (subjects != null && subjects.isNotEmpty) {
      jobs = jobs
          .where(
            (job) => job.subjects.any((subject) => subjects.contains(subject)),
          )
          .toList();
    }

    if (jobType != null && jobType.isNotEmpty) {
      jobs = jobs.where((job) => job.jobType == jobType).toList();
    }

    return jobs;
  }

  @override
  Future<Job?> getJobById(String id) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));

    try {
      return MockJobsData.getMockJobs().firstWhere((job) => job.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<Job>> getJobsByInstitution(String institutionId) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    return MockJobsData.getMockJobs()
        .where((job) => job.institutionId == institutionId)
        .toList();
  }

  @override
  Future<Job> createJob(Job job) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    // In a real app, we would send this to a backend service
    return job;
  }

  @override
  Future<Job> updateJob(Job job) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 600));

    // In a real app, we would update this in a backend service
    return job;
  }

  @override
  Future<bool> deleteJob(String id) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    // In a real app, we would delete this from a backend service
    return true;
  }

  @override
  Future<JobApplication> applyForJob({
    required String jobId,
    required String userId,
    required String userName,
    String? userProfileImage,
    String? coverLetter,
    String? resumeUrl,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    final application = JobApplication(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      jobId: jobId,
      userId: userId,
      userName: userName,
      userProfileImage: userProfileImage,
      coverLetter: coverLetter,
      resumeUrl: resumeUrl,
      appliedDate: DateTime.now(),
      status: ApplicationStatus.pending,
    );

    // In a real app, we would send this to a backend service
    return application;
  }

  @override
  Future<List<JobApplication>> getJobApplications(String jobId) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    return MockJobsData.getMockApplications()
        .where((app) => app.jobId == jobId)
        .toList();
  }

  @override
  Future<List<JobApplication>> getUserApplications(String userId) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    return MockJobsData.getMockApplications()
        .where((app) => app.userId == userId)
        .toList();
  }

  @override
  Future<JobApplication> updateApplicationStatus({
    required String applicationId,
    required String status,
    String? feedback,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 600));

    try {
      final application = MockJobsData.getMockApplications().firstWhere(
        (app) => app.id == applicationId,
      );

      return application.copyWith(
        status: status,
        feedback: feedback,
        statusUpdatedDate: DateTime.now(),
      );
    } catch (e) {
      throw Exception('Application not found');
    }
  }
}
