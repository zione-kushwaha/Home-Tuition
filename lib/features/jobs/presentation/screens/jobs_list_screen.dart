import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/ui_utils.dart';
import '../../data/models/index.dart';
import '../../domain/providers/job_providers.dart';
import '../../domain/providers/job_state_provider.dart';
import '../widgets/job_filter_bottom_sheet.dart';
import '../widgets/job_list_item.dart';

/// Screen to display list of educational jobs
class JobsListScreen extends ConsumerStatefulWidget {
  const JobsListScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<JobsListScreen> createState() => _JobsListScreenState();
}

class _JobsListScreenState extends ConsumerState<JobsListScreen> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Add listener to search controller
    _searchController.addListener(() {
      ref
          .read(jobStateProvider.notifier)
          .updateSearchQuery(_searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  /// Show filter bottom sheet
  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppTheme.borderRadiusMd),
        ),
      ),
      builder: (context) => const JobFilterBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final jobState = ref.watch(jobStateProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Teaching Jobs'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterBottomSheet,
            tooltip: 'Filter Jobs',
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(AppTheme.spacingMd),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search jobs...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          ref
                              .read(jobStateProvider.notifier)
                              .updateSearchQuery(null);
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppTheme.borderRadiusMd),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),

          // Active filters
          if (_hasActiveFilters(jobState)) _buildActiveFilters(jobState),

          // Job list
          Expanded(child: _buildJobsList(jobState)),
        ],
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  /// Check if there are active filters
  bool _hasActiveFilters(JobState jobState) {
    return jobState.searchQuery != null && jobState.searchQuery!.isNotEmpty ||
        jobState.location != null && jobState.location!.isNotEmpty ||
        jobState.subjects != null && jobState.subjects!.isNotEmpty ||
        jobState.jobType != null && jobState.jobType!.isNotEmpty;
  }

  /// Build active filters chips
  Widget _buildActiveFilters(JobState jobState) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingMd),
      height: 50,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            if (jobState.location != null && jobState.location!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(right: AppTheme.spacingSm),
                child: Chip(
                  label: Text(jobState.location!),
                  deleteIcon: const Icon(Icons.close, size: 16),
                  onDeleted: () {
                    ref.read(jobStateProvider.notifier).updateLocation(null);
                  },
                ),
              ),

            if (jobState.subjects != null && jobState.subjects!.isNotEmpty)
              ...jobState.subjects!
                  .map(
                    (subject) => Padding(
                      padding: const EdgeInsets.only(right: AppTheme.spacingSm),
                      child: Chip(
                        label: Text(subject),
                        deleteIcon: const Icon(Icons.close, size: 16),
                        onDeleted: () {
                          final updatedSubjects = List<String>.from(
                            jobState.subjects!,
                          )..remove(subject);
                          ref
                              .read(jobStateProvider.notifier)
                              .updateSubjects(
                                updatedSubjects.isEmpty
                                    ? null
                                    : updatedSubjects,
                              );
                        },
                      ),
                    ),
                  )
                  .toList(),

            if (jobState.jobType != null && jobState.jobType!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(right: AppTheme.spacingSm),
                child: Chip(
                  label: Text(jobState.jobType!),
                  deleteIcon: const Icon(Icons.close, size: 16),
                  onDeleted: () {
                    ref.read(jobStateProvider.notifier).updateJobType(null);
                  },
                ),
              ),

            TextButton.icon(
              onPressed: () {
                ref.read(jobStateProvider.notifier).clearFilters();
                _searchController.clear();
              },
              icon: const Icon(Icons.clear_all, size: 18),
              label: const Text('Clear all'),
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingSm,
                ),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build jobs list based on current state
  Widget _buildJobsList(JobState jobState) {
    return Consumer(
      builder: (context, ref, child) {
        final jobsProviderAsync = ref.watch(jobsProvider(jobState.filters));

        return jobsProviderAsync.when(
          data: (jobs) {
            if (jobs.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.work_off_outlined, size: 64, color: Colors.grey),
                    SizedBox(height: AppTheme.spacingMd),
                    Text(
                      'No jobs found',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: AppTheme.spacingSm),
                    Text(
                      'Try adjusting your filters',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: () async {
                ref.invalidate(jobsProvider(jobState.filters));
              },
              child: ListView.separated(
                padding: const EdgeInsets.all(AppTheme.spacingMd),
                itemCount: jobs.length,
                separatorBuilder: (_, __) =>
                    const SizedBox(height: AppTheme.spacingMd),
                itemBuilder: (context, index) {
                  final job = jobs[index];
                  return JobListItem(job: job);
                },
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) {
            UiUtils.showSnackBar(
              context,
              message: 'Failed to load jobs: $error',
              isError: true,
              isSuccess: false,
            );
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: AppTheme.errorColor,
                  ),
                  SizedBox(height: AppTheme.spacingMd),
                  Text(
                    'Failed to load jobs',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: AppTheme.spacingSm),
                  Text(
                    'Pull down to retry',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  /// Build floating action button based on user role
  Widget? _buildFloatingActionButton() {
    // Current user might be an institution that can post jobs
    // For now, we'll just allow everyone to see the button
    // In a real implementation, we'd check user role here
    return FloatingActionButton.extended(
      onPressed: () {
        // Navigate to job creation screen
        // Navigator.of(context).pushNamed('/jobs/create');
      },
      icon: const Icon(Icons.add),
      label: const Text('Post a Job'),
      backgroundColor: AppTheme.secondaryColor,
    );
  }
}
