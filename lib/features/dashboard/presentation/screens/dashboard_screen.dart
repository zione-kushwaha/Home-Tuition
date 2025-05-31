import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/animations/index.dart';
import '../../../../core/constants/user_roles.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/ui_utils.dart';
import '../../../auth/data/models/index.dart';
import '../../../auth/domain/providers/auth_state_provider.dart';
import '../../domain/providers/index.dart';

/// Base dashboard screen that adapts based on the user's role
class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    
    // Refresh dashboard data when the screen is opened
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(dashboardStateProvider.notifier).loadDashboardData();
    });
  }
  
  /// Handle logout button press
  Future<void> _handleLogout() async {
    // Show confirmation dialog
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
    
    // If user confirms logout
    if (shouldLogout == true) {
      await ref.read(authStateProvider.notifier).signOut();
      // Navigation will be handled by the router
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);
    final dashboardState = ref.watch(dashboardStateProvider);
    
    final user = authState.user;
    
    // If user is not available, show loading
    if (user == null) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: AppTheme.primaryColor,
          ),
        ),
      );
    }
    
    return Scaffold(
      appBar: AppBar(
        title: Text('${user.roleDisplayName} Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _handleLogout,
            tooltip: 'Logout',
          ),
        ],
      ),
      body: dashboardState.isLoading 
        ? Center(
            child: CircularProgressIndicator(
              color: AppTheme.primaryColor,
            ),
          )
        : _buildDashboardContent(user, dashboardState),
    );
  }
  
  /// Build dashboard content based on the user role
  Widget _buildDashboardContent(User user, DashboardState dashboardState) {
    // If there's an error, show error message
    if (dashboardState.errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              color: AppTheme.errorColor,
              size: 48,
            ),
            const SizedBox(height: 16),
            Text(
              dashboardState.errorMessage!,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppTheme.errorColor,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ref.read(dashboardStateProvider.notifier).loadDashboardData();
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }
    
    // If dashboard data is not available, show empty state
    if (dashboardState.dashboardData == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.dashboard_outlined,
              color: AppTheme.primaryColor,
              size: 48,
            ),
            const SizedBox(height: 16),
            Text(
              'Welcome to GDA EDU WORLD',
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Your dashboard is being set up',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onBackground.withOpacity(0.6),
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }
    
    // Build dashboard based on the user's role
    if (user.isTeacher || user.isTrainer) {
      return _buildEducatorDashboard(user, dashboardState);
    } else if (user.isStudent) {
      return _buildStudentDashboard(user, dashboardState);
    } else if (user.isInstitution) {
      return _buildInstitutionDashboard(user, dashboardState);
    } else {
      // Fallback dashboard for unknown roles
      return _buildGenericDashboard(user, dashboardState);
    }
  }
  
  /// Build dashboard for teachers and trainers
  Widget _buildEducatorDashboard(User user, DashboardState state) {
    final data = state.dashboardData!;
    final stats = data['stats'] as Map<String, dynamic>;
    final upcomingInterviews = data['upcomingInterviews'] as List<dynamic>;
    final recentJobPostings = data['recentJobPostings'] as List<dynamic>;
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppTheme.spacingMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome message
          Text(
            'Welcome back, ${user.name}!',
            style: Theme.of(context).textTheme.headlineSmall,
          )
              .animate()
              .fadeIn(duration: AppAnimations.fast)
              .slideX(begin: -0.1, end: 0),
              
          const SizedBox(height: AppTheme.spacingSm),
          
          // Role info
          Text(
            user.roleDisplayName,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          )
              .animate()
              .fadeIn(delay: AppAnimations.veryFast, duration: AppAnimations.fast)
              .slideX(begin: -0.1, end: 0),
              
          const SizedBox(height: AppTheme.spacingMd),
          
          // Stats cards
          Row(
            children: [
              _buildStatCard(
                context, 
                'Applications', 
                stats['applications'].toString(),
                Icons.description_outlined,
                0,
              ),
              const SizedBox(width: AppTheme.spacingSm),
              _buildStatCard(
                context, 
                'Interviews', 
                stats['interviews'].toString(),
                Icons.people_outline,
                1,
              ),
              const SizedBox(width: AppTheme.spacingSm),
              _buildStatCard(
                context, 
                'Offers', 
                stats['offers'].toString(),
                Icons.work_outline,
                2,
              ),
            ],
          ),
          
          const SizedBox(height: AppTheme.spacingMd),
          
          // Upcoming interviews
          _buildSectionHeader(context, 'Upcoming Interviews', 3),
          
          const SizedBox(height: AppTheme.spacingSm),
          
          ...upcomingInterviews.asMap().entries.map((entry) {
            final index = entry.key;
            final interview = entry.value as Map<String, dynamic>;
            
            return Card(
              elevation: 1,
              margin: const EdgeInsets.only(bottom: AppTheme.spacingSm),
              child: Padding(
                padding: const EdgeInsets.all(AppTheme.spacingSm),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
                    child: const Icon(
                      Icons.event_outlined,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                  title: Text(interview['schoolName'] as String),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(interview['position'] as String),
                      const SizedBox(height: 4),
                      Text(
                        'Date: ${_formatDate(interview['date'] as DateTime)}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text(
                        'Location: ${interview['location'] as String}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.calendar_today_outlined),
                    onPressed: () {
                      // Add to calendar action
                      UiUtils.showSnackBar(
                        context,
                        message: 'Added to calendar',
                        isSuccess: true,
                      );
                    },
                  ),
                ),
              ),
            )
                .animate()
                .fadeIn(
                  delay: Duration(milliseconds: 300 + (index * 100)),
                  duration: AppAnimations.medium,
                )
                .slideY(begin: 0.1, end: 0);
          }).toList(),
          
          const SizedBox(height: AppTheme.spacingMd),
          
          // Recent job postings
          _buildSectionHeader(
            context, 
            'Recent Job Postings', 
            4 + upcomingInterviews.length,
          ),
          
          const SizedBox(height: AppTheme.spacingSm),
          
          ...recentJobPostings.asMap().entries.map((entry) {
            final index = entry.key;
            final job = entry.value as Map<String, dynamic>;
            
            return Card(
              elevation: 1,
              margin: const EdgeInsets.only(bottom: AppTheme.spacingSm),
              child: Padding(
                padding: const EdgeInsets.all(AppTheme.spacingSm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                job['title'] as String,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Text(
                                job['institution'] as String,
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: Theme.of(context).colorScheme.primary,
                                    ),
                              ),
                            ],
                          ),
                        ),
                        Chip(
                          label: Text(
                            job['location'] as String,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppTheme.primaryColor,
                                ),
                          ),
                          backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
                          padding: EdgeInsets.zero,
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                      ],
                    ),
                    const SizedBox(height: AppTheme.spacingXs),
                    Text(
                      'Salary: ${job['salary'] as String}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: AppTheme.spacingXs),
                    Text(
                      'Posted ${_getTimeAgo(job['postedDate'] as DateTime)}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.onBackground.withOpacity(0.6),
                          ),
                    ),
                    const SizedBox(height: AppTheme.spacingSm),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            UiUtils.showSnackBar(
                              context,
                              message: 'Job details opened',
                              isSuccess: true,
                            );
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(0, 0),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text('View Details'),
                        ),
                        const SizedBox(width: AppTheme.spacingSm),
                        ElevatedButton(
                          onPressed: () {
                            UiUtils.showSnackBar(
                              context,
                              message: 'Application submitted!',
                              isSuccess: true,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppTheme.spacingSm,
                              vertical: AppTheme.spacingXs,
                            ),
                            minimumSize: const Size(0, 0),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text('Apply Now'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
                .animate()
                .fadeIn(
                  delay: Duration(milliseconds: 300 + (index * 100)),
                  duration: AppAnimations.medium,
                )
                .slideY(begin: 0.1, end: 0);
          }).toList(),
        ],
      ),
    );
  }
  
  /// Build dashboard for students
  Widget _buildStudentDashboard(User user, DashboardState state) {
    final data = state.dashboardData!;
    final stats = data['stats'] as Map<String, dynamic>;
    final upcomingClasses = data['upcomingClasses'] as List<dynamic>;
    final recentQuestions = data['recentQuestions'] as List<dynamic>;
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppTheme.spacingMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome message
          Text(
            'Welcome back, ${user.name}!',
            style: Theme.of(context).textTheme.headlineSmall,
          )
              .animate()
              .fadeIn(duration: AppAnimations.fast)
              .slideX(begin: -0.1, end: 0),
              
          const SizedBox(height: AppTheme.spacingSm),
          
          // Student info
          Text(
            'Student',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          )
              .animate()
              .fadeIn(delay: AppAnimations.veryFast, duration: AppAnimations.fast)
              .slideX(begin: -0.1, end: 0),
              
          const SizedBox(height: AppTheme.spacingMd),
          
          // Stats cards
          Row(
            children: [
              _buildStatCard(
                context, 
                'Courses', 
                stats['enrolledCourses'].toString(),
                Icons.book_outlined,
                0,
              ),
              const SizedBox(width: AppTheme.spacingSm),
              _buildStatCard(
                context, 
                'Assignments', 
                stats['completedAssignments'].toString(),
                Icons.assignment_outlined,
                1,
              ),
              const SizedBox(width: AppTheme.spacingSm),
              _buildStatCard(
                context, 
                'Questions', 
                stats['questionsAsked'].toString(),
                Icons.help_outline,
                2,
              ),
            ],
          ),
          
          const SizedBox(height: AppTheme.spacingMd),
          
          // Upcoming classes
          _buildSectionHeader(context, 'Upcoming Classes', 3),
          
          const SizedBox(height: AppTheme.spacingSm),
          
          ...upcomingClasses.asMap().entries.map((entry) {
            final index = entry.key;
            final classInfo = entry.value as Map<String, dynamic>;
            
            return Card(
              elevation: 1,
              margin: const EdgeInsets.only(bottom: AppTheme.spacingSm),
              child: Padding(
                padding: const EdgeInsets.all(AppTheme.spacingSm),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: AppTheme.secondaryColor.withOpacity(0.1),
                    child: const Icon(
                      Icons.school_outlined,
                      color: AppTheme.secondaryColor,
                    ),
                  ),
                  title: Text(classInfo['subject'] as String),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Teacher: ${classInfo['teacher'] as String}'),
                      const SizedBox(height: 4),
                      Text(
                        'Time: ${_formatTime(classInfo['time'] as DateTime)}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text(
                        'Duration: ${classInfo['duration'] as String}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  trailing: ElevatedButton(
                    onPressed: () {
                      UiUtils.showSnackBar(
                        context,
                        message: 'Joining class...',
                        isSuccess: true,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.secondaryColor,
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppTheme.spacingSm,
                        vertical: AppTheme.spacingXs,
                      ),
                      minimumSize: const Size(0, 0),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: _isClassSoon(classInfo['time'] as DateTime)
                        ? const Text('Join Now')
                        : const Text('Remind Me'),
                  ),
                ),
              ),
            )
                .animate()
                .fadeIn(
                  delay: Duration(milliseconds: 300 + (index * 100)),
                  duration: AppAnimations.medium,
                )
                .slideY(begin: 0.1, end: 0);
          }).toList(),
          
          const SizedBox(height: AppTheme.spacingMd),
          
          // Recent questions
          _buildSectionHeader(
            context, 
            'Your Recent Questions', 
            4 + upcomingClasses.length,
          ),
          
          const SizedBox(height: AppTheme.spacingSm),
          
          ...recentQuestions.asMap().entries.map((entry) {
            final index = entry.key;
            final question = entry.value as Map<String, dynamic>;
            
            return Card(
              elevation: 1,
              margin: const EdgeInsets.only(bottom: AppTheme.spacingSm),
              child: Padding(
                padding: const EdgeInsets.all(AppTheme.spacingSm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppTheme.spacingXs,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.secondaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(AppTheme.borderRadiusSm),
                          ),
                          child: Text(
                            question['subject'] as String,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppTheme.secondaryColor,
                                ),
                          ),
                        ),
                        const SizedBox(width: AppTheme.spacingXs),
                        Text(
                          '• ${_getTimeAgo(question['timestamp'] as DateTime)}',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color:
                                    Theme.of(context).colorScheme.onBackground.withOpacity(0.6),
                              ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppTheme.spacingXs,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.accentColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(AppTheme.borderRadiusSm),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.question_answer_outlined,
                                size: 12,
                                color: AppTheme.accentColor,
                              ),
                              const SizedBox(width: 2),
                              Text(
                                question['answers'].toString(),
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: AppTheme.accentColor,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppTheme.spacingXs),
                    Text(
                      question['question'] as String,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: AppTheme.spacingSm),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            UiUtils.showSnackBar(
                              context,
                              message: 'Viewing answers...',
                              isSuccess: true,
                            );
                          },
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppTheme.spacingSm,
                              vertical: AppTheme.spacingXs,
                            ),
                            minimumSize: const Size(0, 0),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text('View Answers'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
                .animate()
                .fadeIn(
                  delay: Duration(milliseconds: 300 + (index * 100)),
                  duration: AppAnimations.medium,
                )
                .slideY(begin: 0.1, end: 0);
          }).toList(),
        ],
      ),
    );
  }

  /// Build dashboard for institutions (coaching centers, schools, colleges)
  Widget _buildInstitutionDashboard(User user, DashboardState state) {
    final data = state.dashboardData!;
    final stats = data['stats'] as Map<String, dynamic>;
    final teacherApplications = data['teacherApplications'] as List<dynamic>;
    final studentEnrollments = data['studentEnrollments'] as List<dynamic>;
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppTheme.spacingMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome message
          Text(
            'Welcome, ${user.name}',
            style: Theme.of(context).textTheme.headlineSmall,
          )
              .animate()
              .fadeIn(duration: AppAnimations.fast)
              .slideX(begin: -0.1, end: 0),
              
          const SizedBox(height: AppTheme.spacingSm),
          
          // Institution type
          Text(
            user.roleDisplayName,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          )
              .animate()
              .fadeIn(delay: AppAnimations.veryFast, duration: AppAnimations.fast)
              .slideX(begin: -0.1, end: 0),
              
          const SizedBox(height: AppTheme.spacingMd),
          
          // Stats cards
          Row(
            children: [
              _buildStatCard(
                context, 
                'Teachers', 
                stats['totalTeachers'].toString(),
                Icons.people_alt_outlined,
                0,
              ),
              const SizedBox(width: AppTheme.spacingSm),
              _buildStatCard(
                context, 
                'Students', 
                stats['totalStudents'].toString(),
                Icons.school_outlined,
                1,
              ),
              const SizedBox(width: AppTheme.spacingSm),
              _buildStatCard(
                context, 
                'Active Jobs', 
                stats['activeJobs'].toString(),
                Icons.work_outline,
                2,
              ),
            ],
          ),
          
          const SizedBox(height: AppTheme.spacingMd),
          
          // Teacher applications
          _buildSectionHeader(context, 'Recent Teacher Applications', 3),
          
          const SizedBox(height: AppTheme.spacingSm),
          
          ...teacherApplications.asMap().entries.map((entry) {
            final index = entry.key;
            final application = entry.value as Map<String, dynamic>;
            
            return Card(
              elevation: 1,
              margin: const EdgeInsets.only(bottom: AppTheme.spacingSm),
              child: Padding(
                padding: const EdgeInsets.all(AppTheme.spacingSm),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
                    child: const Icon(
                      Icons.person_outlined,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                  title: Text(application['name'] as String),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(application['position'] as String),
                      const SizedBox(height: 4),
                      Text(
                        'Experience: ${application['experience'] as String}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text(
                        'Applied: ${_getTimeAgo(application['appliedDate'] as DateTime)}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.check_circle_outline,
                          color: AppTheme.secondaryColor,
                        ),
                        onPressed: () {
                          UiUtils.showSnackBar(
                            context,
                            message: 'Application approved',
                            isSuccess: true,
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.cancel_outlined,
                          color: AppTheme.errorColor,
                        ),
                        onPressed: () {
                          UiUtils.showSnackBar(
                            context,
                            message: 'Application rejected',
                            isSuccess: false,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            )
                .animate()
                .fadeIn(
                  delay: Duration(milliseconds: 300 + (index * 100)),
                  duration: AppAnimations.medium,
                )
                .slideY(begin: 0.1, end: 0);
          }).toList(),
          
          const SizedBox(height: AppTheme.spacingMd),
          
          // Student enrollments
          _buildSectionHeader(
            context, 
            'Recent Student Enrollments', 
            4 + teacherApplications.length,
          ),
          
          const SizedBox(height: AppTheme.spacingSm),
          
          ...studentEnrollments.asMap().entries.map((entry) {
            final index = entry.key;
            final enrollment = entry.value as Map<String, dynamic>;
            
            return Card(
              elevation: 1,
              margin: const EdgeInsets.only(bottom: AppTheme.spacingSm),
              child: Padding(
                padding: const EdgeInsets.all(AppTheme.spacingSm),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: AppTheme.secondaryColor.withOpacity(0.1),
                    child: const Icon(
                      Icons.person_outlined,
                      color: AppTheme.secondaryColor,
                    ),
                  ),
                  title: Text(enrollment['name'] as String),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(enrollment['course'] as String),
                      const SizedBox(height: 4),
                      Text(
                        'Enrolled: ${_getTimeAgo(enrollment['enrollmentDate'] as DateTime)}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  trailing: TextButton(
                    onPressed: () {
                      UiUtils.showSnackBar(
                        context,
                        message: 'Viewing student details',
                        isSuccess: true,
                      );
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppTheme.spacingSm,
                        vertical: AppTheme.spacingXs,
                      ),
                      minimumSize: const Size(0, 0),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text('View Details'),
                  ),
                ),
              ),
            )
                .animate()
                .fadeIn(
                  delay: Duration(milliseconds: 300 + (index * 100)),
                  duration: AppAnimations.medium,
                )
                .slideY(begin: 0.1, end: 0);
          }).toList(),
          
          const SizedBox(height: AppTheme.spacingSm),
          
          // Add job button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                UiUtils.showSnackBar(
                  context,
                  message: 'Creating new job posting',
                  isSuccess: true,
                );
              },
              icon: const Icon(Icons.add),
              label: const Text('Post a New Job'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                padding: const EdgeInsets.symmetric(vertical: AppTheme.spacingSm),
              ),
            ),
          )
              .animate()
              .fadeIn(
                delay: Duration(
                  milliseconds: 300 + ((teacherApplications.length + studentEnrollments.length) * 100),
                ),
                duration: AppAnimations.medium,
              )
              .slideY(begin: 0.1, end: 0),
        ],
      ),
    );
  }

  /// Build generic dashboard for any user role
  Widget _buildGenericDashboard(User user, DashboardState state) {
    final data = state.dashboardData!;
    final userInfo = data['userInfo'] as Map<String, dynamic>;
    
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacingMd),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.dashboard_outlined,
              size: 72,
              color: AppTheme.primaryColor,
            )
                .animate()
                .scale(duration: AppAnimations.medium),
                
            const SizedBox(height: AppTheme.spacingMd),
            
            Text(
              data['message'] as String,
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            )
                .animate()
                .fadeIn(delay: AppAnimations.fast)
                .slideY(begin: 0.1, end: 0),
                
            const SizedBox(height: AppTheme.spacingLg),
            
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(AppTheme.spacingMd),
                child: Column(
                  children: [
                    ListTile(
                      title: const Text('Name'),
                      subtitle: Text(userInfo['name'] as String),
                      leading: const Icon(Icons.person_outline),
                    ),
                    const Divider(),
                    ListTile(
                      title: const Text('Email'),
                      subtitle: Text(userInfo['email'] as String),
                      leading: const Icon(Icons.email_outlined),
                    ),
                    const Divider(),
                    ListTile(
                      title: const Text('Role'),
                      subtitle: Text(userInfo['role'] as String),
                      leading: const Icon(Icons.badge_outlined),
                    ),
                  ],
                ),
              ),
            )
                .animate()
                .fadeIn(delay: AppAnimations.medium)
                .slideY(begin: 0.1, end: 0),
                
            const SizedBox(height: AppTheme.spacingMd),
            
            ElevatedButton(
              onPressed: () {
                UiUtils.showSnackBar(
                  context,
                  message: 'Profile screen will be implemented soon!',
                  isSuccess: true,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingMd,
                  vertical: AppTheme.spacingSm,
                ),
              ),
              child: const Text('Edit Profile'),
            )
                .animate()
                .fadeIn(delay: AppAnimations.slow)
                .slideY(begin: 0.1, end: 0),
          ],
        ),
      ),
    );
  }
  
  /// Build a stat card widget
  Widget _buildStatCard(
    BuildContext context, 
    String title, 
    String value, 
    IconData icon,
    int index,
  ) {
    return Expanded(
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.spacingSm),
          child: Column(
            children: [
              Icon(
                icon,
                color: AppTheme.primaryColor,
              ),
              const SizedBox(height: AppTheme.spacingXs),
              Text(
                value,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: AppTheme.spacing2xs),
              Text(
                title,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onBackground.withOpacity(0.6),
                    ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    )
        .animate()
        .fadeIn(
          delay: Duration(milliseconds: 100 * index),
          duration: AppAnimations.medium,
        )
        .slideY(begin: 0.1, end: 0);
  }
  
  /// Build a section header with animation
  Widget _buildSectionHeader(BuildContext context, String title, int index) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
    )
        .animate()
        .fadeIn(
          delay: Duration(milliseconds: 200 + (100 * index)),
          duration: AppAnimations.medium,
        )
        .slideY(begin: 0.1, end: 0);
  }
  
  /// Format date for display
  String _formatDate(DateTime date) {
    final now = DateTime.now();
    
    if (date.year == now.year && date.month == now.month && date.day == now.day) {
      return 'Today, ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
    } else if (date.year == now.year && date.month == now.month && date.day == now.day + 1) {
      return 'Tomorrow, ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
    } else {
      final day = date.day.toString().padLeft(2, '0');
      final month = date.month.toString().padLeft(2, '0');
      return '$day/$month, ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
    }
  }
  
  /// Format time for display
  String _formatTime(DateTime time) {
    final now = DateTime.now();
    
    if (time.year == now.year && time.month == now.month && time.day == now.day) {
      return 'Today at ${time.hour}:${time.minute.toString().padLeft(2, '0')}';
    } else if (time.year == now.year && time.month == now.month && time.day == now.day + 1) {
      return 'Tomorrow at ${time.hour}:${time.minute.toString().padLeft(2, '0')}';
    } else {
      final day = time.day.toString().padLeft(2, '0');
      final month = time.month.toString().padLeft(2, '0');
      return '$day/$month at ${time.hour}:${time.minute.toString().padLeft(2, '0')}';
    }
  }
  
  /// Check if a class is starting soon (within next 30 minutes)
  bool _isClassSoon(DateTime classTime) {
    final now = DateTime.now();
    final difference = classTime.difference(now);
    return difference.inMinutes <= 30 && difference.inMinutes >= 0;
  }
  
  /// Get time ago string for a given date
  String _getTimeAgo(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays > 7) {
      return '${(difference.inDays / 7).floor()} weeks ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return 'Just now';
    }
  }
}
