import '../../../../core/constants/user_roles.dart';
import 'user.dart';

/// Mock user data for testing and development
class MockUserData {
  // Private constructor
  MockUserData._();

  /// Create a teacher user
  static User createTeacher() {
    return User(
      id: 'teacher-001',
      name: 'Rahul Sharma',
      email: 'rahul.sharma@example.com',
      role: UserRoles.teacher,
      phoneNumber: '9876543210',
      profileImage: 'https://randomuser.me/api/portraits/men/32.jpg',
      address: 'Sector 4, Gurgaon',
      bio: 'Experienced mathematics teacher with 8 years of teaching experience in CBSE curriculum.',
      roleSpecificData: {
        'subjects': ['Mathematics', 'Physics'],
        'experience': '8 years',
        'qualification': 'M.Sc. Mathematics, B.Ed.',
        'hourlyRate': '₹600-800',
        'ratings': 4.8,
      },
    );
  }

  /// Create a student user
  static User createStudent() {
    return User(
      id: 'student-001',
      name: 'Priya Patel',
      email: 'priya.patel@example.com',
      role: UserRoles.student,
      phoneNumber: '9876123450',
      profileImage: 'https://randomuser.me/api/portraits/women/44.jpg',
      address: 'Sector 15, Noida',
      bio: 'Class 11 student preparing for IIT-JEE',
      roleSpecificData: {
        'grade': 'Class 11',
        'school': 'Delhi Public School',
        'subjects': ['Mathematics', 'Physics', 'Chemistry'],
        'goals': ['IIT-JEE', 'KVPY'],
      },
    );
  }

  /// Create a coaching center user
  static User createCoachingCenter() {
    return User(
      id: 'coaching-001',
      name: 'Success Point Academy',
      email: 'admin@successpoint.edu',
      role: UserRoles.coachingCenter,
      phoneNumber: '9811223344',
      profileImage: 'https://example.com/logos/success-point.png',
      address: 'Block A, Sector 18, Delhi',
      bio: 'Premier coaching institute for IIT-JEE, NEET, and foundation courses for classes 8-12.',
      roleSpecificData: {
        'established': '2005',
        'branches': 3,
        'courses': ['IIT-JEE', 'NEET', 'Foundation'],
        'facilities': ['AC Classrooms', 'Library', 'Labs', 'Online Classes'],
        'ratings': 4.6,
      },
    );
  }

  /// Get mock user based on role
  static User getMockUser(String role) {
    switch (role) {
      case UserRoles.teacher:
        return createTeacher();
      case UserRoles.student:
        return createStudent();
      case UserRoles.coachingCenter:
        return createCoachingCenter();
      default:
        return createStudent();
    }
  }
}
