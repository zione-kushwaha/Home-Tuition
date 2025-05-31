import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/ui_utils.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/loading_view.dart';
import '../../data/models/index.dart';
import '../../domain/providers/profile_providers.dart';
import '../widgets/certificate_list_item.dart';
import '../widgets/education_list_item.dart';
import '../widgets/experience_list_item.dart';
import '../widgets/profile_header.dart';
import '../widgets/skill_chip.dart';

/// Screen to view a user profile
class ProfileScreen extends ConsumerWidget {
  final String userId;
  final bool isCurrentUser;

  const ProfileScreen({
    Key? key,
    required this.userId,
    this.isCurrentUser = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileProvider(userId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          if (isCurrentUser)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                // Navigate to edit profile screen
                // TODO: Implement navigation
                UiUtils.showSnackBar(
                  context,
                  message: 'Edit profile feature coming soon',
                  isSuccess: true,
                );
              },
              tooltip: 'Edit Profile',
            ),
        ],
      ),
      body: profileAsync.when(
        data: (profile) {
          if (profile == null) {
            return Center(child: Text('Profile not found'));
          }
          return _buildProfileContent(context, profile);
        },
        loading: () => const LoadingView(),
        error: (error, stackTrace) => ErrorView(
          errorMessage: 'Error loading profile: $error',
          onRetry: () => ref.refresh(profileProvider(userId)),
        ),
      ),
    );
  }

  /// Build the profile content
  Widget _buildProfileContent(BuildContext context, Profile profile) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppTheme.spacingMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile header with basic info
          ProfileHeader(profile: profile),
          
          const SizedBox(height: AppTheme.spacingLg),
          
          // Bio section
          if (profile.bio != null && profile.bio!.isNotEmpty) ...[
            _buildSectionHeader(context, 'Bio'),
            Text(
              profile.bio!,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: AppTheme.spacingLg),
          ],
          
          // Education section
          if (profile.education != null && profile.education!.isNotEmpty) ...[
            _buildSectionHeader(context, 'Education'),
            ...profile.education!.map(
              (education) => EducationListItem(education: education),
            ),
            const SizedBox(height: AppTheme.spacingLg),
          ],
          
          // Experience section
          if (profile.experience != null && profile.experience!.isNotEmpty) ...[
            _buildSectionHeader(context, 'Experience'),
            ...profile.experience!.map(
              (experience) => ExperienceListItem(experience: experience),
            ),
            const SizedBox(height: AppTheme.spacingLg),
          ],
          
          // Skills section
          if (profile.skills != null && profile.skills!.isNotEmpty) ...[
            _buildSectionHeader(context, 'Skills'),
            Wrap(
              spacing: AppTheme.spacingSm,
              runSpacing: AppTheme.spacingSm,
              children: profile.skills!.map(
                (skill) => SkillChip(skill: skill),
              ).toList(),
            ),
            const SizedBox(height: AppTheme.spacingLg),
          ],
          
          // Certificates section
          if (profile.certificates != null && profile.certificates!.isNotEmpty) ...[
            _buildSectionHeader(context, 'Certificates'),
            ...profile.certificates!.map(
              (certificate) => CertificateListItem(certificate: certificate),
            ),
            const SizedBox(height: AppTheme.spacingLg),
          ],
          
          // Role specific data section
          if (profile.roleSpecificData != null && profile.roleSpecificData!.isNotEmpty)
            _buildRoleSpecificData(context, profile),
        ],
      ),
    );
  }
  
  /// Build role-specific data section
  Widget _buildRoleSpecificData(BuildContext context, Profile profile) {
    // Dynamically build role-specific UI based on role
    switch (profile.role) {
      case 'teacher':
        return _buildTeacherSpecificData(context, profile.roleSpecificData!);
      case 'student':
        return _buildStudentSpecificData(context, profile.roleSpecificData!);
      case 'institution':
        return _buildInstitutionSpecificData(context, profile.roleSpecificData!);
      default:
        return const SizedBox.shrink();
    }
  }
  
  /// Build teacher-specific data section
  Widget _buildTeacherSpecificData(BuildContext context, Map<String, dynamic> data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(context, 'Teaching Information'),
        
        // Subjects taught
        if (data['subjectsTaught'] != null) ...[
          Text(
            'Subjects:',
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppTheme.spacingSm),
          Wrap(
            spacing: AppTheme.spacingSm,
            runSpacing: AppTheme.spacingSm,
            children: (data['subjectsTaught'] as List<dynamic>)
                .map((subject) => Chip(label: Text(subject.toString())))
                .toList(),
          ),
          const SizedBox(height: AppTheme.spacingMd),
        ],
        
        // Teaching experience
        if (data['teachingExperience'] != null) ...[
          Text(
            'Teaching Experience: ${data['teachingExperience']} years',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: AppTheme.spacingMd),
        ],
        
        // Teaching levels
        if (data['teachingLevels'] != null) ...[
          Text(
            'Teaching Levels:',
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppTheme.spacingSm),
          Wrap(
            spacing: AppTheme.spacingSm,
            runSpacing: AppTheme.spacingSm,
            children: (data['teachingLevels'] as List<dynamic>)
                .map((level) => Chip(label: Text(level.toString())))
                .toList(),
          ),
        ],
      ],
    );
  }
  
  /// Build student-specific data section
  Widget _buildStudentSpecificData(BuildContext context, Map<String, dynamic> data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(context, 'Student Information'),
        
        // Current school/institution
        if (data['currentInstitution'] != null) ...[
          Text(
            'Currently studying at: ${data['currentInstitution']}',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: AppTheme.spacingMd),
        ],
        
        // Current grade/class
        if (data['currentGrade'] != null) ...[
          Text(
            'Current Grade/Class: ${data['currentGrade']}',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: AppTheme.spacingMd),
        ],
        
        // Subjects of interest
        if (data['subjectsOfInterest'] != null) ...[
          Text(
            'Subjects of Interest:',
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppTheme.spacingSm),
          Wrap(
            spacing: AppTheme.spacingSm,
            runSpacing: AppTheme.spacingSm,
            children: (data['subjectsOfInterest'] as List<dynamic>)
                .map((subject) => Chip(label: Text(subject.toString())))
                .toList(),
          ),
        ],
      ],
    );
  }
  
  /// Build institution-specific data section
  Widget _buildInstitutionSpecificData(BuildContext context, Map<String, dynamic> data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(context, 'Institution Information'),
        
        // Institution type
        if (data['institutionType'] != null) ...[
          Text(
            'Type: ${data['institutionType']}',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: AppTheme.spacingMd),
        ],
        
        // Establishment year
        if (data['establishmentYear'] != null) ...[
          Text(
            'Established: ${data['establishmentYear']}',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: AppTheme.spacingMd),
        ],
        
        // Number of students
        if (data['studentCount'] != null) ...[
          Text(
            'Students: ${data['studentCount']}',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: AppTheme.spacingMd),
        ],
        
        // Courses/Programs offered
        if (data['programsOffered'] != null) ...[
          Text(
            'Programs Offered:',
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppTheme.spacingSm),
          Wrap(
            spacing: AppTheme.spacingSm,
            runSpacing: AppTheme.spacingSm,
            children: (data['programsOffered'] as List<dynamic>)
                .map((program) => Chip(label: Text(program.toString())))
                .toList(),
          ),
        ],
      ],
    );
  }
  
  /// Build section header
  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppTheme.spacingSm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppTheme.primaryColor,
            ),
          ),
          const Divider(height: AppTheme.spacingMd),
        ],
      ),
    );
  }
}
