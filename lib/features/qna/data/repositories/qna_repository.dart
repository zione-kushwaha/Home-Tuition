import '../models/index.dart';
import 'mock_qna_data.dart';

/// Repository for Q&A functionality
abstract class QnaRepository {
  /// Get all questions with optional filters
  Future<List<Question>> getAllQuestions({
    String? searchQuery,
    List<String>? tags,
    bool? onlySolved,
    String? userId,
  });
  
  /// Get question by ID
  Future<Question?> getQuestionById(String id);
  
  /// Get questions created by a user
  Future<List<Question>> getQuestionsByUser(String userId);
  
  /// Get trending/popular questions
  Future<List<Question>> getTrendingQuestions();
  
  /// Create a new question
  Future<Question> createQuestion(Question question);
  
  /// Update an existing question
  Future<Question> updateQuestion(Question question);
  
  /// Delete a question
  Future<bool> deleteQuestion(String id);
  
  /// Get answers for a question
  Future<List<Answer>> getAnswersForQuestion(String questionId);
  
  /// Get answer by ID
  Future<Answer?> getAnswerById(String id);
  
  /// Create a new answer
  Future<Answer> createAnswer(Answer answer);
  
  /// Update an existing answer
  Future<Answer> updateAnswer(Answer answer);
  
  /// Delete an answer
  Future<bool> deleteAnswer(String id);
  
  /// Mark answer as accepted
  Future<bool> acceptAnswer(String questionId, String answerId);
  
  /// Add comment to a question
  Future<Comment> addCommentToQuestion(String questionId, Comment comment);
  
  /// Add comment to an answer
  Future<Comment> addCommentToAnswer(String answerId, Comment comment);
  
  /// Delete a comment
  Future<bool> deleteComment(String id);
  
  /// Vote on a question (upvote or downvote)
  Future<Question> voteQuestion(String questionId, bool isUpvote);
  
  /// Vote on an answer (upvote or downvote)
  Future<Answer> voteAnswer(String answerId, bool isUpvote);
}

/// Implementation of QnaRepository with mock data
class QnaRepositoryImpl implements QnaRepository {
  @override
  Future<List<Question>> getAllQuestions({
    String? searchQuery,
    List<String>? tags,
    bool? onlySolved,
    String? userId,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    List<Question> questions = MockQnaData.getMockQuestions();
    
    // Apply filters if provided
    if (searchQuery != null && searchQuery.isNotEmpty) {
      final query = searchQuery.toLowerCase();
      questions = questions.where((q) => 
        q.title.toLowerCase().contains(query) || 
        q.content.toLowerCase().contains(query)
      ).toList();
    }
    
    if (tags != null && tags.isNotEmpty) {
      questions = questions.where((q) => 
        tags.any((tag) => q.tags.contains(tag))
      ).toList();
    }
    
    if (onlySolved == true) {
      questions = questions.where((q) => q.isSolved).toList();
    }
    
    if (userId != null) {
      questions = questions.where((q) => q.userId == userId).toList();
    }
    
    // Sort by most recent
    questions.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    
    return questions;
  }
  
  @override
  Future<Question?> getQuestionById(String id) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));
    
    try {
      return MockQnaData.getMockQuestions().firstWhere((q) => q.id == id);
    } catch (e) {
      return null;
    }
  }
  
  @override
  Future<List<Question>> getQuestionsByUser(String userId) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 400));
    
    return MockQnaData.getMockQuestions()
        .where((q) => q.userId == userId)
        .toList();
  }
  
  @override
  Future<List<Question>> getTrendingQuestions() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    final questions = MockQnaData.getMockQuestions();
    
    // Sort by a combination of recency and popularity
    questions.sort((a, b) {
      // Calculate a score based on votes, views, and recency
      final scoreA = a.upvotes * 2 + a.viewCount - a.downvotes * 3;
      final scoreB = b.upvotes * 2 + b.viewCount - b.downvotes * 3;
      
      return scoreB.compareTo(scoreA);
    });
    
    // Return top 10 (or less if there aren't 10 questions)
    return questions.take(10).toList();
  }
  
  @override
  Future<Question> createQuestion(Question question) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));
    
    // In a real app, we'd send this to a backend service
    return question;
  }
  
  @override
  Future<Question> updateQuestion(Question question) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 600));
    
    // In a real app, we'd send this to a backend service
    return question;
  }
  
  @override
  Future<bool> deleteQuestion(String id) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    // In a real app, we'd send this to a backend service
    return true;
  }
  
  @override
  Future<List<Answer>> getAnswersForQuestion(String questionId) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 400));
    
    return MockQnaData.getMockAnswersForQuestion(questionId);
  }
  
  @override
  Future<Answer?> getAnswerById(String id) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));
    
    try {
      return MockQnaData.getAllMockAnswers().firstWhere((a) => a.id == id);
    } catch (e) {
      return null;
    }
  }
  
  @override
  Future<Answer> createAnswer(Answer answer) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 700));
    
    // In a real app, we'd send this to a backend service
    return answer;
  }
  
  @override
  Future<Answer> updateAnswer(Answer answer) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    
    // In a real app, we'd send this to a backend service
    return answer;
  }
  
  @override
  Future<bool> deleteAnswer(String id) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 400));
    
    // In a real app, we'd send this to a backend service
    return true;
  }
  
  @override
  Future<bool> acceptAnswer(String questionId, String answerId) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 600));
    
    // In a real app, we'd send this to a backend service and update both question and answer
    return true;
  }
  
  @override
  Future<Comment> addCommentToQuestion(String questionId, Comment comment) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 400));
    
    // In a real app, we'd send this to a backend service
    return comment;
  }
  
  @override
  Future<Comment> addCommentToAnswer(String answerId, Comment comment) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 400));
    
    // In a real app, we'd send this to a backend service
    return comment;
  }
  
  @override
  Future<bool> deleteComment(String id) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));
    
    // In a real app, we'd send this to a backend service
    return true;
  }
  
  @override
  Future<Question> voteQuestion(String questionId, bool isUpvote) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));
    
    try {
      final question = MockQnaData.getMockQuestions().firstWhere(
        (q) => q.id == questionId,
      );
      
      if (isUpvote) {
        return question.copyWith(upvotes: question.upvotes + 1);
      } else {
        return question.copyWith(downvotes: question.downvotes + 1);
      }
    } catch (e) {
      throw Exception('Question not found');
    }
  }
  
  @override
  Future<Answer> voteAnswer(String answerId, bool isUpvote) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));
    
    try {
      final answer = MockQnaData.getAllMockAnswers().firstWhere(
        (a) => a.id == answerId,
      );
      
      if (isUpvote) {
        return answer.copyWith(upvotes: answer.upvotes + 1);
      } else {
        return answer.copyWith(downvotes: answer.downvotes + 1);
      }
    } catch (e) {
      throw Exception('Answer not found');
    }
  }
}
