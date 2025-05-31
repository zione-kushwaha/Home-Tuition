/// Model for job applications by teachers
class JobApplication {
  final String id;
  final String jobId;
  final String userId;
  final String userName;
  final String? userProfileImage;
  final String? coverLetter;
  final String? resumeUrl;
  final DateTime appliedDate;
  final String status; // Pending, Reviewed, Shortlisted, Rejected, Accepted
  final DateTime? statusUpdatedDate;
  final String? feedback;
  final double? rating;

  JobApplication({
    required this.id,
    required this.jobId,
    required this.userId,
    required this.userName,
    this.userProfileImage,
    this.coverLetter,
    this.resumeUrl,
    required this.appliedDate,
    required this.status,
    this.statusUpdatedDate,
    this.feedback,
    this.rating,
  });

  /// Create JobApplication from JSON
  factory JobApplication.fromJson(Map<String, dynamic> json) {
    return JobApplication(
      id: json['id'] as String,
      jobId: json['jobId'] as String,
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      userProfileImage: json['userProfileImage'] as String?,
      coverLetter: json['coverLetter'] as String?,
      resumeUrl: json['resumeUrl'] as String?,
      appliedDate: DateTime.parse(json['appliedDate'] as String),
      status: json['status'] as String,
      statusUpdatedDate: json['statusUpdatedDate'] != null
          ? DateTime.parse(json['statusUpdatedDate'] as String)
          : null,
      feedback: json['feedback'] as String?,
      rating: json['rating'] as double?,
    );
  }

  /// Convert JobApplication to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'jobId': jobId,
      'userId': userId,
      'userName': userName,
      'userProfileImage': userProfileImage,
      'coverLetter': coverLetter,
      'resumeUrl': resumeUrl,
      'appliedDate': appliedDate.toIso8601String(),
      'status': status,
      'statusUpdatedDate': statusUpdatedDate?.toIso8601String(),
      'feedback': feedback,
      'rating': rating,
    };
  }

  /// Create a copy with some fields changed
  JobApplication copyWith({
    String? id,
    String? jobId,
    String? userId,
    String? userName,
    String? userProfileImage,
    String? coverLetter,
    String? resumeUrl,
    DateTime? appliedDate,
    String? status,
    DateTime? statusUpdatedDate,
    String? feedback,
    double? rating,
  }) {
    return JobApplication(
      id: id ?? this.id,
      jobId: jobId ?? this.jobId,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userProfileImage: userProfileImage ?? this.userProfileImage,
      coverLetter: coverLetter ?? this.coverLetter,
      resumeUrl: resumeUrl ?? this.resumeUrl,
      appliedDate: appliedDate ?? this.appliedDate,
      status: status ?? this.status,
      statusUpdatedDate: statusUpdatedDate ?? this.statusUpdatedDate,
      feedback: feedback ?? this.feedback,
      rating: rating ?? this.rating,
    );
  }
}

/// Status constants for job applications
class ApplicationStatus {
  static const String pending = 'Pending';
  static const String reviewed = 'Reviewed';
  static const String shortlisted = 'Shortlisted';
  static const String rejected = 'Rejected';
  static const String accepted = 'Accepted';

  /// Get all statuses as list
  static List<String> get allStatuses => [
    pending,
    reviewed,
    shortlisted,
    rejected,
    accepted,
  ];
}
