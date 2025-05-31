/// Education model for user profile
class Education {
  final String id;
  final String institution;
  final String degree;
  final String? fieldOfStudy;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool isCurrentlyStudying;
  final String? description;

  Education({
    required this.id,
    required this.institution,
    required this.degree,
    this.fieldOfStudy,
    this.startDate,
    this.endDate,
    this.isCurrentlyStudying = false,
    this.description,
  });

  /// Create Education from JSON
  factory Education.fromJson(Map<String, dynamic> json) {
    return Education(
      id: json['id'] as String,
      institution: json['institution'] as String,
      degree: json['degree'] as String,
      fieldOfStudy: json['fieldOfStudy'] as String?,
      startDate: json['startDate'] != null
          ? DateTime.parse(json['startDate'] as String)
          : null,
      endDate: json['endDate'] != null
          ? DateTime.parse(json['endDate'] as String)
          : null,
      isCurrentlyStudying: json['isCurrentlyStudying'] as bool? ?? false,
      description: json['description'] as String?,
    );
  }

  /// Convert Education to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'institution': institution,
      'degree': degree,
      'fieldOfStudy': fieldOfStudy,
      'startDate': startDate?.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'isCurrentlyStudying': isCurrentlyStudying,
      'description': description,
    };
  }

  /// Create a copy with some fields changed
  Education copyWith({
    String? id,
    String? institution,
    String? degree,
    String? fieldOfStudy,
    DateTime? startDate,
    DateTime? endDate,
    bool? isCurrentlyStudying,
    String? description,
  }) {
    return Education(
      id: id ?? this.id,
      institution: institution ?? this.institution,
      degree: degree ?? this.degree,
      fieldOfStudy: fieldOfStudy ?? this.fieldOfStudy,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isCurrentlyStudying: isCurrentlyStudying ?? this.isCurrentlyStudying,
      description: description ?? this.description,
    );
  }
}
