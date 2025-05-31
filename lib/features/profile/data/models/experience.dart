/// Experience model for user profile
class Experience {
  final String id;
  final String title;
  final String organization;
  final String? location;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool isCurrentPosition;
  final String? description;

  Experience({
    required this.id,
    required this.title,
    required this.organization,
    this.location,
    this.startDate,
    this.endDate,
    this.isCurrentPosition = false,
    this.description,
  });

  /// Create Experience from JSON
  factory Experience.fromJson(Map<String, dynamic> json) {
    return Experience(
      id: json['id'] as String,
      title: json['title'] as String,
      organization: json['organization'] as String,
      location: json['location'] as String?,
      startDate: json['startDate'] != null
          ? DateTime.parse(json['startDate'] as String)
          : null,
      endDate: json['endDate'] != null
          ? DateTime.parse(json['endDate'] as String)
          : null,
      isCurrentPosition: json['isCurrentPosition'] as bool? ?? false,
      description: json['description'] as String?,
    );
  }

  /// Convert Experience to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'organization': organization,
      'location': location,
      'startDate': startDate?.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'isCurrentPosition': isCurrentPosition,
      'description': description,
    };
  }

  /// Create a copy with some fields changed
  Experience copyWith({
    String? id,
    String? title,
    String? organization,
    String? location,
    DateTime? startDate,
    DateTime? endDate,
    bool? isCurrentPosition,
    String? description,
  }) {
    return Experience(
      id: id ?? this.id,
      title: title ?? this.title,
      organization: organization ?? this.organization,
      location: location ?? this.location,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isCurrentPosition: isCurrentPosition ?? this.isCurrentPosition,
      description: description ?? this.description,
    );
  }
}
