import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/user_roles.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/ui_utils.dart';
import '../../domain/providers/auth_state_provider.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  String _selectedRole = UserRoles.student; // Default role
  int _currentStep = 0;

  final List<String> _roleOptions = [
    UserRoles.student,
    UserRoles.educator,
    UserRoles.trainer,
    UserRoles.coachingCenter,
    UserRoles.school,
    UserRoles.college,
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Widget _buildRoleSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'I am a:',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: AppTheme.spacingMd),
        ...List.generate(
          _roleOptions.length,
          (index) => _buildRoleOption(_roleOptions[index]),
        ),
      ],
    );
  }

  Widget _buildRoleOption(String role) {
    final isSelected = _selectedRole == role;
    String roleImage;
    String roleDescription;

    // Assign appropriate icon and description based on role
    switch (role) {
      case UserRoles.student:
        roleImage = 'assets/icons/student.png';
        roleDescription = 'I want to find teachers & courses';
        break;
      case UserRoles.educator:
        roleImage = 'assets/icons/teacher.png';
        roleDescription = 'I want to teach students';
        break;
      case UserRoles.trainer:
        roleImage = 'assets/icons/trainer.png';
        roleDescription = 'I offer specialized training';
        break;
      case UserRoles.coachingCenter:
        roleImage = 'assets/icons/coaching.png';
        roleDescription = 'We provide coaching services';
        break;
      case UserRoles.school:
        roleImage = 'assets/icons/school.png';
        roleDescription = 'We are a school';
        break;
      case UserRoles.college:
        roleImage = 'assets/icons/college.png';
        roleDescription = 'We are a college/university';
        break;
      default:
        roleImage = 'assets/icons/student.png';
        roleDescription = 'Select your role';
    }

    // Use an Icon instead of an image since we don't have actual image assets yet
    return InkWell(
      onTap: () {
        setState(() {
          _selectedRole = role;
        });
      },
      borderRadius: BorderRadius.circular(AppTheme.borderRadius),
      child: Container(
        margin: const EdgeInsets.only(bottom: AppTheme.spacingSm),
        padding: const EdgeInsets.all(AppTheme.spacingSm),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? AppTheme.primaryColor : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(AppTheme.borderRadius),
          color: isSelected ? AppTheme.primaryColor.withOpacity(0.1) : null,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSelected ? AppTheme.primaryColor : Colors.grey.shade200,
                shape: BoxShape.circle,
              ),
              child: Icon(
                _getRoleIcon(role),
                color: isSelected ? Colors.white : Colors.grey,
                size: 24,
              ),
            ),
            const SizedBox(width: AppTheme.spacingMd),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _getRoleDisplayName(role),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isSelected ? AppTheme.primaryColor : null,
                    ),
                  ),
                  Text(
                    roleDescription,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: AppTheme.primaryColor,
                size: 24,
              ),
          ],
        ),
      ),
    ).animate(target: isSelected ? 1 : 0).scale(
          begin: const Offset(1, 1),
          end: const Offset(1.02, 1.02),
          duration: const Duration(milliseconds: 200),
        );
  }

  // Helper method to get role display name
  String _getRoleDisplayName(String role) {
    switch (role) {
      case UserRoles.student:
        return 'Student';
      case UserRoles.educator:
        return 'Teacher/Educator';
      case UserRoles.trainer:
        return 'Trainer';
      case UserRoles.coachingCenter:
        return 'Coaching Center';
      case UserRoles.school:
        return 'School';
      case UserRoles.college:
        return 'College/University';
      default:
        return role;
    }
  }

  // Helper method to get role icon
  IconData _getRoleIcon(String role) {
    switch (role) {
      case UserRoles.student:
        return Icons.school;
      case UserRoles.educator:
        return Icons.person;
      case UserRoles.trainer:
        return Icons.fitness_center;
      case UserRoles.coachingCenter:
        return Icons.business;
      case UserRoles.school:
        return Icons.account_balance;
      case UserRoles.college:
        return Icons.account_balance;
      default:
        return Icons.person;
    }
  }

  // Basic information form
  Widget _buildBasicInfoForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Full Name Field
        TextFormField(
          controller: _nameController,
          decoration: const InputDecoration(
            labelText: 'Full Name',
            hintText: 'Enter your full name',
            prefixIcon: Icon(Icons.person_outline),
          ),
          textInputAction: TextInputAction.next,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your name';
            }
            return null;
          },
        ),
        
        const SizedBox(height: AppTheme.spacingMd),
        
        // Email Field
        TextFormField(
          controller: _emailController,
          decoration: const InputDecoration(
            labelText: 'Email',
            hintText: 'Enter your email',
            prefixIcon: Icon(Icons.email_outlined),
          ),
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your email';
            }
            
            // Simple email validation
            final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
            if (!emailRegExp.hasMatch(value)) {
              return 'Please enter a valid email';
            }
            
            return null;
          },
        ),
        
        const SizedBox(height: AppTheme.spacingMd),
        
        // Phone Number Field
        TextFormField(
          controller: _phoneController,
          decoration: const InputDecoration(
            labelText: 'Phone Number',
            hintText: 'Enter your phone number',
            prefixIcon: Icon(Icons.phone_outlined),
          ),
          keyboardType: TextInputType.phone,
          textInputAction: TextInputAction.next,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your phone number';
            }
            
            // Simple phone validation (10 digits)
            final phoneRegExp = RegExp(r'^\d{10}$');
            if (!phoneRegExp.hasMatch(value)) {
              return 'Please enter a valid 10-digit phone number';
            }
            
            return null;
          },
        ),
      ],
    );
  }

  // Password form
  Widget _buildPasswordForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Password Field
        TextFormField(
          controller: _passwordController,
          obscureText: _obscurePassword,
          decoration: InputDecoration(
            labelText: 'Password',
            hintText: 'Create a password',
            prefixIcon: const Icon(Icons.lock_outline),
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
              ),
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a password';
            }
            if (value.length < 6) {
              return 'Password must be at least 6 characters';
            }
            return null;
          },
        ),
        
        const SizedBox(height: AppTheme.spacingMd),
        
        // Confirm Password Field
        TextFormField(
          controller: _confirmPasswordController,
          obscureText: _obscureConfirmPassword,
          decoration: InputDecoration(
            labelText: 'Confirm Password',
            hintText: 'Confirm your password',
            prefixIcon: const Icon(Icons.lock_outline),
            suffixIcon: IconButton(
              icon: Icon(
                _obscureConfirmPassword
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
              ),
              onPressed: () {
                setState(() {
                  _obscureConfirmPassword = !_obscureConfirmPassword;
                });
              },
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please confirm your password';
            }
            if (value != _passwordController.text) {
              return 'Passwords do not match';
            }
            return null;
          },
        ),
      ],
    );
  }

  bool _validateCurrentStep() {
    if (_currentStep == 0) {
      // No validation for role selection step
      return true;
    } else if (_currentStep == 1) {
      // Validate basic info form
      if (_nameController.text.isEmpty ||
          _emailController.text.isEmpty ||
          _phoneController.text.isEmpty) {
        return false;
      }
      
      // Simple email validation
      final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!emailRegExp.hasMatch(_emailController.text)) {
        return false;
      }
      
      // Simple phone validation (10 digits)
      final phoneRegExp = RegExp(r'^\d{10}$');
      if (!phoneRegExp.hasMatch(_phoneController.text)) {
        return false;
      }
      
      return true;
    }
    
    // Validate password form
    if (_passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      return false;
    }
    
    if (_passwordController.text.length < 6) {
      return false;
    }
    
    if (_passwordController.text != _confirmPasswordController.text) {
      return false;
    }
    
    return true;
  }

  void _goToNextStep() {
    if (_validateCurrentStep()) {
      setState(() {
        if (_currentStep < 2) {
          _currentStep++;
        } else {
          _handleSignup();
        }
      });
    } else {
      UiUtils.showSnackBar(
        context: context,
        message: 'Please fill in all required fields correctly',
        isError: true,
      );
    }
  }

  void _goToPreviousStep() {
    setState(() {
      if (_currentStep > 0) {
        _currentStep--;
      }
    });
  }

  Future<void> _handleSignup() async {
    if (_formKey.currentState!.validate()) {
      // Show loading indicator and handle sign up
      final authNotifier = ref.read(authStateProvider.notifier);
      final result = await authNotifier.register(
        email: _emailController.text.trim(),
        password: _passwordController.text,
        name: _nameController.text,
        phone: _phoneController.text,
        role: _selectedRole,
      );

      if (!mounted) return;

      if (result) {
        // Show success message
        UiUtils.showSnackBar(
          context: context,
          message: 'Account created successfully!',
          isError: false,
        );
        
        // Navigate back to login
        Navigator.pop(context);
      } else {
        // Show error message
        final error = ref.read(authStateProvider).errorMessage;
        UiUtils.showSnackBar(
          context: context,
          message: error ?? 'Sign up failed. Please try again.',
          isError: true,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (_currentStep > 0) {
              _goToPreviousStep();
            } else {
              Navigator.pop(context);
            }
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppTheme.spacing),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Progress indicator
                LinearProgressIndicator(
                  value: (_currentStep + 1) / 3,
                  backgroundColor: Colors.grey.shade300,
                  color: AppTheme.primaryColor,
                  minHeight: 8,
                  borderRadius: BorderRadius.circular(4),
                ),
                
                const SizedBox(height: AppTheme.spacingSm),
                
                // Step indicator
                Text(
                  'Step ${_currentStep + 1} of 3',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
                
                const SizedBox(height: AppTheme.spacingLg),
                
                // Step title
                Text(
                  _getStepTitle(),
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
                const SizedBox(height: AppTheme.spacing),
                
                // Step content
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: Container(
                    key: ValueKey<int>(_currentStep),
                    child: _buildStepContent(),
                  ),
                ),
                
                const SizedBox(height: AppTheme.spacingLg),
                
                // Navigation buttons
                Row(
                  children: [
                    if (_currentStep > 0)
                      Expanded(
                        flex: 1,
                        child: OutlinedButton(
                          onPressed: _goToPreviousStep,
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(AppTheme.borderRadiusMd),
                            ),
                          ),
                          child: const Text('Back'),
                        ),
                      ),
                      
                    if (_currentStep > 0)
                      const SizedBox(width: AppTheme.spacingSm),
                      
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        onPressed: authState.isLoading ? null : _goToNextStep,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppTheme.borderRadiusMd),
                          ),
                        ),
                        child: authState.isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 3,
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                _currentStep == 2 ? 'Create Account' : 'Next',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: AppTheme.spacing),
                
                if (_currentStep == 0)
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already have an account?'),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Login'),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getStepTitle() {
    switch (_currentStep) {
      case 0:
        return 'Select your role';
      case 1:
        return 'Personal Information';
      case 2:
        return 'Create Password';
      default:
        return '';
    }
  }

  Widget _buildStepContent() {
    switch (_currentStep) {
      case 0:
        return _buildRoleSelector();
      case 1:
        return _buildBasicInfoForm();
      case 2:
        return _buildPasswordForm();
      default:
        return const SizedBox.shrink();
    }
  }
}
