import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../data/models/profile.dart';

/// Widget to display the profile header with photo and basic info
class ProfileHeader extends StatelessWidget {
  final Profile profile;

  const ProfileHeader({
    Key? key,
    required this.profile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Profile image
        _buildProfileImage(),
        
        const SizedBox(height: AppTheme.spacingMd),
        
        // Name
        Text(
          profile.name,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
          textAlign: TextAlign.center,
        ),
        
        const SizedBox(height: AppTheme.spacingSm),
        
        // Role badge
        _buildRoleBadge(context),
        
        const SizedBox(height: AppTheme.spacingMd),
        
        // Contact information
        _buildContactInfo(context),
      ],
    );
  }

  /// Build profile image
  Widget _buildProfileImage() {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppTheme.primaryColor,
          width: 3,
        ),
        image: profile.profileImageUrl != null
            ? DecorationImage(
                image: NetworkImage(profile.profileImageUrl!),
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: profile.profileImageUrl == null
          ? Icon(
              Icons.person,
              size: 60,
              color: AppTheme.primaryColor,
            )
          : null,
    );
  }

  /// Build role badge
  Widget _buildRoleBadge(BuildContext context) {
    // Define colors based on role
    Color badgeColor;
    IconData roleIcon;
    String roleDisplay;

    switch (profile.role) {
      case 'teacher':
        badgeColor = Colors.blue;
        roleIcon = Icons.school;
        roleDisplay = 'Teacher';
        break;
      case 'student':
        badgeColor = Colors.green;
        roleIcon = Icons.person;
        roleDisplay = 'Student';
        break;
      case 'institution':
        badgeColor = Colors.purple;
        roleIcon = Icons.business;
        roleDisplay = 'Institution';
        break;
      default:
        badgeColor = Colors.grey;
        roleIcon = Icons.person;
        roleDisplay = profile.role;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacingMd,
        vertical: AppTheme.spacingSm / 2,
      ),
      decoration: BoxDecoration(
        color: badgeColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            roleIcon,
            size: 16,
            color: Colors.white,
          ),
          const SizedBox(width: 4),
          Text(
            roleDisplay,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
    );
  }

  /// Build contact information
  Widget _buildContactInfo(BuildContext context) {
    return Column(
      children: [
        // Email
        _buildInfoItem(
          context,
          icon: Icons.email,
          label: profile.email,
        ),
        
        // Phone (if available)
        if (profile.phoneNumber != null && profile.phoneNumber!.isNotEmpty)
          _buildInfoItem(
            context,
            icon: Icons.phone,
            label: profile.phoneNumber!,
          ),
        
        // Address (if available)
        if (profile.address != null && profile.address!.isNotEmpty)
          _buildInfoItem(
            context,
            icon: Icons.location_on,
            label: profile.address!,
          ),
      ],
    );
  }

  /// Build info item with icon and label
  Widget _buildInfoItem(
    BuildContext context, {
    required IconData icon,
    required String label,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppTheme.spacingSm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 16,
            color: Colors.grey[700],
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
