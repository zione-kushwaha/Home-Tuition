import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/ui_utils.dart';
import '../../data/models/index.dart';

/// Widget to edit profile information
class EditProfileForm extends StatefulWidget {
  final Profile profile;
  final Function(Profile) onSave;

  const EditProfileForm({
    Key? key,
    required this.profile,
    required this.onSave,
  }) : super(key: key);

  @override
  State<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String? _phoneNumber;
  late String? _address;
  late String? _bio;
  late String? _profileImageUrl;
  late List<Education> _education;
  late List<Experience> _experience;
  late List<Skill> _skills;
  late List<Certificate> _certificates;
  late Map<String, dynamic>? _roleSpecificData;

  @override
  void initState() {
    super.initState();
    _initFormValues();
  }

  /// Initialize form values from profile
  void _initFormValues() {
    _name = widget.profile.name;
    _phoneNumber = widget.profile.phoneNumber;
    _address = widget.profile.address;
    _bio = widget.profile.bio;
    _profileImageUrl = widget.profile.profileImageUrl;
    _education = widget.profile.education?.toList() ?? [];
    _experience = widget.profile.experience?.toList() ?? [];
    _skills = widget.profile.skills?.toList() ?? [];
    _certificates = widget.profile.certificates?.toList() ?? [];
    _roleSpecificData = widget.profile.roleSpecificData != null 
        ? Map<String, dynamic>.from(widget.profile.roleSpecificData!)
        : {};
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppTheme.spacingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile image editor
            _buildProfileImageEditor(),
            
            const SizedBox(height: AppTheme.spacingLg),
            
            // Basic information section
            _buildSectionTitle(context, 'Basic Information'),
            
            // Name field
            TextFormField(
              initialValue: _name,
              decoration: const InputDecoration(
                labelText: 'Full Name',
                hintText: 'Enter your full name',
                prefixIcon: Icon(Icons.person),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Name is required';
                }
                return null;
              },
              onSaved: (value) {
                if (value != null) _name = value;
              },
            ),
            
            const SizedBox(height: AppTheme.spacingMd),
            
