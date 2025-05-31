import 'index.dart';

/// Answer model for Q&A feature
class Answer {
  final String id;
  final String questionId;
  final String content;
  final String userId;
  final String userName;
  final String? userProfileImage;
  final DateTime createdAt;
  final int upvotes;
  final int downvotes;
  final bool isAccepted;
  final List<Comment>? comments;

  Answer({
    required this.id,
    required this.questionId,
    required this.content,
    required this.userId,
    required this.userName,
    this.userProfileImage,
    required this.createdAt,
    this.upvotes = 0,
    this.downvotes = 0,
    this.isAccepted = false,
    this.comments,
  });

  /// Create Answer from JSON
  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      id: json['id'] as String,
      questionId: json['questionId'] as String,
      content: json['content'] as String,
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      userProfileImage: json['userProfileImage'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      upvotes: json['upvotes'] as int? ?? 0,
      downvotes: json['downvotes'] as int? ?? 0,
      isAccepted: json['isAccepted'] as bool? ?? false,
      comments: json['comments'] != null
          ? (json['comments'] as List)
              .map((e) => Comment.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
    );
  }

  /// Convert Answer to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'questionId': questionId,
      'content': content,
      'userId': userId,
      'userName': userName,
      'userProfileImage': userProfileImage,
      'createdAt': createdAt.toIso8601String(),
      'upvotes': upvotes,
      'downvotes': downvotes,
      'isAccepted': isAccepted,
      'comments': comments?.map((e) => e.toJson()).toList(),
    };
  }

  /// Create a copy with some fields changed
  Answer copyWith({
    String? id,
    String? questionId,
    String? content,
    String? userId,
    String? userName,
    String? userProfileImage,
    DateTime? createdAt,
    int? upvotes,
    int? downvotes,
    bool? isAccepted,
    List<Comment>? comments,
  }) {
    return Answer(
      id: id ?? this.id,
      questionId: questionId ?? this.questionId,
      content: content ?? this.content,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userProfileImage: userProfileImage ?? this.userProfileImage,
      createdAt: createdAt ?? this.createdAt,
      upvotes: upvotes ?? this.upvotes,
      downvotes: downvotes ?? this.downvotes,
      isAccepted: isAccepted ?? this.isAccepted,
      comments: comments ?? this.comments,
    );
  }
}
