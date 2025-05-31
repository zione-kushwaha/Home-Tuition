/// Job model to represent education job postings
class Job {
  final String id;
  final String title;
  final String institutionId;
  final String institutionName;
  final String description;
  final String salary;
  final String location;
  final List<String> subjects;
  final List<String> requirements;
  final DateTime postedDate;
  final DateTime? applicationDeadline;
  final String jobType; // Full-time, Part-time, Contract, etc.
  final int applicationsCount;
  final bool isActive;
  final String? contactEmail;
  final String? contactPhone;

  Job({
    required this.id,
    required this.title,
    required this.institutionId,
    required this.institutionName,
    required this.description,
    required this.salary,
    required this.location,
    required this.subjects,
    required this.requirements,
    required this.postedDate,
    this.applicationDeadline,
    required this.jobType,
    this.applicationsCount = 0,
    this.isActive = true,
    this.contactEmail,
    this.contactPhone,
  });

  /// Create Job from JSON
  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['id'] as String,
      title: json['title'] as String,
      institutionId: json['institutionId'] as String,
      institutionName: json['institutionName'] as String,
      description: json['description'] as String,
      salary: json['salary'] as String,
      location: json['location'] as String,
      subjects: List<String>.from(json['subjects'] as List),
      requirements: List<String>.from(json['requirements'] as List),
      postedDate: DateTime.parse(json['postedDate'] as String),
      applicationDeadline: json['applicationDeadline'] != null
          ? DateTime.parse(json['applicationDeadline'] as String)
          : null,
      jobType: json['jobType'] as String,
      applicationsCount: json['applicationsCount'] as int? ?? 0,
      isActive: json['isActive'] as bool? ?? true,
      contactEmail: json['contactEmail'] as String?,
      contactPhone: json['contactPhone'] as String?,
    );
  }

  /// Convert Job to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'institutionId': institutionId,
      'institutionName': institutionName,
      'description': description,
      'salary': salary,
      'location': location,
      'subjects': subjects,
      'requirements': requirements,
      'postedDate': postedDate.toIso8601String(),
      'applicationDeadline': applicationDeadline?.toIso8601String(),
      'jobType': jobType,
      'applicationsCount': applicationsCount,
      'isActive': isActive,
      'contactEmail': contactEmail,
      'contactPhone': contactPhone,
    };
  }

  /// Create a copy with some fields changed
  Job copyWith({
    String? id,
    String? title,
    String? institutionId,
    String? institutionName,
    String? description,
    String? salary,
    String? location,
    List<String>? subjects,
    List<String>? requirements,
    DateTime? postedDate,
    DateTime? applicationDeadline,
    String? jobType,
    int? applicationsCount,
    bool? isActive,
    String? contactEmail,
    String? contactPhone,
  }) {
    return Job(
      id: id ?? this.id,
      title: title ?? this.title,
      institutionId: institutionId ?? this.institutionId,
      institutionName: institutionName ?? this.institutionName,
      description: description ?? this.description,
      salary: salary ?? this.salary,
      location: location ?? this.location,
      subjects: subjects ?? this.subjects,
      requirements: requirements ?? this.requirements,
      postedDate: postedDate ?? this.postedDate,
      applicationDeadline: applicationDeadline ?? this.applicationDeadline,
      jobType: jobType ?? this.jobType,
      applicationsCount: applicationsCount ?? this.applicationsCount,
      isActive: isActive ?? this.isActive,
      contactEmail: contactEmail ?? this.contactEmail,
      contactPhone: contactPhone ?? this.contactPhone,
    );
  }
}
