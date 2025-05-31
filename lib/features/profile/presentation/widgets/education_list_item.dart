import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_theme.dart';
import '../../data/models/education.dart';

/// Widget to display an education item in the profile
class EducationListItem extends StatelessWidget {
  final Education education;

  const EducationListItem({
    Key? key,
    required this.education,
  }) : super(key: key);

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
            // Institution name
            Text(
              education.institutionName,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            
            const SizedBox(height: AppTheme.spacingSm),
            
            // Degree/Course
            Text(
              education.degree,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
            
            const SizedBox(height: AppTheme.spacingSm),
            
            // Field of study
            if (education.fieldOfStudy != null && education.fieldOfStudy!.isNotEmpty)
              Text(
                education.fieldOfStudy!,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              
            const SizedBox(height: AppTheme.spacingSm),
            
            // Date range
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 16,
                  color: Colors.grey[700],
                ),
                const SizedBox(width: 4),
                Text(
                  _formatDateRange(education.startDate, education.endDate),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey[700],
                      ),
                ),
              ],
            ),
            
            // Description (if any)
            if (education.description != null && education.description!.isNotEmpty) ...[
              const SizedBox(height: AppTheme.spacingSm),
              Text(
                education.description!,
                style: Theme.of(context).textTheme.bodyMedium,
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
}
