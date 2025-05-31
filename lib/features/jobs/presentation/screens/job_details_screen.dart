import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/ui_utils.dart';
import '../../data/models/index.dart';
import '../../domain/providers/job_providers.dart';
import '../widgets/job_application_dialog.dart';

/// Screen to display job details
class JobDetailsScreen extends ConsumerWidget {
  final String jobId;

  const JobDetailsScreen({Key? key, required this.jobId}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jobAsync = ref.watch(jobProvider(jobId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Details'),
        actions: [
          // Share button
          IconButton(
            icon: const Icon(Icons.share),            onPressed: () {
              // Implement share functionality
              UiUtils.showSnackBar(
                context,
                message: 'Share functionality coming soon!',
                isSuccess: true,
              );
            },
            tooltip: 'Share',
          ),
          // Add to favorites
          IconButton(
            icon: const Icon(Icons.bookmark_border),            onPressed: () {
              // Implement favorite functionality
              UiUtils.showSnackBar(
                context, 
                message: 'Added to saved jobs',
                isSuccess: true,
              );
            },
            tooltip: 'Save',
          ),
        ],
      ),
      body: jobAsync.when(
        data: (job) {
          if (job == null) {
            return const Center(child: Text('Job not found'));
          }
          return _buildJobDetails(context, job);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) =>
            Center(child: Text('Error loading job: $error')),
      ),
    );
  }
  /// Build job details content
  Widget _buildJobDetails(BuildContext context, Job job) {
    return Column(
      children: [
        // Scrollable content
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppTheme.spacingMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildJobHeader(context, job),
                const SizedBox(height: AppTheme.spacingMd),
                _buildJobMetadata(context, job),
                const Divider(height: AppTheme.spacingLg * 2),
                _buildJobDescription(context, job),
                const SizedBox(height: AppTheme.spacingLg),
                _buildJobRequirements(context, job),
                const SizedBox(height: AppTheme.spacingLg),
                _buildSubjects(context, job),
                const SizedBox(height: AppTheme.spacingLg),
                _buildContactInformation(context, job),
                const SizedBox(height: AppTheme.spacingLg),
                _buildPostedDate(context, job),
                // Extra space at bottom for the apply button
                const SizedBox(height: 80),
              ],
            ),
          ),
        ),

        // Apply button at the bottom
        _buildApplyButton(context, job),
      ],
    );
  }

  /// Build job header with title and institution name
  Widget _buildJobHeader(BuildContext context, Job job) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Job title
        Text(
          job.title,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppTheme.spacingSm),
        // Institution name
        Text(
          job.institutionName,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }

  /// Build job metadata (location, type, salary, deadline)
  Widget _buildJobMetadata(BuildContext context, Job job) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoRow(
          icon: Icons.location_on,
          label: 'Location',
          value: job.location,
        ),
        _buildInfoRow(
          icon: Icons.work,
          label: 'Job Type',
          value: job.jobType,
        ),
        _buildInfoRow(
          icon: Icons.attach_money,
          label: 'Salary',
          value: job.salary,
        ),
        if (job.applicationDeadline != null)
          _buildInfoRow(
            icon: Icons.event,
            label: 'Application Deadline',
            value: DateFormat(
              'MMMM d, yyyy',
            ).format(job.applicationDeadline!),
            isWarning:
                job.applicationDeadline!
                    .difference(DateTime.now())
                    .inDays <
                7,
          ),
      ],
    );
  }

  /// Build job description section
  Widget _buildJobDescription(BuildContext context, Job job) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(context, 'Description'),
        const SizedBox(height: AppTheme.spacingSm),
        Text(job.description),
      ],
    );
  }

  /// Build job requirements section
  Widget _buildJobRequirements(BuildContext context, Job job) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(context, 'Requirements'),
        const SizedBox(height: AppTheme.spacingSm),
        ...job.requirements.map(
          (req) => _buildRequirementItem(context, req),
        ),
      ],
    );
  }

  /// Build subjects section
  Widget _buildSubjects(BuildContext context, Job job) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(context, 'Subjects'),
        const SizedBox(height: AppTheme.spacingSm),
        Wrap(
          spacing: AppTheme.spacingSm,
          runSpacing: AppTheme.spacingSm,
          children: job.subjects.map((subject) {
            return Chip(label: Text(subject));
          }).toList(),
        ),
      ],
    );
  }

  /// Build contact information section
  Widget _buildContactInformation(BuildContext context, Job job) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(context, 'Contact Information'),
        const SizedBox(height: AppTheme.spacingSm),
        if (job.contactEmail != null)
          _buildContactItem(
            context,
            icon: Icons.email,
            label: 'Email',
            value: job.contactEmail!,
          ),
        if (job.contactPhone != null)
          _buildContactItem(
            context,
            icon: Icons.phone,
            label: 'Phone',
            value: job.contactPhone!,
          ),
      ],
    );
  }

  /// Build posted date section
  Widget _buildPostedDate(BuildContext context, Job job) {
    return Text(
      'Posted on ${DateFormat('MMMM d, yyyy').format(job.postedDate)}',
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
        color: Colors.grey[600],
        fontStyle: FontStyle.italic,
      ),
    );
  }
  /// Build apply button container
  Widget _buildApplyButton(BuildContext context, Job job) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingMd),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Applications count
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${job.applicationsCount} ${job.applicationsCount == 1 ? 'application' : 'applications'}',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'so far',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
              ),
            ],
          ),
          const Spacer(),
          // Apply button
          ElevatedButton(
            onPressed: () => _showApplicationDialog(context, job),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryColor,
              padding: const EdgeInsets.symmetric(
                horizontal: AppTheme.spacingLg,
                vertical: AppTheme.spacingMd,
              ),
            ),
            child: const Text(
              'Apply Now',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  /// Build section title
  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w600,
        color: AppTheme.primaryColor,
      ),
    );
  }

  /// Build information row
  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    bool isWarning = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppTheme.spacingSm),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: isWarning ? AppTheme.warningColor : Colors.grey[700],
          ),
          const SizedBox(width: AppTheme.spacingSm),
          Text(
            '$label: ',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: isWarning ? AppTheme.warningColor : null,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build requirement item
  Widget _buildRequirementItem(BuildContext context, String requirement) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppTheme.spacingSm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.check_circle,
            size: 16,
            color: AppTheme.successColor,
          ),
          const SizedBox(width: AppTheme.spacingSm),
          Expanded(child: Text(requirement)),
        ],
      ),
    );
  }

  /// Build contact item
  Widget _buildContactItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppTheme.spacingSm),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppTheme.primaryColor),
          const SizedBox(width: AppTheme.spacingSm),
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.w500)),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Show job application dialog
  void _showApplicationDialog(BuildContext context, Job job) {
    showDialog(
      context: context,
      builder: (context) => JobApplicationDialog(job: job),
    );
  }
}
