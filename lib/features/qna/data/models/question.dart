import 'comment.dart';

/// Question model for Q&A feature
class Question {
  final String id;
  final String title;
  final String content;
  final String userId;
  final String userName;
  final String? userProfileImage;
  final DateTime createdAt;
  final List<String> tags;
  final int upvotes;
  final int downvotes;
  final int viewCount;
  final int answerCount;
  final bool isSolved;
  final String? acceptedAnswerId;
  final List<Comment>? comments;

  Question({
    required this.id,
    required this.title,
    required this.content,
    required this.userId,
    required this.userName,
    this.userProfileImage,
    required this.createdAt,
    required this.tags,
    this.upvotes = 0,
    this.downvotes = 0,
    this.viewCount = 0,
    this.answerCount = 0,
    this.isSolved = false,
    this.acceptedAnswerId,
    this.comments,
  });

  /// Create Question from JSON
  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      userProfileImage: json['userProfileImage'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      tags: List<String>.from(json['tags']),
      upvotes: json['upvotes'] as int? ?? 0,
      downvotes: json['downvotes'] as int? ?? 0,
      viewCount: json['viewCount'] as int? ?? 0,
      answerCount: json['answerCount'] as int? ?? 0,
      isSolved: json['isSolved'] as bool? ?? false,
      acceptedAnswerId: json['acceptedAnswerId'] as String?,
      comments: json['comments'] != null
          ? (json['comments'] as List)
              .map((e) => Comment.fromJson(e as Map<String, dynamic>))
              .toList()
          : null,
    );
  }

  /// Convert Question to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'userId': userId,
      'userName': userName,
      'userProfileImage': userProfileImage,
      'createdAt': createdAt.toIso8601String(),
      'tags': tags,
      'upvotes': upvotes,
      'downvotes': downvotes,
      'viewCount': viewCount,
      'answerCount': answerCount,
      'isSolved': isSolved,
      'acceptedAnswerId': acceptedAnswerId,
      'comments': comments?.map((e) => e.toJson()).toList(),
    };
  }

  /// Create a copy with some fields changed
  Question copyWith({
    String? id,
    String? title,
    String? content,
    String? userId,
    String? userName,
    String? userProfileImage,
    DateTime? createdAt,
    List<String>? tags,
    int? upvotes,
    int? downvotes,
    int? viewCount,
    int? answerCount,
    bool? isSolved,
    String? acceptedAnswerId,
    List<Comment>? comments,
  }) {
    return Question(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userProfileImage: userProfileImage ?? this.userProfileImage,
      createdAt: createdAt ?? this.createdAt,
      tags: tags ?? this.tags,
      upvotes: upvotes ?? this.upvotes,
      downvotes: downvotes ?? this.downvotes,
      viewCount: viewCount ?? this.viewCount,
      answerCount: answerCount ?? this.answerCount,
      isSolved: isSolved ?? this.isSolved,
      acceptedAnswerId: acceptedAnswerId ?? this.acceptedAnswerId,
      comments: comments ?? this.comments,
    );
  }
}
