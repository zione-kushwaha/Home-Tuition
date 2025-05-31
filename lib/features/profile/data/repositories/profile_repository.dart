import '../models/index.dart';
import 'mock_profile_data.dart';

/// Repository for managing user profiles
abstract class ProfileRepository {
  /// Get profile by user ID
  Future<Profile?> getProfileByUserId(String userId);

  /// Create or update profile
  Future<Profile> updateProfile(Profile profile);

  /// Update profile picture
  Future<String> updateProfilePicture(String userId, String filePath);

  /// Add education to profile
  Future<Education> addEducation(String userId, Education education);

  /// Update education
  Future<Education> updateEducation(String userId, Education education);

  /// Delete education
  Future<bool> deleteEducation(String userId, String educationId);

  /// Add experience to profile
  Future<Experience> addExperience(String userId, Experience experience);

  /// Update experience
  Future<Experience> updateExperience(String userId, Experience experience);

  /// Delete experience
  Future<bool> deleteExperience(String userId, String experienceId);

  /// Add skill to profile
  Future<Skill> addSkill(String userId, Skill skill);

  /// Update skill
  Future<Skill> updateSkill(String userId, Skill skill);

  /// Delete skill
  Future<bool> deleteSkill(String userId, String skillId);

  /// Add certificate to profile
  Future<Certificate> addCertificate(String userId, Certificate certificate);

  /// Update certificate
  Future<Certificate> updateCertificate(String userId, Certificate certificate);

  /// Delete certificate
  Future<bool> deleteCertificate(String userId, String certificateId);
}

/// Implementation of ProfileRepository with mock data
class ProfileRepositoryImpl implements ProfileRepository {
  @override
  Future<Profile?> getProfileByUserId(String userId) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      return MockProfileData.getMockProfiles().firstWhere(
        (profile) => profile.userId == userId,
      );
    } catch (e) {
      return null;
    }
  }

  @override
  Future<Profile> updateProfile(Profile profile) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    // In a real app, we'd send this to a backend service
    return profile;
  }

  @override
  Future<String> updateProfilePicture(String userId, String filePath) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 1200));

    // Mock upload and return a CDN URL
    return 'https://randomuser.me/api/portraits/men/32.jpg';
  }

  @override
  Future<Education> addEducation(String userId, Education education) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 600));

    // In a real app, we'd send this to a backend service
    return education;
  }

  @override
  Future<Education> updateEducation(String userId, Education education) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 600));

    // In a real app, we'd send this to a backend service
    return education;
  }

  @override
  Future<bool> deleteEducation(String userId, String educationId) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 400));

    // In a real app, we'd send this to a backend service
    return true;
  }

  @override
  Future<Experience> addExperience(String userId, Experience experience) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 600));

    // In a real app, we'd send this to a backend service
    return experience;
  }

  @override
  Future<Experience> updateExperience(
    String userId,
    Experience experience,
  ) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 600));

    // In a real app, we'd send this to a backend service
    return experience;
  }

  @override
  Future<bool> deleteExperience(String userId, String experienceId) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 400));

    // In a real app, we'd send this to a backend service
    return true;
  }

  @override
  Future<Skill> addSkill(String userId, Skill skill) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 400));

    // In a real app, we'd send this to a backend service
    return skill;
  }

  @override
  Future<Skill> updateSkill(String userId, Skill skill) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 400));

    // In a real app, we'd send this to a backend service
    return skill;
  }

  @override
  Future<bool> deleteSkill(String userId, String skillId) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));

    // In a real app, we'd send this to a backend service
    return true;
  }

  @override
  Future<Certificate> addCertificate(
    String userId,
    Certificate certificate,
  ) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    // In a real app, we'd send this to a backend service
    return certificate;
  }

  @override
  Future<Certificate> updateCertificate(
    String userId,
    Certificate certificate,
  ) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    // In a real app, we'd send this to a backend service
    return certificate;
  }

  @override
  Future<bool> deleteCertificate(String userId, String certificateId) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));

    // In a real app, we'd send this to a backend service
    return true;
  }
}
