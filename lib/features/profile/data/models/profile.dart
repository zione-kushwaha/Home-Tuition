import 'index.dart';

/// Profile model to represent user profile data
class Profile {
  final String id;
  final String userId;
  final String name;
  final String email;
  final String role;
  final String? phoneNumber;
  final String? profileImageUrl;
  final String? address;
  final String? bio;
  final Map<String, dynamic>? roleSpecificData;
  final List<Education>? education;
  final List<Experience>? experience;
  final List<Skill>? skills;
  final List<Certificate>? certificates;

  Profile({
    required this.id,
    required this.userId,
    required this.name,
    required this.email,
    required this.role,
    this.phoneNumber,
    this.profileImageUrl,
    this.address,
    this.bio,
    this.roleSpecificData,
    this.education,
    this.experience,
    this.skills,
    this.certificates,
  });

  /// Create Profile from JSON
  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'] as String,
      userId: json['userId'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      role: json['role'] as String,
      phoneNumber: json['phoneNumber'] as String?,
      profileImageUrl: json['profileImageUrl'] as String?,
      address: json['address'] as String?,
      bio: json['bio'] as String?,
      roleSpecificData: json['roleSpecificData'] as Map<String, dynamic>?,
      education: json['education'] != null
          ? (json['education'] as List)
                .map((e) => Education.fromJson(e as Map<String, dynamic>))
                .toList()
          : null,
      experience: json['experience'] != null
          ? (json['experience'] as List)
                .map((e) => Experience.fromJson(e as Map<String, dynamic>))
                .toList()
          : null,
      skills: json['skills'] != null
          ? (json['skills'] as List)
                .map((e) => Skill.fromJson(e as Map<String, dynamic>))
                .toList()
          : null,
      certificates: json['certificates'] != null
          ? (json['certificates'] as List)
                .map((e) => Certificate.fromJson(e as Map<String, dynamic>))
                .toList()
          : null,
    );
  }

  /// Convert Profile to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'name': name,
      'email': email,
      'role': role,
      'phoneNumber': phoneNumber,
      'profileImageUrl': profileImageUrl,
      'address': address,
      'bio': bio,
      'roleSpecificData': roleSpecificData,
      'education': education?.map((e) => e.toJson()).toList(),
      'experience': experience?.map((e) => e.toJson()).toList(),
      'skills': skills?.map((e) => e.toJson()).toList(),
      'certificates': certificates?.map((e) => e.toJson()).toList(),
    };
  }

  /// Create a copy with some fields changed
  Profile copyWith({
    String? id,
    String? userId,
    String? name,
    String? email,
    String? role,
    String? phoneNumber,
    String? profileImageUrl,
    String? address,
    String? bio,
    Map<String, dynamic>? roleSpecificData,
    List<Education>? education,
    List<Experience>? experience,
    List<Skill>? skills,
    List<Certificate>? certificates,
  }) {
    return Profile(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      address: address ?? this.address,
      bio: bio ?? this.bio,
      roleSpecificData: roleSpecificData ?? this.roleSpecificData,
      education: education ?? this.education,
      experience: experience ?? this.experience,
      skills: skills ?? this.skills,
      certificates: certificates ?? this.certificates,
    );
  }
}
