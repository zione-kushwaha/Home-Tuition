/// Constants for user roles in the system
class UserRoles {
  // Private constructor to prevent instantiation
  UserRoles._();

  // Role identifiers
  static const String teacher = 'TEACHER';
  static const String student = 'STUDENT';
  static const String trainer = 'TRAINER';
  static const String coachingCenter = 'COACHING_CENTER';
  static const String school = 'SCHOOL';
  static const String college = 'COLLEGE';

  // Role display names
  static const String teacherDisplay = 'Teacher';
  static const String studentDisplay = 'Student';
  static const String trainerDisplay = 'Trainer';
  static const String coachingCenterDisplay = 'Coaching Center';
  static const String schoolDisplay = 'School';
  static const String collegeDisplay = 'College';

  // Get all roles as map for selection
  static List<Map<String, String>> get allRoles => [
    {'id': teacher, 'name': teacherDisplay, 'description': 'Teach students and find teaching opportunities'},
    {'id': student, 'name': studentDisplay, 'description': 'Learn from teachers and access educational resources'},
    {'id': trainer, 'name': trainerDisplay, 'description': 'Conduct training sessions and workshops'},
    {'id': coachingCenter, 'name': coachingCenterDisplay, 'description': 'Manage coaching center activities and hire teachers'},
    {'id': school, 'name': schoolDisplay, 'description': 'Manage school resources and hire teachers'},
    {'id': college, 'name': collegeDisplay, 'description': 'Manage college resources and hire educators'},
  ];

  // Get role display name from role ID
  static String getDisplayName(String roleId) {
    switch (roleId) {
      case teacher:
        return teacherDisplay;
      case student:
        return studentDisplay;
      case trainer:
        return trainerDisplay;
      case coachingCenter:
        return coachingCenterDisplay;
      case school:
        return schoolDisplay;
      case college:
        return collegeDisplay;
      default:
        return 'Unknown Role';
    }
  }
}
