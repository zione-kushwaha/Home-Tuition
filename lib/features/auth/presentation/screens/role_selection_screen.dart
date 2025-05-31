import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/constants/user_roles.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/animations/index.dart';

/// Role selection card widget
class RoleCard extends StatelessWidget {
  final String roleId;
  final String roleTitle;
  final String roleDescription;
  final bool isSelected;
  final VoidCallback onTap;
  final int index;

  const RoleCard({
    Key? key,
    required this.roleId,
    required this.roleTitle,
    required this.roleDescription,
    required this.isSelected,
    required this.onTap,
    required this.index,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final card = Card(
      elevation: isSelected ? 4 : 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusMd),
        side: BorderSide(
          color: isSelected ? AppTheme.primaryColor : Colors.transparent,
          width: 2,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppTheme.borderRadiusMd),
        child: Container(
          padding: const EdgeInsets.all(AppTheme.spacingMd),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    roleTitle,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? AppTheme.primaryColor
                          : Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                  if (isSelected)
                    Icon(Icons.check_circle, color: AppTheme.primaryColor),
                ],
              ),
              const SizedBox(height: AppTheme.spacingSm),
              Text(
                roleDescription,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onBackground.withOpacity(0.6),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    // Apply animation with proper delay based on index
    return card
        .animate(
          // Only animate when first appearing, not on rebuilds
          onPlay: (controller) => controller.forward(),
        )
        .fadeIn(
          duration: AppAnimations.medium,
          delay: Duration(milliseconds: 50 * index),
        )
        .slideY(
          begin: 0.2,
          end: 0,
          duration: AppAnimations.medium,
          delay: Duration(milliseconds: 50 * index),
          curve: Curves.easeOutCubic,
        );
  }
}

/// Role selection screen
class RoleSelectionScreen extends StatefulWidget {
  /// Callback when a role is selected
  final Function(String) onRoleSelected;

  /// Pre-selected role (optional)
  final String? initialRole;

  const RoleSelectionScreen({
    Key? key,
    required this.onRoleSelected,
    this.initialRole,
  }) : super(key: key);

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  String? _selectedRole;

  @override
  void initState() {
    super.initState();
    _selectedRole = widget.initialRole;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Your Role')),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppTheme.spacingMd),
              child: Text(
                'Choose the role that best describes you',
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(AppTheme.spacingSm),
                itemCount: UserRoles.allRoles.length,
                itemBuilder: (context, index) {
                  final role = UserRoles.allRoles[index];
                  final bool isSelected = _selectedRole == role['id'];

                  return Padding(
                    padding: const EdgeInsets.only(bottom: AppTheme.spacingSm),
                    child: RoleCard(
                      roleId: role['id']!,
                      roleTitle: role['name']!,
                      roleDescription: role['description']!,
                      isSelected: isSelected,
                      index: index,
                      onTap: () {
                        setState(() {
                          _selectedRole = role['id'];
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppTheme.spacingMd),
              child:
                  ElevatedButton(
                        onPressed: _selectedRole == null
                            ? null
                            : () {
                                widget.onRoleSelected(_selectedRole!);
                                Navigator.of(context).pop();
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryColor,
                          padding: const EdgeInsets.symmetric(
                            vertical: AppTheme.spacingSm,
                          ),
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              AppTheme.borderRadiusMd,
                            ),
                          ),
                        ),
                        child: Text(
                          'Continue',
                          style: Theme.of(
                            context,
                          ).textTheme.labelLarge?.copyWith(color: Colors.white),
                        ),
                      )
                      .animate()
                      .fadeIn(delay: const Duration(milliseconds: 300))
                      .slideY(begin: 0.2, end: 0),
            ),
          ],
        ),
      ),
    );
  }
}
