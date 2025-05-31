import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/index.dart';
import '../models/mock_user_data.dart';
import '../../../../core/constants/index.dart';

/// Authentication repository interface
abstract class AuthRepository {
  /// Sign in with email and password
  Future<AuthResponse> signIn({
    required String email,
    required String password,
  });

  /// Register a new user
  Future<AuthResponse> register({
    required String name,
    required String email,
    required String password,
    required String role,
    String? phoneNumber,
    String? address,
    Map<String, dynamic>? roleSpecificData,
  });

  /// Send password reset email
  Future<bool> sendPasswordResetEmail(String email);

  /// Sign out user
  Future<void> signOut();

  /// Check if user is logged in
  Future<bool> isLoggedIn();

  /// Get current authenticated user
  Future<User?> getCurrentUser();

  /// Get auth token
  Future<String?> getToken();
}

/// Implementation of the AuthRepository using local storage
/// This is a mock implementation for demonstration purposes
/// In a real app, you would connect this to your backend API
class AuthRepositoryImpl implements AuthRepository {
  final SharedPreferences _prefs;

  AuthRepositoryImpl(this._prefs);

  @override
  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {    // For demo purposes, we'll simulate a successful auth
    // In a real app, you would make an API call here

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    
    // Accept any combination for demo purposes
    if (email.contains('@') && password.length >= 6) {
      // Determine mock user type based on email domain
      String role = UserRoles.student;
      if (email.contains('teacher')) {
        role = UserRoles.teacher;
      } else if (email.contains('coach') || email.contains('academy')) {
        role = UserRoles.coachingCenter;
      }
      
      // Get appropriate mock user
      final user = MockUserData.getMockUser(role);

      final token = 'demo_token_${DateTime.now().millisecondsSinceEpoch}';

      // Save to local storage
      await _prefs.setBool(AppConstants.isLoggedInKey, true);
      await _prefs.setString(AppConstants.authTokenKey, token);
      await _prefs.setString(
        AppConstants.userDataKey,
        jsonEncode(user.toJson()),
      );

      return AuthResponse.success(user: user, token: token);    } else {
      return AuthResponse.failure(errorMessage: 'Invalid email or password');
    }
  }
  @override
  Future<AuthResponse> register({
    required String name,
    required String email,
    required String password,
    required String role,
    String? phoneNumber,
    String? address,
    Map<String, dynamic>? roleSpecificData,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // For demo purposes, we'll simulate a successful registration
    final user = User(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      email: email,
      role: role,
      phoneNumber: phoneNumber,
      address: address,
      roleSpecificData: roleSpecificData,
    );

    final token = 'demo_token_${DateTime.now().millisecondsSinceEpoch}';

    // Save to local storage
    await _prefs.setBool(AppConstants.isLoggedInKey, true);
    await _prefs.setString(AppConstants.authTokenKey, token);
    await _prefs.setString(AppConstants.userDataKey, jsonEncode(user.toJson()));

    return AuthResponse.success(user: user, token: token);
  }

  @override
  Future<bool> sendPasswordResetEmail(String email) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Always return success for demo
    return true;
  }

  @override
  Future<void> signOut() async {
    // Clear stored user data
    await _prefs.remove(AppConstants.isLoggedInKey);
    await _prefs.remove(AppConstants.authTokenKey);
    await _prefs.remove(AppConstants.userDataKey);
  }

  @override
  Future<bool> isLoggedIn() async {
    return _prefs.getBool(AppConstants.isLoggedInKey) ?? false;
  }

  @override
  Future<User?> getCurrentUser() async {
    final userData = _prefs.getString(AppConstants.userDataKey);
    if (userData != null) {
      try {
        return User.fromJson(jsonDecode(userData));
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  @override
  Future<String?> getToken() async {
    return _prefs.getString(AppConstants.authTokenKey);
  }
}
