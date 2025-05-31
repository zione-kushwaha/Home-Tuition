import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/ui_utils.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/loading_view.dart';
import '../../data/models/index.dart';
import '../../domain/providers/profile_providers.dart';
import '../widgets/edit_profile_form.dart';

/// Screen to edit user profile
class ProfileEditScreen extends ConsumerWidget {
  final String userId;

  const ProfileEditScreen({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileProvider(userId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        actions: [
          // Save button
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () => _handleSave(context, ref),
            tooltip: 'Save Changes',
          ),
        ],
      ),
      body: profileAsync.when(
        data: (profile) {
          if (profile == null) {
            return Center(child: Text('Profile not found'));
          }
          return _buildEditForm(context, ref, profile);
        },
        loading: () => const LoadingView(),
        error: (error, stackTrace) => ErrorView(
          errorMessage: 'Error loading profile: $error',
          onRetry: () => ref.refresh(profileProvider(userId)),
        ),
      ),
    );
  }

  /// Build the profile edit form
  Widget _buildEditForm(BuildContext context, WidgetRef ref, Profile profile) {
    return EditProfileForm(
      profile: profile,
      onSave: (updatedProfile) => _saveProfile(context, ref, updatedProfile),
    );
  }

  /// Handle save button press
  Future<void> _handleSave(BuildContext context, WidgetRef ref) async {
    // This will trigger the save method in the EditProfileForm
    // via the GlobalKey<FormState>
    final formKey = GlobalKey<FormState>();
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState?.save();
    }
  }

  /// Save the profile changes
  Future<void> _saveProfile(
    BuildContext context,
    WidgetRef ref,
    Profile updatedProfile,
  ) async {
    try {
      final stateNotifier = ref.read(profileStateProvider.notifier);
      await stateNotifier.updateProfile(updatedProfile);
      
      if (context.mounted) {
        UiUtils.showSnackBar(
          context,
          message: 'Profile updated successfully',
          isSuccess: true,
        );
        Navigator.of(context).pop(); // Return to profile view
      }
    } catch (e) {
      if (context.mounted) {
        UiUtils.showSnackBar(
          context,
          message: 'Failed to update profile: $e',
          isError: true,
          isSuccess: false,
        );
      }
    }
  }
}
