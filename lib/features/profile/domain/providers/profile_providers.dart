import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/index.dart';
import '../../data/repositories/index.dart';
import 'profile_state_provider.dart';

/// Provider for profile repository
final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepositoryImpl();
});

/// Provider for profile state
final profileStateProvider = StateNotifierProvider<ProfileNotifier, ProfileState>((ref) {
  final repository = ref.watch(profileRepositoryProvider);
  return ProfileNotifier(repository);
});

/// Provider for getting a profile by user ID
final profileProvider = FutureProvider.family<Profile?, String>((ref, userId) async {
  final repository = ref.watch(profileRepositoryProvider);
  return repository.getProfileByUserId(userId);
});
