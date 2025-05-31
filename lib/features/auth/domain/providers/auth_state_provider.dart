import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/index.dart';
import '../../data/repositories/index.dart';
import 'auth_providers.dart';

/// Auth state for managing authentication flow
class AuthState {
  final User? user;
  final bool isLoading;
  final bool isAuthenticated;
  final String? errorMessage;

  AuthState({
    this.user,
    this.isLoading = false,
    this.isAuthenticated = false,
    this.errorMessage,
  });

  /// Create a copy with some fields changed
  AuthState copyWith({
    User? user,
    bool? isLoading,
    bool? isAuthenticated,
    String? errorMessage,
    bool clearError = false,
  }) {
    return AuthState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }
}

/// Auth notifier to manage authentication state
class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _authRepository;

  AuthNotifier(this._authRepository) : super(AuthState()) {
    _initialize();
  }

  /// Initialize by checking if user is already logged in
  Future<void> _initialize() async {
    final isLoggedIn = await _authRepository.isLoggedIn();
    if (isLoggedIn) {
      final user = await _authRepository.getCurrentUser();
      state = state.copyWith(isAuthenticated: true, user: user);
    }
  }

  /// Sign in with email and password
  Future<bool> signIn({required String email, required String password}) async {
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      final response = await _authRepository.signIn(
        email: email,
        password: password,
      );

      if (response.success) {
        state = state.copyWith(
          isLoading: false,
          isAuthenticated: true,
          user: response.user,
        );
        return true;
      } else {
        state = state.copyWith(
          isLoading: false,
          errorMessage: response.errorMessage ?? 'Authentication failed',
          isAuthenticated: false,
        );
        return false;
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
        isAuthenticated: false,
      );
      return false;
    }
  }
  /// Register a new user
  Future<bool> register({
    required String name,
    required String email,
    required String password,
    required String role,
    String? phoneNumber,
    String? address,
    Map<String, dynamic>? roleSpecificData,
  }) async {
    state = state.copyWith(isLoading: true, clearError: true);

    try {      final response = await _authRepository.register(
        name: name,
        email: email,
        password: password,
        role: role,
        phoneNumber: phoneNumber,
        address: address,
        roleSpecificData: roleSpecificData,
      );

      if (response.success) {
        state = state.copyWith(
          isLoading: false,
          isAuthenticated: true,
          user: response.user,
        );
        return true;
      } else {
        state = state.copyWith(
          isLoading: false,
          errorMessage: response.errorMessage ?? 'Registration failed',
          isAuthenticated: false,
        );
        return false;
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
        isAuthenticated: false,
      );
      return false;
    }
  }

  /// Send password reset email
  Future<bool> sendPasswordResetEmail(String email) async {
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      final success = await _authRepository.sendPasswordResetEmail(email);

      state = state.copyWith(isLoading: false);
      return success;
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
      return false;
    }
  }

  /// Sign out user
  Future<void> signOut() async {
    state = state.copyWith(isLoading: true);
    await _authRepository.signOut();
    state = AuthState();
  }

  /// Clear any error message
  void clearError() {
    if (state.errorMessage != null) {
      state = state.copyWith(clearError: true);
    }
  }
}

/// Provider for the auth state
final authStateProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthNotifier(authRepository);
});

/// Provider that exposes whether the user is authenticated
final isAuthenticatedProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.isAuthenticated;
});

/// Provider that exposes the current user
final currentUserProvider = Provider<User?>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.user;
});
