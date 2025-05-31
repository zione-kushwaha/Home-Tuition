/// App-wide constants
class AppConstants {
  // Private constructor to prevent instantiation
  AppConstants._();

  // SharedPreferences keys
  static const String isLoggedInKey = 'is_logged_in';
  static const String authTokenKey = 'auth_token';
  static const String userDataKey = 'user_data';
  static const String firstLaunchKey = 'first_launch';
  static const String themeModeKey = 'theme_mode';

  // API endpoints (for real implementation)
  static const String baseUrl = 'https://api.gdaeduworld.com/v1';
  static const String loginEndpoint = '/auth/login';
  static const String registerEndpoint = '/auth/register';
  static const String resetPasswordEndpoint = '/auth/reset-password';
  static const String userProfileEndpoint = '/user/profile';

  // Asset paths
  static const String imagesPath = 'assets/images';
  static const String animationsPath = 'assets/animations';
  static const String iconsPath = 'assets/icons';

  // Pagination defaults
  static const int defaultPageSize = 10;
  static const int maxPageSize = 50;
  
  // Form validation
  static const int minPasswordLength = 8;
  static const int maxNameLength = 50;
  static const int maxBioLength = 300;
}