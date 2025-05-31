import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_theme.dart';
import '../../data/models/experience.dart';

/// Widget to display a work experience item in the profile
class ExperienceListItem extends StatelessWidget {
  final Experience experience;

  const ExperienceListItem({Key? key, required this.experience})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppTheme.spacingMd),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusMd),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Job title
            Text(
              experience.title,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: AppTheme.spacingSm),

            // Company name
            Text(
              experience.company,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
            ),

            const SizedBox(height: AppTheme.spacingSm),

            // Location
            if (experience.location != null &&
                experience.location!.isNotEmpty) ...[
              Row(
                children: [
                  Icon(Icons.location_on, size: 16, color: Colors.grey[700]),
                  const SizedBox(width: 4),
                  Text(
                    experience.location!,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              const SizedBox(height: AppTheme.spacingSm),
            ],

            // Employment type
            if (experience.employmentType != null &&
                experience.employmentType!.isNotEmpty) ...[
              Row(
                children: [
                  Icon(Icons.work, size: 16, color: Colors.grey[700]),
                  const SizedBox(width: 4),
                  Text(
                    experience.employmentType!,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              const SizedBox(height: AppTheme.spacingSm),
            ],

            // Date range
            Row(
              children: [
                Icon(Icons.calendar_today, size: 16, color: Colors.grey[700]),
                const SizedBox(width: 4),
                Text(
                  _formatDateRange(experience.startDate, experience.endDate),
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: Colors.grey[700]),
                ),

                // Show duration
                if (_calculateDuration(
                  experience.startDate,
                  experience.endDate,
                ).isNotEmpty) ...[
                  const SizedBox(width: 4),
                  Text(
                    '(${_calculateDuration(experience.startDate, experience.endDate)})',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontStyle: FontStyle.italic,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ],
            ),

            // Description
            if (experience.description != null &&
                experience.description!.isNotEmpty) ...[
              const SizedBox(height: AppTheme.spacingMd),
              Text(
                experience.description!,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],

            // Skills
            if (experience.skills != null && experience.skills!.isNotEmpty) ...[
              const SizedBox(height: AppTheme.spacingMd),
              Wrap(
                spacing: AppTheme.spacingSm,
                runSpacing: AppTheme.spacingSm,
                children: experience.skills!
                    .map(
                      (skill) => Chip(
                        label: Text(skill),
                        backgroundColor: Colors.grey[200],
                        padding: EdgeInsets.zero,
                        labelStyle: const TextStyle(fontSize: 12),
                      ),
                    )
                    .toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }

  /// Format date range
  String _formatDateRange(DateTime startDate, DateTime? endDate) {
    final dateFormat = DateFormat('MMM yyyy');
    final start = dateFormat.format(startDate);

    if (endDate == null) {
      return '$start - Present';
    } else {
      final end = dateFormat.format(endDate);
      return '$start - $end';
    }
  }

  /// Calculate experience duration
  String _calculateDuration(DateTime startDate, DateTime? endDate) {
    final end = endDate ?? DateTime.now();
    final difference = end.difference(startDate);

    final years = (difference.inDays / 365).floor();
    final months = ((difference.inDays % 365) / 30).floor();

    if (years > 0) {
      return months > 0
          ? '$years yr$_plural(years) $months mo$_plural(months)'
          : '$years yr$_plural(years)';
    } else if (months > 0) {
      return '$months mo$_plural(months)';
    } else {
      return '${difference.inDays} day$_plural(difference.inDays)';
    }
  }

  /// Pluralize suffix based on count
  String _plural(int count) {
    return count != 1 ? 's' : '';
  }
}
