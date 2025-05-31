import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/index.dart';
import '../../data/repositories/index.dart';
import 'job_providers.dart';

/// Job state for managing job filtering and creation
class JobState {
  final bool isLoading;
  final String? errorMessage;
  final String? searchQuery;
  final String? location;
  final List<String>? subjects;
  final String? jobType;
  final Job? editingJob;

  JobState({
    this.isLoading = false,
    this.errorMessage,
    this.searchQuery,
    this.location,
    this.subjects,
    this.jobType,
    this.editingJob,
  });

  /// Create a copy with some fields changed
  JobState copyWith({
    bool? isLoading,
    String? errorMessage,
    String? searchQuery,
    String? location,
    List<String>? subjects,
    String? jobType,
    Job? editingJob,
    bool clearError = false,
    bool clearFilters = false,
    bool clearEditingJob = false,
  }) {
    return JobState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      searchQuery: clearFilters ? null : searchQuery ?? this.searchQuery,
      location: clearFilters ? null : location ?? this.location,
      subjects: clearFilters ? null : subjects ?? this.subjects,
      jobType: clearFilters ? null : jobType ?? this.jobType,
      editingJob: clearEditingJob ? null : editingJob ?? this.editingJob,
    );
  }

  /// Get filters as map
  Map<String, dynamic> get filters => {
    if (searchQuery != null && searchQuery!.isNotEmpty)
      'searchQuery': searchQuery,
    if (location != null && location!.isNotEmpty) 'location': location,
    if (subjects != null && subjects!.isNotEmpty) 'subjects': subjects,
    if (jobType != null && jobType!.isNotEmpty) 'jobType': jobType,
  };
}

/// Job notifier for managing job state
class JobNotifier extends StateNotifier<JobState> {
  final JobRepository _jobRepository;

  JobNotifier(this._jobRepository) : super(JobState());

  /// Update search query
  void updateSearchQuery(String? query) {
    state = state.copyWith(searchQuery: query);
  }

  /// Update location filter
  void updateLocation(String? location) {
    state = state.copyWith(location: location);
  }

  /// Update subjects filter
  void updateSubjects(List<String>? subjects) {
    state = state.copyWith(subjects: subjects);
  }

  /// Update job type filter
  void updateJobType(String? jobType) {
    state = state.copyWith(jobType: jobType);
  }

  /// Clear all filters
  void clearFilters() {
    state = state.copyWith(clearFilters: true);
  }

  /// Set job for editing
  void setEditingJob(Job job) {
    state = state.copyWith(editingJob: job);
  }

  /// Clear editing job
  void clearEditingJob() {
    state = state.copyWith(clearEditingJob: true);
  }

  /// Create a new job
  Future<bool> createJob(Job job) async {
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      await _jobRepository.createJob(job);
      state = state.copyWith(isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
      return false;
    }
  }

  /// Update an existing job
  Future<bool> updateJob(Job job) async {
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      await _jobRepository.updateJob(job);
      state = state.copyWith(isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
      return false;
    }
  }

  /// Delete a job
  Future<bool> deleteJob(String id) async {
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      final success = await _jobRepository.deleteJob(id);
      state = state.copyWith(isLoading: false);
      return success;
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
      return false;
    }
  }

  /// Apply for a job
  Future<bool> applyForJob({
    required String jobId,
    required String userId,
    required String userName,
    String? userProfileImage,
    String? coverLetter,
    String? resumeUrl,
  }) async {
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      await _jobRepository.applyForJob(
        jobId: jobId,
        userId: userId,
        userName: userName,
        userProfileImage: userProfileImage,
        coverLetter: coverLetter,
        resumeUrl: resumeUrl,
      );
      state = state.copyWith(isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
      return false;
    }
  }

  /// Update application status
  Future<bool> updateApplicationStatus({
    required String applicationId,
    required String status,
    String? feedback,
  }) async {
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      await _jobRepository.updateApplicationStatus(
        applicationId: applicationId,
        status: status,
        feedback: feedback,
      );
      state = state.copyWith(isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
      return false;
    }
  }

  /// Clear error message
  void clearError() {
    if (state.errorMessage != null) {
      state = state.copyWith(clearError: true);
    }
  }
}

/// Provider for job state
final jobStateProvider = StateNotifierProvider<JobNotifier, JobState>((ref) {
  final repository = ref.watch(jobRepositoryProvider);
  return JobNotifier(repository);
});
