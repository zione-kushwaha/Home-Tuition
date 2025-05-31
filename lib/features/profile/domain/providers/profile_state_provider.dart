import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/index.dart';
import '../../data/repositories/index.dart';

/// Profile state for managing profile data and operations
class ProfileState {
  final bool isLoading;
  final String? errorMessage;
  final Profile? profile;
  final bool isEditMode;
  
  ProfileState({
    this.isLoading = false,
    this.errorMessage,
    this.profile,
    this.isEditMode = false,
  });
  
  /// Create a copy with some fields changed
  ProfileState copyWith({
    bool? isLoading,
    String? errorMessage,
    Profile? profile,
    bool? isEditMode,
    bool clearError = false,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      profile: profile ?? this.profile,
      isEditMode: isEditMode ?? this.isEditMode,
    );
  }
}

/// Profile notifier for managing profile state
class ProfileNotifier extends StateNotifier<ProfileState> {
  final ProfileRepository _profileRepository;
  
  ProfileNotifier(this._profileRepository) : super(ProfileState());
  
  /// Load profile by user ID
  Future<void> loadProfile(String userId) async {
    state = state.copyWith(isLoading: true, clearError: true);
    
    try {
      final profile = await _profileRepository.getProfileByUserId(userId);
      state = state.copyWith(
        isLoading: false,
        profile: profile,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }
  
  /// Update profile information
  Future<bool> updateProfile(Profile updatedProfile) async {
    state = state.copyWith(isLoading: true, clearError: true);
    
    try {
      final profile = await _profileRepository.updateProfile(updatedProfile);
      state = state.copyWith(
        isLoading: false,
        profile: profile,
        isEditMode: false,
      );
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
      return false;
    }
  }
  
  /// Update profile picture
  Future<bool> updateProfilePicture(String filePath) async {
    if (state.profile == null) return false;
    
    state = state.copyWith(isLoading: true, clearError: true);
    
    try {
      final pictureUrl = await _profileRepository.updateProfilePicture(
        state.profile!.userId,
        filePath,
      );
      
      final updatedProfile = state.profile!.copyWith(
        profileImageUrl: pictureUrl,
      );
      
      state = state.copyWith(
        isLoading: false,
        profile: updatedProfile,
      );
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
      return false;
    }
  }
  
  /// Add new education
  Future<bool> addEducation(Education education) async {
    if (state.profile == null) return false;
    
    state = state.copyWith(isLoading: true, clearError: true);
    
    try {
      final newEducation = await _profileRepository.addEducation(
        state.profile!.userId,
        education,
      );
      
      final currentEducations = state.profile!.education ?? [];
      final updatedEducations = [...currentEducations, newEducation];
      
      final updatedProfile = state.profile!.copyWith(
        education: updatedEducations,
      );
      
      state = state.copyWith(
        isLoading: false,
        profile: updatedProfile,
      );
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
      return false;
    }
  }
  
  /// Update existing education
  Future<bool> updateEducation(Education education) async {
    if (state.profile == null) return false;
    
    state = state.copyWith(isLoading: true, clearError: true);
    
    try {
      final updatedEducation = await _profileRepository.updateEducation(
        state.profile!.userId,
        education,
      );
      
      final currentEducations = state.profile!.education ?? [];
      final updatedEducations = currentEducations.map((e) =>
        e.id == education.id ? updatedEducation : e
      ).toList();
      
      final updatedProfile = state.profile!.copyWith(
        education: updatedEducations,
      );
      
      state = state.copyWith(
        isLoading: false,
        profile: updatedProfile,
      );
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
      return false;
    }
  }
  
  /// Delete education
  Future<bool> deleteEducation(String educationId) async {
    if (state.profile == null) return false;
    
    state = state.copyWith(isLoading: true, clearError: true);
    
    try {
      final success = await _profileRepository.deleteEducation(
        state.profile!.userId,
        educationId,
      );
      
      if (success) {
        final currentEducations = state.profile!.education ?? [];
        final updatedEducations = currentEducations
          .where((e) => e.id != educationId)
          .toList();
        
        final updatedProfile = state.profile!.copyWith(
          education: updatedEducations,
        );
        
        state = state.copyWith(
          isLoading: false,
          profile: updatedProfile,
        );
      } else {
        state = state.copyWith(isLoading: false);
      }
      
      return success;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
      return false;
    }
  }
  
  /// Add new experience
  Future<bool> addExperience(Experience experience) async {
    if (state.profile == null) return false;
    
    state = state.copyWith(isLoading: true, clearError: true);
    
    try {
      final newExperience = await _profileRepository.addExperience(
        state.profile!.userId,
        experience,
      );
      
      final currentExperiences = state.profile!.experience ?? [];
      final updatedExperiences = [...currentExperiences, newExperience];
      
      final updatedProfile = state.profile!.copyWith(
        experience: updatedExperiences,
      );
      
      state = state.copyWith(
        isLoading: false,
        profile: updatedProfile,
      );
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
      return false;
    }
  }
  
  /// Update existing experience
  Future<bool> updateExperience(Experience experience) async {
    if (state.profile == null) return false;
    
    state = state.copyWith(isLoading: true, clearError: true);
    
    try {
      final updatedExperience = await _profileRepository.updateExperience(
        state.profile!.userId,
        experience,
      );
      
      final currentExperiences = state.profile!.experience ?? [];
      final updatedExperiences = currentExperiences.map((e) =>
        e.id == experience.id ? updatedExperience : e
      ).toList();
      
      final updatedProfile = state.profile!.copyWith(
        experience: updatedExperiences,
      );
      
      state = state.copyWith(
        isLoading: false,
        profile: updatedProfile,
      );
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
      return false;
    }
  }
  
  /// Delete experience
  Future<bool> deleteExperience(String experienceId) async {
    if (state.profile == null) return false;
    
    state = state.copyWith(isLoading: true, clearError: true);
    
    try {
      final success = await _profileRepository.deleteExperience(
        state.profile!.userId,
        experienceId,
      );
      
      if (success) {
        final currentExperiences = state.profile!.experience ?? [];
        final updatedExperiences = currentExperiences
          .where((e) => e.id != experienceId)
          .toList();
        
        final updatedProfile = state.profile!.copyWith(
          experience: updatedExperiences,
        );
        
        state = state.copyWith(
          isLoading: false,
          profile: updatedProfile,
        );
      } else {
        state = state.copyWith(isLoading: false);
      }
      
      return success;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
      return false;
    }
  }
  
  /// Toggle edit mode
  void toggleEditMode() {
    state = state.copyWith(isEditMode: !state.isEditMode);
  }
  
  /// Clear error message
  void clearError() {
    if (state.errorMessage != null) {
      state = state.copyWith(clearError: true);
    }
  }
}
