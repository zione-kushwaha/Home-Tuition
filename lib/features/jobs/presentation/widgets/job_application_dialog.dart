import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/ui_utils.dart';
import '../../data/models/job.dart';
import '../../domain/providers/job_state_provider.dart';

/// Dialog for applying to a job
class JobApplicationDialog extends ConsumerStatefulWidget {
  final Job job;

  const JobApplicationDialog({Key? key, required this.job}) : super(key: key);

  @override
  ConsumerState<JobApplicationDialog> createState() =>
      _JobApplicationDialogState();
}

class _JobApplicationDialogState extends ConsumerState<JobApplicationDialog> {
  final _formKey = GlobalKey<FormState>();
  final _coverLetterController = TextEditingController();
  String? _resumeUrl; // In a real app, this would be uploaded

  bool _isSubmitting = false;

  @override
  void dispose() {
    _coverLetterController.dispose();
    super.dispose();
  }

  /// Submit job application
  Future<void> _submitApplication() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      // In a real app, we would get the actual user data from auth state
      // For now, using mock user data
      final success = await ref
          .read(jobStateProvider.notifier)
          .applyForJob(
            jobId: widget.job.id,
            userId: "current-user-id", // This would come from auth state
            userName: "Current User", // This would come from auth state
            coverLetter: _coverLetterController.text,
            resumeUrl: _resumeUrl,
          );

      if (!mounted) return;

      if (success) {
        Navigator.of(context).pop();
        UiUtils.showSnackBar(
          context,
          message: 'Application submitted successfully',
          isSuccess: true,
        );
      } else {
        UiUtils.showSnackBar(
          context,
          message: 'Failed to submit application',
          isError: true,
          isSuccess: false,
        );
      }
    } catch (e) {
      if (!mounted) return;

      UiUtils.showSnackBar(
        context,
        message: 'Error: ${e.toString()}',
        isError: true,
        isSuccess: false,
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusMd),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.spacingLg),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Dialog title
                Text(
                  'Apply for ${widget.job.title}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: AppTheme.spacingSm),
                Text(
                  widget.job.institutionName,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const Divider(height: AppTheme.spacingLg * 2),

                // Cover letter
                Text(
                  'Cover Letter',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: AppTheme.spacingSm),
                TextFormField(
                  controller: _coverLetterController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText:
                        'Tell us why you are a good fit for this position...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        AppTheme.borderRadiusSm,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.grey[50],
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a cover letter';
                    }
                    if (value.length < 50) {
                      return 'Cover letter should be at least 50 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppTheme.spacingMd),

                // Resume upload (mock)
                Text(
                  'Resume',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: AppTheme.spacingSm),
                OutlinedButton.icon(
                  onPressed: () {
                    // Mock resume upload
                    setState(() {
                      _resumeUrl = 'https://example.com/resume.pdf';
                    });
                    UiUtils.showSnackBar(
                      context,
                      message: 'Resume uploaded successfully',
                      isSuccess: true,
                    );
                  },
                  icon: const Icon(Icons.upload_file),
                  label: Text(
                    _resumeUrl != null ? 'Resume uploaded' : 'Upload Resume',
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppTheme.spacingMd,
                      horizontal: AppTheme.spacingMd,
                    ),
                    side: BorderSide(color: Colors.grey[400]!),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        AppTheme.borderRadiusSm,
                      ),
                    ),
                  ),
                ),
                if (_resumeUrl != null)
                  Padding(
                    padding: const EdgeInsets.only(top: AppTheme.spacingSm),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.check_circle,
                          color: AppTheme.successColor,
                          size: 16,
                        ),
                        const SizedBox(width: AppTheme.spacingXs),
                        Text(
                          'Resume uploaded',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: AppTheme.successColor),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: AppTheme.spacingMd),

                // Information note
                Container(
                  padding: const EdgeInsets.all(AppTheme.spacingMd),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(
                      AppTheme.borderRadiusSm,
                    ),
                    border: Border.all(color: Colors.blue.shade200),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: Colors.blue.shade700,
                        size: 20,
                      ),
                      const SizedBox(width: AppTheme.spacingSm),
                      Expanded(
                        child: Text(
                          'Your profile information will be shared with the institution.',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: Colors.blue.shade700),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppTheme.spacingLg),

                // Action buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: _isSubmitting
                          ? null
                          : () => Navigator.of(context).pop(),
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(width: AppTheme.spacingMd),
                    ElevatedButton(
                      onPressed: _isSubmitting ? null : _submitApplication,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryColor,
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppTheme.spacingLg,
                          vertical: AppTheme.spacingMd,
                        ),
                      ),
                      child: _isSubmitting
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Text('Submit Application'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
