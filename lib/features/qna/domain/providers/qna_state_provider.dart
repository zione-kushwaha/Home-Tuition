import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/index.dart';
import '../../data/repositories/index.dart';

/// QnA state for managing questions and answers
class QnaState {
  final bool isLoading;
  final String? errorMessage;
  final String? searchQuery;
  final List<String>? selectedTags;
  final bool? onlySolved;
  final Question? editingQuestion;

  QnaState({
    this.isLoading = false,
    this.errorMessage,
    this.searchQuery,
    this.selectedTags,
    this.onlySolved,
    this.editingQuestion,
  });

  /// Create a copy with some fields changed
  QnaState copyWith({
    bool? isLoading,
    String? errorMessage,
    String? searchQuery,
    List<String>? selectedTags,
    bool? onlySolved,
    Question? editingQuestion,
    bool clearError = false,
    bool clearFilters = false,
    bool clearEditingQuestion = false,
  }) {
    return QnaState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      searchQuery: clearFilters ? null : searchQuery ?? this.searchQuery,
      selectedTags: clearFilters ? null : selectedTags ?? this.selectedTags,
      onlySolved: clearFilters ? null : onlySolved ?? this.onlySolved,
      editingQuestion: clearEditingQuestion ? null : editingQuestion ?? this.editingQuestion,
    );
  }

  /// Get filters as map
  Map<String, dynamic> get filters => {
    if (searchQuery != null && searchQuery!.isNotEmpty) 'searchQuery': searchQuery,
    if (selectedTags != null && selectedTags!.isNotEmpty) 'tags': selectedTags,
    if (onlySolved != null) 'onlySolved': onlySolved,
  };
}

/// QnA notifier for managing Q&A state
class QnaNotifier extends StateNotifier<QnaState> {
  final QnaRepository _qnaRepository;

  QnaNotifier(this._qnaRepository) : super(QnaState());

  /// Update search query
  void updateSearchQuery(String? query) {
    state = state.copyWith(searchQuery: query);
  }

  /// Update selected tags
  void updateSelectedTags(List<String>? tags) {
    state = state.copyWith(selectedTags: tags);
  }

  /// Update only solved filter
  void updateOnlySolved(bool? onlySolved) {
    state = state.copyWith(onlySolved: onlySolved);
  }

  /// Clear all filters
  void clearFilters() {
    state = state.copyWith(clearFilters: true);
  }

  /// Set question for editing
  void setEditingQuestion(Question question) {
    state = state.copyWith(editingQuestion: question);
  }

  /// Clear editing question
  void clearEditingQuestion() {
    state = state.copyWith(clearEditingQuestion: true);
  }

  /// Create a new question
  Future<bool> createQuestion(Question question) async {
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      await _qnaRepository.createQuestion(question);
      state = state.copyWith(isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
      return false;
    }
  }

  /// Update an existing question
  Future<bool> updateQuestion(Question question) async {
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      await _qnaRepository.updateQuestion(question);
      state = state.copyWith(isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
      return false;
    }
  }

  /// Delete a question
  Future<bool> deleteQuestion(String id) async {
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      final success = await _qnaRepository.deleteQuestion(id);
      state = state.copyWith(isLoading: false);
      return success;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
      return false;
    }
  }

  /// Create a new answer
  Future<bool> createAnswer(Answer answer) async {
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      await _qnaRepository.createAnswer(answer);
      state = state.copyWith(isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
      return false;
    }
  }

  /// Update an existing answer
  Future<bool> updateAnswer(Answer answer) async {
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      await _qnaRepository.updateAnswer(answer);
      state = state.copyWith(isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
      return false;
    }
  }

  /// Delete an answer
  Future<bool> deleteAnswer(String id) async {
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      final success = await _qnaRepository.deleteAnswer(id);
      state = state.copyWith(isLoading: false);
      return success;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
      return false;
    }
  }

  /// Accept an answer
  Future<bool> acceptAnswer(String questionId, String answerId) async {
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      final success = await _qnaRepository.acceptAnswer(questionId, answerId);
      state = state.copyWith(isLoading: false);
      return success;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
      return false;
    }
  }

  /// Add comment to a question
  Future<bool> addCommentToQuestion(String questionId, Comment comment) async {
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      await _qnaRepository.addCommentToQuestion(questionId, comment);
      state = state.copyWith(isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
      return false;
    }
  }

  /// Add comment to an answer
  Future<bool> addCommentToAnswer(String answerId, Comment comment) async {
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      await _qnaRepository.addCommentToAnswer(answerId, comment);
      state = state.copyWith(isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
      return false;
    }
  }

  /// Vote on a question
  Future<bool> voteQuestion(String questionId, bool isUpvote) async {
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      await _qnaRepository.voteQuestion(questionId, isUpvote);
      state = state.copyWith(isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
      return false;
    }
  }

  /// Vote on an answer
  Future<bool> voteAnswer(String answerId, bool isUpvote) async {
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      await _qnaRepository.voteAnswer(answerId, isUpvote);
      state = state.copyWith(isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
      return false;
    }
  }

  /// Clear error message
  void clearError() {
    if (state.errorMessage != null) {
      state = state.copyWith(clearError: true);
    }
  }
}
