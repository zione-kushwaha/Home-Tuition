import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../data/models/skill.dart';

/// Widget to display a skill as a chip in the profile
class SkillChip extends StatelessWidget {
  final Skill skill;

  const SkillChip({
    Key? key,
    required this.skill,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Define colors based on proficiency
    Color? chipColor;
    Color? textColor;
    
    switch (skill.proficiency?.toLowerCase()) {
      case 'beginner':
        chipColor = Colors.blue[50];
        textColor = Colors.blue[800];
        break;
      case 'intermediate':
        chipColor = Colors.green[50];
        textColor = Colors.green[800];
        break;
      case 'advanced':
        chipColor = Colors.orange[50];
        textColor = Colors.orange[800];
        break;
      case 'expert':
        chipColor = Colors.red[50];
        textColor = Colors.red[800];
        break;
      default:
        chipColor = Colors.grey[200];
        textColor = Colors.grey[800];
    }

    return Tooltip(
      message: skill.proficiency != null ? 'Proficiency: ${skill.proficiency}' : '',
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.spacingMd,
          vertical: AppTheme.spacingSm,
        ),
        decoration: BoxDecoration(
          color: chipColor,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: textColor?.withOpacity(0.3) ?? Colors.transparent,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              skill.name,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
            if (skill.proficiency != null) ...[
              const SizedBox(width: 4),
              _buildProficiencyDots(skill.proficiency!.toLowerCase()),
            ],
          ],
        ),
      ),
    );
  }
  
  /// Build dots to represent proficiency level
  Widget _buildProficiencyDots(String proficiency) {
    int dotCount;
    
    switch (proficiency) {
      case 'beginner':
        dotCount = 1;
        break;
      case 'intermediate':
        dotCount = 2;
        break;
      case 'advanced':
        dotCount = 3;
        break;
      case 'expert':
        dotCount = 4;
        break;
      default:
        dotCount = 0;
    }
    
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(4, (index) {
        return Container(
          width: 4,
          height: 4,
          margin: const EdgeInsets.only(left: 2),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index < dotCount
                ? Colors.black.withOpacity(0.7)
                : Colors.black.withOpacity(0.2),
          ),
        );
      }),
    );
  }
}
