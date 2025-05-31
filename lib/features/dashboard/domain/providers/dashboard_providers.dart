import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../auth/data/repositories/index.dart';
import '../../../auth/domain/providers/auth_providers.dart';
import '../../../auth/data/models/user.dart';

/// Dashboard state class
class DashboardState {
  final bool isLoading;
  final String? errorMessage;
  
  // Additional dashboard data can be added here
  final Map<String, dynamic>? dashboardData;
  
  DashboardState({
    this.isLoading = false,
    this.errorMessage,
    this.dashboardData,
  });
  
  /// Create a copy with some fields changed
  DashboardState copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? dashboardData,
    bool clearError = false,
  }) {
    return DashboardState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      dashboardData: dashboardData ?? this.dashboardData,
    );
  }
}

/// Dashboard notifier for managing dashboard state
class DashboardNotifier extends StateNotifier<DashboardState> {
  final AuthRepository _authRepository;
  
  DashboardNotifier(this._authRepository) : super(DashboardState()) {
    loadDashboardData();
  }
  
  /// Load dashboard data based on the current user
  Future<void> loadDashboardData() async {
    state = state.copyWith(isLoading: true, clearError: true);
    
    try {
      final user = await _authRepository.getCurrentUser();
      
      if (user != null) {
        // In a real application, we would fetch dashboard data from an API
        // For demo purposes, we'll create mock data based on the user's role
        final dashboardData = await _getMockDashboardData(user);
        
        state = state.copyWith(
          isLoading: false,
          dashboardData: dashboardData,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          errorMessage: 'User not found',
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }
  
  /// Get mock dashboard data based on user role
  Future<Map<String, dynamic>> _getMockDashboardData(User user) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Create different dashboard data based on user role
    switch (user.role) {
      case 'TEACHER':
        return {
          'stats': {
            'applications': 12,
            'interviews': 5,
            'offers': 2,
          },
          'upcomingInterviews': [
            {
              'id': '1',
              'schoolName': 'Greenfield Academy',
              'position': 'Science Teacher',
              'date': DateTime.now().add(const Duration(days: 2)),
              'location': 'Online Interview',
            },
            {
              'id': '2',
              'schoolName': 'Excel Coaching Center',
              'position': 'Math Tutor',
              'date': DateTime.now().add(const Duration(days: 5)),
              'location': 'In-Person',
            },
          ],
          'recentJobPostings': [
            {
              'id': '1',
              'title': 'Physics Teacher',
              'institution': 'Bright Future School',
              'salary': '₹25,000 - ₹35,000',
              'location': 'Delhi',
              'postedDate': DateTime.now().subtract(const Duration(days: 2)),
            },
            {
              'id': '2',
              'title': 'Home Tutor for Grade 10',
              'institution': 'Private',
              'salary': '₹500 - ₹800 per hour',
              'location': 'Mumbai',
              'postedDate': DateTime.now().subtract(const Duration(days: 1)),
            },
            {
              'id': '3',
              'title': 'Chemistry Faculty',
              'institution': 'Success Point Coaching',
              'salary': '₹30,000 - ₹45,000',
              'location': 'Bangalore',
              'postedDate': DateTime.now().subtract(const Duration(hours: 12)),
            },
          ],
        };
      
      case 'STUDENT':
        return {
          'stats': {
            'enrolledCourses': 3,
            'completedAssignments': 15,
            'questionsAsked': 7,
          },
          'upcomingClasses': [
            {
              'id': '1',
              'subject': 'Advanced Mathematics',
              'teacher': 'Dr. Sharma',
              'time': DateTime.now().add(const Duration(hours: 3)),
              'duration': '1 hour',
            },
            {
              'id': '2',
              'subject': 'Physics',
              'teacher': 'Mrs. Gupta',
              'time': DateTime.now().add(const Duration(hours: 26)),
              'duration': '1.5 hours',
            },
          ],
          'recentQuestions': [
            {
              'id': '1',
              'question': 'How to solve quadratic equations?',
              'subject': 'Mathematics',
              'answers': 3,
              'timestamp': DateTime.now().subtract(const Duration(days: 1)),
            },
            {
              'id': '2',
              'question': 'Explain Newton\'s third law with examples',
              'subject': 'Physics',
              'answers': 2,
              'timestamp': DateTime.now().subtract(const Duration(days: 3)),
            },
          ],
        };
      
      case 'COACHING_CENTER':
      case 'SCHOOL':
      case 'COLLEGE':
        return {
          'stats': {
            'totalTeachers': 15,
            'totalStudents': 120,
            'activeJobs': 5,
          },
          'teacherApplications': [
            {
              'id': '1',
              'name': 'Rahul Sharma',
              'position': 'Mathematics Teacher',
              'experience': '5 years',
              'appliedDate': DateTime.now().subtract(const Duration(days: 1)),
            },
            {
              'id': '2',
              'name': 'Priya Malhotra',
              'position': 'Science Faculty',
              'experience': '3 years',
              'appliedDate': DateTime.now().subtract(const Duration(hours: 6)),
            },
          ],
          'studentEnrollments': [
            {
              'id': '1',
              'name': 'Amit Kumar',
              'course': 'IIT-JEE Advanced',
              'enrollmentDate': DateTime.now().subtract(const Duration(days: 2)),
            },
            {
              'id': '2',
              'name': 'Sneha Patel',
              'course': 'NEET Preparation',
              'enrollmentDate': DateTime.now().subtract(const Duration(days: 1)),
            },
          ],
        };
      
      default:
        return {
          'message': 'Welcome to GDA EDU WORLD',
          'userInfo': {
            'name': user.name,
            'email': user.email,
            'role': user.roleDisplayName,
          },
        };
    }
  }
  
  /// Clear any error message
  void clearError() {
    if (state.errorMessage != null) {
      state = state.copyWith(clearError: true);
    }
  }
}

/// Provider for the dashboard state
final dashboardStateProvider = StateNotifierProvider<DashboardNotifier, DashboardState>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return DashboardNotifier(authRepository);
});
