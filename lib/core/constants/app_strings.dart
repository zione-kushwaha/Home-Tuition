/// Contains string constants used throughout the app
class AppStrings {
  // Private constructor to prevent instantiation
  AppStrings._();
  
  // App name
  static const String appName = 'GDA EDU WORLD';

  // Auth screen strings
  static const String welcomeBack = 'Welcome Back';
  static const String signIn = 'Sign In';
  static const String signUp = 'Sign Up';
  static const String createAccount = 'Create an Account';
  static const String forgotPassword = 'Forgot Password?';
  static const String resetPassword = 'Reset Password';
  static const String dontHaveAccount = "Don't have an account?";
  static const String alreadyHaveAccount = 'Already have an account?';

  // Form field labels
  static const String email = 'Email';
  static const String password = 'Password';
  static const String confirmPassword = 'Confirm Password';
  static const String fullName = 'Full Name';
  static const String phoneNumber = 'Phone Number';

  // Validation error messages
  static const String requiredField = 'This field is required';
  static const String invalidEmail = 'Please enter a valid email address';
  static const String passwordTooShort =
      'Password must be at least 8 characters';
  static const String passwordsDontMatch = 'Passwords do not match';
  static const String invalidPhoneNumber = 'Please enter a valid phone number';

  // Button text
  static const String login = 'Login';
  static const String register = 'Register';
  static const String submit = 'Submit';
  static const String continueText = 'Continue';

  // Success and error messages
  static const String passwordResetSent =
      'Password reset link sent to your email';
  static const String accountCreatedSuccess = 'Account created successfully';
  static const String somethingWentWrong =
      'Something went wrong. Please try again.';
}
