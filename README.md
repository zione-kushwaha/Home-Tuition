# Home Tuition App - Authentication System

This document outlines the authentication system implementation for the Home Tuition app.

## Architecture

The authentication system follows clean architecture principles with:

- **Core Layer**: Contains reusable components shared across the app
- **Feature Layer**: Contains auth feature with clear separation of concerns
- **Data Layer**: Repositories and models for auth data
- **Domain Layer**: Business logic and state management
- **Presentation Layer**: UI components for auth screens

## Folder Structure

```
lib/
├── core/
│   ├── constants/
│   │   ├── app_constants.dart
│   │   ├── app_strings.dart
│   │   └── index.dart
│   ├── theme/
│   │   └── app_theme.dart
│   ├── utils/
│   │   ├── validators.dart
│   │   ├── ui_utils.dart
│   │   └── index.dart
│   └── widgets/
│       ├── app_text_field.dart
│       ├── app_buttons.dart
│       └── index.dart
├── features/
│   └── auth/
│       ├── data/
│       │   ├── models/
│       │   │   ├── user.dart
│       │   │   ├── auth_response.dart
│       │   │   └── index.dart
│       │   └── repositories/
│       │       ├── auth_repository.dart
│       │       └── index.dart
│       ├── domain/
│       │   └── providers/
│       │       ├── auth_providers.dart
│       │       ├── auth_state_provider.dart
│       │       └── index.dart
│       └── presentation/
│           ├── screens/
│           │   ├── splash_screen.dart
│           │   ├── login_screen.dart
│           │   ├── register_screen.dart
│           │   ├── forgot_password_screen.dart
│           │   └── index.dart
│           └── widgets/
│               ├── auth_logo.dart
│               └── index.dart
├── router/
│   └── app_router.dart
└── main.dart
```

## Theme Implementation

- Color Palette:

  - Primary: Deep blue (#2E3B4E)
  - Secondary: Soft green (#4CAF50)
  - Accent: Warm orange (#FF9800)
  - Background: Light gray (#F5F5F5)
  - Text: Dark gray (#333333)

- Typography:

  - Font family: Poppins
  - Hierarchical type scale with consistent sizing
  - Text styles for various UI elements

- Components:
  - Custom text fields with floating labels
  - Styled buttons (primary, secondary, text)
  - Error/success states
  - Loading indicators

## Authentication Flow

1. **App Launch**:

   - Splash screen displays while checking auth status
   - Redirects based on authentication state

2. **User Authentication**:

   - Login with email/password
   - New user registration
   - Password reset functionality

3. **Form Validation**:

   - Input validation with clear error messages
   - Field-specific validation rules
   - Password strength requirements

4. **State Management**:

   - Uses Riverpod for managing auth state
   - Centralized authentication providers
   - Clean separation of UI and business logic

5. **Navigation**:
   - GoRouter for declarative routing
   - Route protection based on auth state
   - Deep linking support

## How to Use

1. **Login Implementation**:

   - Use `LoginScreen` for user authentication
   - State is managed via `authStateProvider`

2. **Registration**:

   - Use `RegisterScreen` for new user sign up
   - Validation handled by `Validators` utility

3. **Password Reset**:

   - Use `ForgotPasswordScreen` for password recovery flow

4. **Auth State Access**:

   - Access authentication state via `ref.watch(authStateProvider)`
   - Check if user is authenticated with `ref.watch(isAuthenticatedProvider)`
   - Get current user with `ref.watch(currentUserProvider)`

5. **Protected Routes**:
   - Router automatically handles protected routes
   - Redirects unauthenticated users to login

## Form Validation Example

```dart
// Email validation
Validators.validateEmail(email)

// Password validation
Validators.validatePassword(password)

// Confirm password validation
Validators.validateConfirmPassword(passwordController)(confirmPassword)
```

## UI Components

- `AppTextField`: Consistent styled text input fields
- `PrimaryButton`: Main call-to-action buttons
- `SecondaryButton`: Alternative action buttons
- `TextActionButton`: Text-only buttons for minor actions

## Error Handling

Error states are managed in the `AuthState` class and displayed via snackbars using:

```dart
UiUtils.showSnackBar(
  context,
  message: errorMessage,
  isError: true,
);
```

## Future Improvements

- Social media authentication integration
- Biometric authentication
- Two-factor authentication
- Account verification flow
- Session management and token refresh
