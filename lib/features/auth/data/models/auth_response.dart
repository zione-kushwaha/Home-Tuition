import 'user.dart';

/// Response model for authentication operations
class AuthResponse {
  final bool success;
  final User? user;
  final String? token;
  final String? errorMessage;

  AuthResponse({
    required this.success,
    this.user,
    this.token,
    this.errorMessage,
  });

  /// Create from successful authentication
  factory AuthResponse.success({User? user, String? token}) {
    return AuthResponse(
      success: true,
      user: user,
      token: token,
    );
  }

  /// Create from failed authentication
  factory AuthResponse.failure({String? errorMessage}) {
    return AuthResponse(
      success: false,
      errorMessage: errorMessage ?? 'Authentication failed',
    );
  }
}