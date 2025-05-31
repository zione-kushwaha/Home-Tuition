import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/providers/job_state_provider.dart';

/// Bottom sheet for filtering jobs
class JobFilterBottomSheet extends ConsumerStatefulWidget {
  const JobFilterBottomSheet({Key? key}) : super(key: key);

  @override
  ConsumerState<JobFilterBottomSheet> createState() =>
      _JobFilterBottomSheetState();
}

class _JobFilterBottomSheetState extends ConsumerState<JobFilterBottomSheet> {
  // Form fields
  String? _location;
  List<String>? _subjects;
  String? _jobType;

  // Available options
  final List<String> _locationOptions = [
    'Delhi',
    'Mumbai',
    'Bangalore',
    'Hyderabad',
    'Chennai',
    'Kolkata',
    'Pune',
    'Ahmedabad',
  ];

  final List<String> _subjectOptions = [
    'Mathematics',
    'Physics',
    'Chemistry',
    'Biology',
    'Computer Science',
    'English',
    'Hindi',
    'Social Studies',
    'Geography',
    'History',
  ];

  final List<String> _jobTypeOptions = [
    'Full-time',
    'Part-time',
    'Contract',
    'Temporary',
    'Internship',
  ];

  @override
  void initState() {
    super.initState();

    // Initialize with current filter values
    final jobState = ref.read(jobStateProvider);
    _location = jobState.location;
    _subjects = jobState.subjects;
    _jobType = jobState.jobType;
  }

  // Apply filters and close bottom sheet
  void _applyFilters() {
    final notifier = ref.read(jobStateProvider.notifier);
    notifier.updateLocation(_location);
    notifier.updateSubjects(_subjects);
    notifier.updateJobType(_jobType);
    Navigator.of(context).pop();
  }

  // Reset filters to initial state
  void _resetFilters() {
    setState(() {
      _location = null;
      _subjects = null;
      _jobType = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // Add extra padding for bottom to account for soft keyboard
      padding: EdgeInsets.fromLTRB(
        AppTheme.spacingMd,
        AppTheme.spacingMd,
        AppTheme.spacingMd,
        MediaQuery.of(context).viewInsets.bottom + AppTheme.spacingMd,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppTheme.borderRadiusMd),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with title and close button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Filter Jobs', style: Theme.of(context).textTheme.titleLarge),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),

          const SizedBox(height: AppTheme.spacingMd),

          // Location filter
          Text(
            'Location',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: AppTheme.spacingSm),
          Wrap(
            spacing: AppTheme.spacingSm,
            runSpacing: AppTheme.spacingSm,
            children: _locationOptions.map((location) {
              final isSelected = _location == location;

              return FilterChip(
                label: Text(location),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    _location = selected ? location : null;
                  });
                },
                selectedColor: AppTheme.primaryColor.withOpacity(0.2),
                checkmarkColor: AppTheme.primaryColor,
              );
            }).toList(),
          ),

          const SizedBox(height: AppTheme.spacingLg),

          // Subject filter
          Text(
            'Subjects',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: AppTheme.spacingSm),
          Wrap(
            spacing: AppTheme.spacingSm,
            runSpacing: AppTheme.spacingSm,
            children: _subjectOptions.map((subject) {
              final isSelected = _subjects?.contains(subject) ?? false;

              return FilterChip(
                label: Text(subject),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    if (_subjects == null) {
                      _subjects = [];
                    }

                    if (selected) {
                      _subjects!.add(subject);
                    } else {
                      _subjects!.remove(subject);
                    }

                    if (_subjects!.isEmpty) {
                      _subjects = null;
                    }
                  });
                },
                selectedColor: AppTheme.primaryColor.withOpacity(0.2),
                checkmarkColor: AppTheme.primaryColor,
              );
            }).toList(),
          ),

          const SizedBox(height: AppTheme.spacingLg),

          // Job type filter
          Text(
            'Job Type',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: AppTheme.spacingSm),
          Wrap(
            spacing: AppTheme.spacingSm,
            runSpacing: AppTheme.spacingSm,
            children: _jobTypeOptions.map((jobType) {
              final isSelected = _jobType == jobType;

              return FilterChip(
                label: Text(jobType),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    _jobType = selected ? jobType : null;
                  });
                },
                selectedColor: AppTheme.primaryColor.withOpacity(0.2),
                checkmarkColor: AppTheme.primaryColor,
              );
            }).toList(),
          ),

          const SizedBox(height: AppTheme.spacingLg),

          // Action buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(onPressed: _resetFilters, child: const Text('Reset')),
              const SizedBox(width: AppTheme.spacingMd),
              ElevatedButton(
                onPressed: _applyFilters,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppTheme.spacingMd,
                    vertical: AppTheme.spacingSm,
                  ),
                ),
                child: const Text('Apply'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