            // Phone number field
            TextFormField(
              initialValue: _phoneNumber,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                hintText: 'Enter your phone number',
                prefixIcon: Icon(Icons.phone),
              ),
              keyboardType: TextInputType.phone,
              onSaved: (value) {
                _phoneNumber = value?.isNotEmpty == true ? value : null;
              },
            ),
            
            const SizedBox(height: AppTheme.spacingMd),
            
            // Address field
            TextFormField(
              initialValue: _address,
              maxLines: 2,
              decoration: const InputDecoration(
                labelText: 'Address',
                hintText: 'Enter your address',
                prefixIcon: Icon(Icons.location_on),
                alignLabelWithHint: true,
              ),
              onSaved: (value) {
                _address = value?.isNotEmpty == true ? value : null;
              },
            ),
            
            const SizedBox(height: AppTheme.spacingMd),
            
            // Bio field
            TextFormField(
              initialValue: _bio,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Bio',
                hintText: 'Tell us about yourself',
                alignLabelWithHint: true,
              ),
              onSaved: (value) {
                _bio = value?.isNotEmpty == true ? value : null;
              },
            ),
            
            const SizedBox(height: AppTheme.spacingLg),
            
            // Education section
            _buildSectionTitle(
              context, 
              'Education',
              hasAddButton: true,
              onAdd: _addNewEducation,
            ),
            ..._buildEducationItems(),
            
            const SizedBox(height: AppTheme.spacingLg),
            
            // Experience section
            _buildSectionTitle(
              context, 
              'Experience',
              hasAddButton: true,
              onAdd: _addNewExperience,
            ),
            ..._buildExperienceItems(),
            
            const SizedBox(height: AppTheme.spacingLg),
            
            // Skills section
            _buildSectionTitle(
              context, 
              'Skills',
              hasAddButton: true,
              onAdd: _addNewSkill,
            ),
            ..._buildSkillItems(),
            
            const SizedBox(height: AppTheme.spacingLg),
            
            // Certificates section
            _buildSectionTitle(
              context, 
              'Certificates',
              hasAddButton: true,
              onAdd: _addNewCertificate,
            ),
            ..._buildCertificateItems(),
            
            const SizedBox(height: AppTheme.spacingLg),
            
            // Role specific data section
            _buildRoleSpecificForm(),
            
            const SizedBox(height: AppTheme.spacingLg * 2),
            
            // Save button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _handleSave,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: AppTheme.spacingMd),
                  foregroundColor: Colors.white,
                  backgroundColor: AppTheme.primaryColor,
                ),
                child: const Text(
                  'Save Changes',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build profile image editor
  Widget _buildProfileImageEditor() {
    return Center(
      child: Column(
        children: [
          GestureDetector(
            onTap: () => _updateProfileImage(),
            child: Stack(
              children: [
                // Profile image
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppTheme.primaryColor,
                      width: 3,
                    ),
                    image: _profileImageUrl != null
                        ? DecorationImage(
                            image: NetworkImage(_profileImageUrl!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: _profileImageUrl == null
                      ? Icon(
                          Icons.person,
                          size: 60,
                          color: AppTheme.primaryColor,
                        )
                      : null,
                ),
                
                // Edit button overlay
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppTheme.spacingSm),
          TextButton(
            onPressed: () => _updateProfileImage(),
            child: const Text('Change Profile Picture'),
          ),
        ],
      ),
    );
  }

  /// Build section title with optional add button
  Widget _buildSectionTitle(
    BuildContext context, 
    String title, {
    bool hasAddButton = false,
    VoidCallback? onAdd,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppTheme.spacingMd),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryColor,
                ),
          ),
          if (hasAddButton && onAdd != null)
            IconButton(
              icon: const Icon(Icons.add_circle, color: AppTheme.primaryColor),
              onPressed: onAdd,
              tooltip: 'Add $title',
              visualDensity: VisualDensity.compact,
            ),
        ],
      ),
    );
  }

  /// Build education items
  List<Widget> _buildEducationItems() {
    if (_education.isEmpty) {
      return [
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: AppTheme.spacingMd),
            child: Text(
              'No education added yet. Tap + to add.',
              style: TextStyle(color: Colors.grey[600], fontStyle: FontStyle.italic),
            ),
          ),
        ),
      ];
    }

    return _education
        .asMap()
        .map((index, education) => MapEntry(
            index,
            Card(
              margin: const EdgeInsets.only(bottom: AppTheme.spacingMd),
              child: Padding(
                padding: const EdgeInsets.all(AppTheme.spacingMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            education.institutionName,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _editEducation(index),
                          tooltip: 'Edit',
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _removeEducation(index),
                          tooltip: 'Remove',
                        ),
                      ],
                    ),
                    const SizedBox(height: AppTheme.spacingSm),
                    Text(education.degree),
                  ],
                ),
              ),
            )))
        .values
        .toList();
  }

  /// Build experience items
  List<Widget> _buildExperienceItems() {
    if (_experience.isEmpty) {
      return [
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: AppTheme.spacingMd),
            child: Text(
              'No experience added yet. Tap + to add.',
              style: TextStyle(color: Colors.grey[600], fontStyle: FontStyle.italic),
            ),
          ),
        ),
      ];
    }

    return _experience
        .asMap()
        .map((index, experience) => MapEntry(
            index,
            Card(
              margin: const EdgeInsets.only(bottom: AppTheme.spacingMd),
              child: Padding(
                padding: const EdgeInsets.all(AppTheme.spacingMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            experience.title,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _editExperience(index),
                          tooltip: 'Edit',
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _removeExperience(index),
                          tooltip: 'Remove',
                        ),
                      ],
                    ),
                    const SizedBox(height: AppTheme.spacingSm),
                    Text(experience.company),
                  ],
                ),
              ),
            )))
        .values
        .toList();
  }

  /// Build skill items
  List<Widget> _buildSkillItems() {
    if (_skills.isEmpty) {
      return [
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: AppTheme.spacingMd),
            child: Text(
              'No skills added yet. Tap + to add.',
              style: TextStyle(color: Colors.grey[600], fontStyle: FontStyle.italic),
            ),
          ),
        ),
      ];
    }

    return [
      Wrap(
        spacing: AppTheme.spacingMd,
        runSpacing: AppTheme.spacingMd,
        children: _skills.asMap().entries.map((entry) {
          final index = entry.key;
          final skill = entry.value;
          return InputChip(
            label: Text(skill.name),
            deleteIcon: const Icon(Icons.close, size: 16),
            onDeleted: () => _removeSkill(index),
            onPressed: () => _editSkill(index),
            backgroundColor: Colors.grey[200],
            avatar: skill.proficiency != null
                ? CircleAvatar(
                    backgroundColor: _getProficiencyColor(skill.proficiency!),
                    radius: 12,
                    child: Text(
                      _getProficiencyInitial(skill.proficiency!),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : null,
          );
        }).toList(),
      )
    ];
  }

  /// Build certificate items
  List<Widget> _buildCertificateItems() {
    if (_certificates.isEmpty) {
      return [
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: AppTheme.spacingMd),
            child: Text(
              'No certificates added yet. Tap + to add.',
              style: TextStyle(color: Colors.grey[600], fontStyle: FontStyle.italic),
            ),
          ),
        ),
      ];
    }

    return _certificates
        .asMap()
        .map((index, certificate) => MapEntry(
            index,
            Card(
              margin: const EdgeInsets.only(bottom: AppTheme.spacingMd),
              child: Padding(
                padding: const EdgeInsets.all(AppTheme.spacingMd),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            certificate.name,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _editCertificate(index),
                          tooltip: 'Edit',
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _removeCertificate(index),
                          tooltip: 'Remove',
                        ),
                      ],
                    ),
                    const SizedBox(height: AppTheme.spacingSm),
                    Text(certificate.issuingOrganization),
                  ],
                ),
              ),
            )))
        .values
        .toList();
  }

  /// Build role specific form based on user role
  Widget _buildRoleSpecificForm() {
    // Based on the role, show different form fields
    switch (widget.profile.role) {
      case 'teacher':
        return _buildTeacherRoleForm();
      case 'student':
        return _buildStudentRoleForm();
      case 'institution':
        return _buildInstitutionRoleForm();
      default:
        return const SizedBox.shrink();
    }
  }

  /// Build teacher specific form fields
  Widget _buildTeacherRoleForm() {
    final data = _roleSpecificData ?? {};
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(context, 'Teaching Information'),
        
        // Teaching experience
        TextFormField(
          initialValue: data['teachingExperience']?.toString() ?? '',
          decoration: const InputDecoration(
            labelText: 'Teaching Experience (years)',
            hintText: 'Enter years of teaching experience',
            prefixIcon: Icon(Icons.school),
          ),
          keyboardType: TextInputType.number,
          onSaved: (value) {
            if (value != null && value.isNotEmpty) {
              _roleSpecificData ??= {};
              _roleSpecificData!['teachingExperience'] = int.tryParse(value) ?? 0;
            }
          },
        ),
        
        const SizedBox(height: AppTheme.spacingMd),
        
        // Subjects taught (to be implemented with multi-select)
        Text(
          'Subjects Taught',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const Text(
          'Tap to edit subjects you teach',
          style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
        ),
        
        const SizedBox(height: AppTheme.spacingSm),
        
        Wrap(
          spacing: AppTheme.spacingSm,
          runSpacing: AppTheme.spacingSm,
          children: [
            ..._getSubjectsList(data['subjectsTaught']),
            ActionChip(
              label: const Text('Add Subject'),
              avatar: const Icon(Icons.add, size: 16),
              onPressed: () => _editSubjectslist('subjectsTaught'),
            ),
          ],
        ),
        
        const SizedBox(height: AppTheme.spacingMd),
        
        // Teaching levels (to be implemented with multi-select)
        Text(
          'Teaching Levels',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const Text(
          'Tap to edit levels you teach',
          style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
        ),
        
        const SizedBox(height: AppTheme.spacingSm),
        
        Wrap(
          spacing: AppTheme.spacingSm,
          runSpacing: AppTheme.spacingSm,
          children: [
            ..._getSubjectsList(data['teachingLevels']),
            ActionChip(
              label: const Text('Add Level'),
              avatar: const Icon(Icons.add, size: 16),
              onPressed: () => _editSubjectslist('teachingLevels'),
            ),
          ],
        ),
      ],
    );
  }

  /// Build student specific form fields
  Widget _buildStudentRoleForm() {
    final data = _roleSpecificData ?? {};
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(context, 'Student Information'),
        
        // Current institution
        TextFormField(
          initialValue: data['currentInstitution']?.toString() ?? '',
          decoration: const InputDecoration(
            labelText: 'Current School/Institution',
            hintText: 'Enter your current school or institution',
            prefixIcon: Icon(Icons.school),
          ),
          onSaved: (value) {
            if (value != null && value.isNotEmpty) {
              _roleSpecificData ??= {};
              _roleSpecificData!['currentInstitution'] = value;
            }
          },
        ),
        
        const SizedBox(height: AppTheme.spacingMd),
        
        // Current grade/class
        TextFormField(
          initialValue: data['currentGrade']?.toString() ?? '',
          decoration: const InputDecoration(
            labelText: 'Current Grade/Class',
            hintText: 'Enter your current grade or class',
            prefixIcon: Icon(Icons.class_),
          ),
          onSaved: (value) {
            if (value != null && value.isNotEmpty) {
              _roleSpecificData ??= {};
              _roleSpecificData!['currentGrade'] = value;
            }
          },
        ),
        
        const SizedBox(height: AppTheme.spacingMd),
        
        // Subjects of interest (to be implemented with multi-select)
        Text(
          'Subjects of Interest',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const Text(
          'Tap to edit subjects you are interested in',
          style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
        ),
        
        const SizedBox(height: AppTheme.spacingSm),
        
        Wrap(
          spacing: AppTheme.spacingSm,
          runSpacing: AppTheme.spacingSm,
          children: [
            ..._getSubjectsList(data['subjectsOfInterest']),
            ActionChip(
              label: const Text('Add Subject'),
              avatar: const Icon(Icons.add, size: 16),
              onPressed: () => _editSubjectslist('subjectsOfInterest'),
            ),
          ],
        ),
      ],
    );
  }

  /// Build institution specific form fields
  Widget _buildInstitutionRoleForm() {
    final data = _roleSpecificData ?? {};
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(context, 'Institution Information'),
        
        // Institution type
        DropdownButtonFormField<String>(
          value: data['institutionType']?.toString(),
          decoration: const InputDecoration(
            labelText: 'Institution Type',
            hintText: 'Select institution type',
            prefixIcon: Icon(Icons.business),
          ),
          items: const [
            DropdownMenuItem(value: 'School', child: Text('School')),
            DropdownMenuItem(value: 'College', child: Text('College')),
            DropdownMenuItem(value: 'University', child: Text('University')),
            DropdownMenuItem(value: 'Coaching Center', child: Text('Coaching Center')),
            DropdownMenuItem(value: 'Training Institute', child: Text('Training Institute')),
            DropdownMenuItem(value: 'Other', child: Text('Other')),
          ],
          onChanged: (value) {
            if (value != null) {
              setState(() {
                _roleSpecificData ??= {};
                _roleSpecificData!['institutionType'] = value;
              });
            }
          },
          onSaved: (value) {
            if (value != null) {
              _roleSpecificData ??= {};
              _roleSpecificData!['institutionType'] = value;
            }
          },
        ),
        
        const SizedBox(height: AppTheme.spacingMd),
        
        // Establishment year
        TextFormField(
          initialValue: data['establishmentYear']?.toString() ?? '',
          decoration: const InputDecoration(
            labelText: 'Establishment Year',
            hintText: 'Enter year of establishment',
            prefixIcon: Icon(Icons.calendar_today),
          ),
          keyboardType: TextInputType.number,
          onSaved: (value) {
            if (value != null && value.isNotEmpty) {
              _roleSpecificData ??= {};
              _roleSpecificData!['establishmentYear'] = int.tryParse(value) ?? 0;
            }
          },
        ),
        
        const SizedBox(height: AppTheme.spacingMd),
        
        // Student count
        TextFormField(
          initialValue: data['studentCount']?.toString() ?? '',
          decoration: const InputDecoration(
            labelText: 'Number of Students',
            hintText: 'Enter approximate number of students',
            prefixIcon: Icon(Icons.people),
          ),
          keyboardType: TextInputType.number,
          onSaved: (value) {
            if (value != null && value.isNotEmpty) {
              _roleSpecificData ??= {};
              _roleSpecificData!['studentCount'] = int.tryParse(value) ?? 0;
            }
          },
        ),
        
        const SizedBox(height: AppTheme.spacingMd),
        
        // Programs offered (to be implemented with multi-select)
        Text(
          'Programs Offered',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const Text(
          'Tap to edit programs offered by your institution',
          style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
        ),
        
        const SizedBox(height: AppTheme.spacingSm),
        
        Wrap(
          spacing: AppTheme.spacingSm,
          runSpacing: AppTheme.spacingSm,
          children: [
            ..._getSubjectsList(data['programsOffered']),
            ActionChip(
              label: const Text('Add Program'),
              avatar: const Icon(Icons.add, size: 16),
              onPressed: () => _editSubjectslist('programsOffered'),
            ),
          ],
        ),
      ],
    );
  }

  /// Get subjects/programs list as chips
  List<Widget> _getSubjectsList(List<dynamic>? items) {
    if (items == null || items.isEmpty) {
      return [];
    }
    
    return items.asMap().entries.map((entry) {
      final index = entry.key;
      final item = entry.value.toString();
      return InputChip(
        label: Text(item),
        onDeleted: () => _removeListItem(items, index),
        deleteIcon: const Icon(Icons.close, size: 16),
      );
    }).toList();
  }
  
  /// Remove item from a list in role specific data
  void _removeListItem(List<dynamic> items, int index) {
    setState(() {
      items.removeAt(index);
    });
  }
  
  /// Edit subjects/programs list
  void _editSubjectslist(String field) {
    // Implement a dialog to edit the list
    UiUtils.showSnackBar(
      context,
      message: 'Editing $field feature coming soon',
      isSuccess: true,
    );
  }

  /// Update profile image
  void _updateProfileImage() {
    // Implement image picker and update logic
    UiUtils.showSnackBar(
      context,
      message: 'Image upload feature coming soon',
      isSuccess: true,
    );
  }

  /// Add new education item
  void _addNewEducation() {
    // Implement education editor dialog
    final newEducation = Education(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      institutionName: '',
      degree: '',
      startDate: DateTime.now().subtract(const Duration(days: 365)),
    );
    
    setState(() {
      _education.add(newEducation);
    });
    
    // Open editor for the new item
    _editEducation(_education.length - 1);
  }

  /// Edit education item
  void _editEducation(int index) {
    // Implement education editor dialog
    UiUtils.showSnackBar(
      context,
      message: 'Education editor coming soon',
      isSuccess: true,
    );
  }

  /// Remove education item
  void _removeEducation(int index) {
    setState(() {
      _education.removeAt(index);
    });
  }

  /// Add new experience item
  void _addNewExperience() {
    // Implement experience editor dialog
    final newExperience = Experience(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: '',
      company: '',
      startDate: DateTime.now().subtract(const Duration(days: 365)),
    );
    
    setState(() {
      _experience.add(newExperience);
    });
    
    // Open editor for the new item
    _editExperience(_experience.length - 1);
  }

  /// Edit experience item
  void _editExperience(int index) {
    // Implement experience editor dialog
    UiUtils.showSnackBar(
      context,
      message: 'Experience editor coming soon',
      isSuccess: true,
    );
  }

  /// Remove experience item
  void _removeExperience(int index) {
    setState(() {
      _experience.removeAt(index);
    });
  }

  /// Add new skill item
  void _addNewSkill() {
    // Implement skill editor dialog
    final newSkill = Skill(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: '',
    );
    
    setState(() {
      _skills.add(newSkill);
    });
    
    // Open editor for the new item
    _editSkill(_skills.length - 1);
  }

  /// Edit skill item
  void _editSkill(int index) {
    // Implement skill editor dialog
    UiUtils.showSnackBar(
      context,
      message: 'Skill editor coming soon',
      isSuccess: true,
    );
  }

  /// Remove skill item
  void _removeSkill(int index) {
    setState(() {
      _skills.removeAt(index);
    });
  }

  /// Add new certificate item
  void _addNewCertificate() {
    // Implement certificate editor dialog
    final newCertificate = Certificate(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: '',
      issuingOrganization: '',
      issueDate: DateTime.now(),
    );
    
    setState(() {
      _certificates.add(newCertificate);
    });
    
    // Open editor for the new item
    _editCertificate(_certificates.length - 1);
  }

  /// Edit certificate item
  void _editCertificate(int index) {
    // Implement certificate editor dialog
    UiUtils.showSnackBar(
      context,
      message: 'Certificate editor coming soon',
      isSuccess: true,
    );
  }

  /// Remove certificate item
  void _removeCertificate(int index) {
    setState(() {
      _certificates.removeAt(index);
    });
  }

  /// Get color based on proficiency level
  Color _getProficiencyColor(String proficiency) {
    switch (proficiency.toLowerCase()) {
      case 'beginner':
        return Colors.blue;
      case 'intermediate':
        return Colors.green;
      case 'advanced':
        return Colors.orange;
      case 'expert':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
  
  /// Get proficiency initial letter
  String _getProficiencyInitial(String proficiency) {
    return proficiency.isNotEmpty ? proficiency[0].toUpperCase() : '';
  }

  /// Handle form submission
  void _handleSave() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      
      // Create updated profile
      final updatedProfile = widget.profile.copyWith(
        name: _name,
        phoneNumber: _phoneNumber,
        address: _address,
        bio: _bio,
        profileImageUrl: _profileImageUrl,
        education: _education,
        experience: _experience,
        skills: _skills,
        certificates: _certificates,
        roleSpecificData: _roleSpecificData,
      );
      
      // Pass to parent
      widget.onSave(updatedProfile);
    }
  }
}
