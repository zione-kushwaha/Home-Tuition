import '../../../../core/constants/user_roles.dart';

/// User model class
class User {
  final String id;
  final String name;
  final String email;
  final String role;
  final String? phoneNumber;
  final String? profileImage;
  final Map<String, dynamic>? roleSpecificData;
  final String? address;
  final String? bio;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.phoneNumber,
    this.profileImage,
    this.roleSpecificData,
    this.address,
    this.bio,
  });

  /// Get role display name
  String get roleDisplayName => UserRoles.getDisplayName(role);

  /// Check if user is a teacher
  bool get isTeacher => role == UserRoles.teacher;

  /// Check if user is a student
  bool get isStudent => role == UserRoles.student;

  /// Check if user is a trainer
  bool get isTrainer => role == UserRoles.trainer;

  /// Check if user is a coaching center
  bool get isCoachingCenter => role == UserRoles.coachingCenter;

  /// Check if user is a school
  bool get isSchool => role == UserRoles.school;

  /// Check if user is a college
  bool get isCollege => role == UserRoles.college;

  /// Check if user is an institution (coaching center, school, college)
  bool get isInstitution => 
    isCoachingCenter || isSchool || isCollege;

  /// Check if user is an educator (teacher, trainer)
  bool get isEducator => isTeacher || isTrainer;

  /// Create a User from JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
      phoneNumber: json['phoneNumber'] as String?,
      profileImage: json['profileImage'] as String?,
      roleSpecificData: json['roleSpecificData'] as Map<String, dynamic>?,
      address: json['address'] as String?,
      bio: json['bio'] as String?,
    );
  }

  /// Convert User to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role,
      'phoneNumber': phoneNumber,
      'profileImage': profileImage,
      'roleSpecificData': roleSpecificData,
      'address': address,
      'bio': bio,
    };
  }

  /// Create a copy with some fields changed
  User copyWith({
    String? id,
    String? name,
    String? email,
    String? role,
    String? phoneNumber,
    String? profileImage,
    Map<String, dynamic>? roleSpecificData,
    String? address,
    String? bio,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profileImage: profileImage ?? this.profileImage,
      roleSpecificData: roleSpecificData ?? this.roleSpecificData,
      address: address ?? this.address,
      bio: bio ?? this.bio,
    );
  }
}
