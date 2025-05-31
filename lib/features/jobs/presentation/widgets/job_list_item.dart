import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as app_date_utils;
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import '../../../../core/animations/app_animations.dart';
import '../../../../core/theme/app_theme.dart';

import '../../data/models/job.dart';

/// Widget to display a job item in the list
class JobListItem extends StatelessWidget {
  final Job job;
  final int? index;

  const JobListItem({Key? key, required this.job, this.index})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final card = Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusMd),
      ),
      child: InkWell(
        onTap: () {
          // Navigate to job details
          Navigator.of(context).pushNamed('/jobs/${job.id}', arguments: job);
        },
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusMd),
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.spacingMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title and salary row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      job.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacingSm),
                  Text(
                    job.salary,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: AppTheme.primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: AppTheme.spacingSm),

              // Institution name
              Text(
                job.institutionName,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
              ),

              const SizedBox(height: AppTheme.spacingSm),

              // Location and job type
              Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: 16,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 4),
                  Text(
                    job.location,
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                  ),
                  const SizedBox(width: AppTheme.spacingMd),
                  Icon(Icons.work_outline, size: 16, color: Colors.grey[600]),
                  const SizedBox(width: 4),
                  Text(
                    job.jobType,
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                  ),
                ],
              ),

              const SizedBox(height: AppTheme.spacingSm),

              // Subjects tags
              Wrap(
                spacing: AppTheme.spacingSm,
                runSpacing: AppTheme.spacingXs,
                children: job.subjects.map((subject) {
                  return Chip(
                    label: Text(subject, style: const TextStyle(fontSize: 12)),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                    padding: EdgeInsets.zero,
                  );
                }).toList(),
              ),

              const SizedBox(height: AppTheme.spacingSm),

              // Divider
              const Divider(),

              // Posted date and applications info
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Posted ${app_date_utils.DateUtils.getTimeAgo(job.postedDate)}',
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                  ),
                  if (job.applicationDeadline != null)
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time,
                          size: 14,
                          color: AppTheme.warningColor,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Deadline: ${DateFormat('MMM d').format(job.applicationDeadline!)}',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                fontWeight: FontWeight.w500,
                                color: AppTheme.warningColor,
                              ),
                        ),
                      ],
                    ),
                ],
              ),

              const SizedBox(height: AppTheme.spacingXs),

              // Applications count
              Row(
                children: [
                  Icon(Icons.people_outline, size: 14, color: Colors.grey[600]),
                  const SizedBox(width: 4),
                  Text(
                    '${job.applicationsCount} ${job.applicationsCount == 1 ? 'application' : 'applications'}',
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    // Apply animation if index is provided
    if (index != null) {
      return card
          .animate(onPlay: (controller) => controller.forward())
          .fadeIn(
            duration: AppAnimations.medium,
            delay: Duration(milliseconds: 50 * index!),
          )
          .slideY(
            begin: 0.1,
            end: 0,
            duration: AppAnimations.medium,
            delay: Duration(milliseconds: 50 * index!),
            curve: Curves.easeOutCubic,
          );
    }

    return card;
  }
}
