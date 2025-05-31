/// Comment model for Q&A feature
class Comment {
  final String id;
  final String content;
  final String userId;
  final String userName;
  final String? userProfileImage;
  final DateTime createdAt;

  Comment({
    required this.id,
    required this.content,
    required this.userId,
    required this.userName,
    this.userProfileImage,
    required this.createdAt,
  });

  /// Create Comment from JSON
  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'] as String,
      content: json['content'] as String,
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      userProfileImage: json['userProfileImage'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  /// Convert Comment to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'userId': userId,
      'userName': userName,
      'userProfileImage': userProfileImage,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  /// Create a copy with some fields changed
  Comment copyWith({
    String? id,
    String? content,
    String? userId,
    String? userName,
    String? userProfileImage,
    DateTime? createdAt,
  }) {
    return Comment(
      id: id ?? this.id,
      content: content ?? this.content,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userProfileImage: userProfileImage ?? this.userProfileImage,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
