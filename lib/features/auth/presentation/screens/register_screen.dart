import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/constants/index.dart';
import '../../../../core/utils/index.dart';
import '../../../../core/utils/ui_utils.dart';
import '../../../../core/widgets/index.dart';
import '../../../../core/animations/index.dart';
import '../../domain/providers/auth_state_provider.dart';
import '../../domain/providers/index.dart';
import '../widgets/index.dart';
import 'role_selection_screen.dart';

/// Registration screen for new user sign up
class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _addressController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  String? _selectedRole;
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    // Add post-frame callback to check for errors
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkForErrors();
    });
  }

  void _checkForErrors() {
    // Show error message if there is one
    final authState = ref.read(authStateProvider);
    if (authState.errorMessage != null) {
      UiUtils.showSnackBar(
        context,
        message: authState.errorMessage!,
        isError: true,
      );

      // Clear the error
      ref.read(authStateProvider.notifier).clearError();
    }
  }
  /// Handle role selection
  void _selectRole() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => RoleSelectionScreen(
          initialRole: _selectedRole,
          onRoleSelected: (role) {
            setState(() {
              _selectedRole = role;
            });
          },
        ),
      ),
    );
  }

  /// Handle registration button press
  Future<void> _handleRegister() async {
    if (_selectedRole == null) {
      UiUtils.showSnackBar(
        context, 
        message: 'Please select a role to continue',
        isError: true,
      );
      return;
    }
    
    if (_formKey.currentState!.validate()) {
      // Hide keyboard
      FocusScope.of(context).unfocus();

      final success = await ref
          .read(authStateProvider.notifier)
          .register(
            name: _nameController.text.trim(),
            email: _emailController.text.trim(),
            password: _passwordController.text,
            role: _selectedRole!,
            phoneNumber: _phoneController.text.trim(),
            address: _addressController.text.trim(),
          );

      if (success && mounted) {
        // Registration successful, navigation will be handled by the router
      }
    }
  }

  void _navigateToLogin() {
    // Navigator named routes will be replaced with GoRouter in the router setup
    Navigator.of(context).pushReplacementNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    // Listen to auth state
    final authState = ref.watch(authStateProvider);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // App Logo Placeholder
                  const AuthLogo(),

                  const SizedBox(height: 32),

                  // Create Account Text
                  Text(
                    AppStrings.createAccount,
                    style: Theme.of(context).textTheme.displayLarge,
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 8),

                  Text(
                    AppStrings.signUp,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(
                        context,
                      ).colorScheme.onBackground.withOpacity(0.6),
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 32),

                  // Full Name Field
                  AppTextField(
                    label: AppStrings.fullName,
                    controller: _nameController,
                    validator: Validators.validateRequired,
                    textInputAction: TextInputAction.next,
                    prefix: const Icon(Icons.person_outline),
                  ),

                  const SizedBox(height: 24),

                  // Email Field
                  AppTextField(
                    label: AppStrings.email,
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: Validators.validateEmail,
                    textInputAction: TextInputAction.next,
                    prefix: const Icon(Icons.email_outlined),
                  ),

                  const SizedBox(height: 24),                  // Phone Field
                  AppTextField(
                    label: AppStrings.phoneNumber,
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    validator: Validators.validatePhone,
                    textInputAction: TextInputAction.next,
                    prefix: const Icon(Icons.phone_outlined),
                  ),

                  const SizedBox(height: 24),
                  
                  // Address Field
                  AppTextField(
                    label: "Address",
                    controller: _addressController,
                    validator: Validators.validateRequired,
                    textInputAction: TextInputAction.next,
                    prefix: const Icon(Icons.location_on_outlined),
                  ),

                  const SizedBox(height: 24),
                  
                  // Role Selection Button
                  InkWell(
                    onTap: _selectRole,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Theme.of(context).colorScheme.onBackground.withOpacity(0.3),
                            width: 1.0,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.person_outline),
                          const SizedBox(width: 12.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Your Role',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                const SizedBox(height: 4.0),
                                Text(
                                  _selectedRole == null 
                                    ? 'Select your role'
                                    : UserRoles.getDisplayName(_selectedRole!),
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                            color: Theme.of(context).colorScheme.onBackground.withOpacity(0.6),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Password Field
                  AppTextField(
                    label: AppStrings.password,
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    validator: Validators.validatePassword,
                    textInputAction: TextInputAction.next,
                    prefix: const Icon(Icons.lock_outline),
                    suffix: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Confirm Password Field
                  AppTextField(
                    label: AppStrings.confirmPassword,
                    controller: _confirmPasswordController,
                    obscureText: _obscureConfirmPassword,
                    validator: Validators.validateConfirmPassword(
                      _passwordController,
                    ),
                    textInputAction: TextInputAction.done,
                    onEditingComplete: () => _handleRegister(),
                    prefix: const Icon(Icons.lock_outline),
                    suffix: IconButton(
                      icon: Icon(
                        _obscureConfirmPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureConfirmPassword = !_obscureConfirmPassword;
                        });
                      },
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Register Button
                  PrimaryButton(
                    text: AppStrings.register,
                    onPressed: _handleRegister,
                    isLoading: authState.isLoading,
                  ),

                  const SizedBox(height: 24),

                  // Sign In Option
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppStrings.alreadyHaveAccount,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      TextActionButton(
                        text: AppStrings.signIn,
                        onPressed: _navigateToLogin,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
