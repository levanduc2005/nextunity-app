import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_car/core/providers/core_providers.dart';
import 'package:rental_car/features/course/presentation/providers/course_providers.dart';
import 'package:rental_car/features/quiz/domain/entities/quiz_detail_entity.dart';
import 'package:rental_car/features/quiz/domain/entities/quiz_result_entity.dart';
import 'package:rental_car/features/quiz/presentation/providers/quiz_providers.dart';

class QuizState {
  const QuizState({
    this.quiz,
    this.isLoading = false,
    this.isSubmitting = false,
    this.errorMessage,
    this.currentQuestionIndex = 0,
    this.selectedOptionIds = const {},
    this.timeSpentSeconds = 0,
    this.result,
    this.isSubmitted = false,
  });

  final QuizDetailEntity? quiz;
  final bool isLoading;
  final bool isSubmitting;
  final String? errorMessage;
  final int currentQuestionIndex;
  final Map<String, List<String>> selectedOptionIds;
  final int timeSpentSeconds;
  final QuizResultEntity? result;
  final bool isSubmitted;

  int get answeredCount {
    if (quiz == null) return 0;
    return quiz!.questions
        .where((q) => (selectedOptionIds[q.id]?.isNotEmpty ?? false))
        .length;
  }

  QuizState copyWith({
    QuizDetailEntity? quiz,
    bool? isLoading,
    bool? isSubmitting,
    String? errorMessage,
    bool clearError = false,
    bool clearResult = false,
    int? currentQuestionIndex,
    Map<String, List<String>>? selectedOptionIds,
    int? timeSpentSeconds,
    QuizResultEntity? result,
    bool? isSubmitted,
  }) {
    return QuizState(
      quiz: quiz ?? this.quiz,
      isLoading: isLoading ?? this.isLoading,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      selectedOptionIds: selectedOptionIds ?? this.selectedOptionIds,
      timeSpentSeconds: timeSpentSeconds ?? this.timeSpentSeconds,
      result: clearResult ? null : (result ?? this.result),
      isSubmitted: isSubmitted ?? this.isSubmitted,
    );
  }
}

class QuizController extends Notifier<QuizState> {
  @override
  QuizState build() {
    return const QuizState();
  }

  Future<void> loadQuiz(String quizId) async {
    state = const QuizState(isLoading: true);
    final result = await ref.read(getQuizDetailUseCaseProvider).call(quizId);

    await result.when(
      ok: (quiz) async {
        // Khôi phục bản nháp các câu đã chọn và vị trí câu đang làm dở (nếu có)
        final draft = await _loadDraft(quizId);
        int initialIndex = 0;
        Map<String, List<String>> initialAnswers = {};

        if (draft != null) {
          initialAnswers = draft.answers;
          if (draft.currentIndex >= 0 &&
              draft.currentIndex < quiz.questions.length) {
            initialIndex = draft.currentIndex;
          }
        }

        state = state.copyWith(
          quiz: quiz,
          isLoading: false,
          currentQuestionIndex: initialIndex,
          selectedOptionIds: initialAnswers,
          isSubmitted: false,
        );
      },
      err: (failure) async {
        state = state.copyWith(isLoading: false, errorMessage: failure.message);
      },
    );
  }

  void selectOption(
    String questionId,
    String optionId, {
    bool isMultiChoice = false,
  }) {
    if (state.isSubmitted) return;

    final updated = Map<String, List<String>>.from(state.selectedOptionIds);
    if (isMultiChoice) {
      final currentList = List<String>.from(updated[questionId] ?? []);
      if (currentList.contains(optionId)) {
        currentList.remove(optionId);
      } else {
        currentList.add(optionId);
      }
      updated[questionId] = currentList;
    } else {
      updated[questionId] = [optionId];
    }

    state = state.copyWith(selectedOptionIds: updated);
    _saveDraft();
  }

  void nextQuestion() {
    final quiz = state.quiz;
    if (quiz == null) return;
    if (state.currentQuestionIndex < quiz.questions.length - 1) {
      state = state.copyWith(
        currentQuestionIndex: state.currentQuestionIndex + 1,
      );
      _saveDraft();
    }
  }

  void previousQuestion() {
    if (state.currentQuestionIndex > 0) {
      state = state.copyWith(
        currentQuestionIndex: state.currentQuestionIndex - 1,
      );
      _saveDraft();
    }
  }

  void goToQuestion(int index) {
    final quiz = state.quiz;
    if (quiz == null) return;
    if (index >= 0 && index < quiz.questions.length) {
      state = state.copyWith(currentQuestionIndex: index);
      _saveDraft();
    }
  }

  void updateTimeSpent(int seconds) {
    state = state.copyWith(timeSpentSeconds: seconds);
  }

  Future<bool> submitQuiz() async {
    final quiz = state.quiz;
    if (quiz == null) return false;

    state = state.copyWith(isSubmitting: true, clearError: true);

    final res = await ref
        .read(submitQuizUseCaseProvider)
        .call(
          quiz.id,
          timeSpentSeconds: state.timeSpentSeconds,
          answers: state.selectedOptionIds,
        );

    return res.when(
      ok: (resultEntity) async {
        state = state.copyWith(
          isSubmitting: false,
          result: resultEntity,
          isSubmitted: true,
        );

        // Nộp bài thành công: Xóa bản nháp lưu tạm
        await _clearDraft(quiz.id);

        // Invalidate quiz submissions cache so any watcher gets the fresh list
        ref.invalidate(myQuizSubmissionsProvider(quiz.id));

        if (resultEntity.isPassed) {
          // Immediately mark the lesson as completed in memory
          ref
              .read(lessonDetailControllerProvider.notifier)
              .markCompleted(isCompleted: true);

          // Also mark the lesson as completed in the course modules (TOC)
          ref
              .read(courseDetailControllerProvider.notifier)
              .markLessonCompleted(quiz.lessonId, isCompleted: true);
        }

        // Refresh courses list and detail
        ref.read(coursesControllerProvider.notifier).refresh();
        final courseId = ref.read(courseDetailControllerProvider).course?.id;
        if (courseId != null) {
          ref
              .read(courseDetailControllerProvider.notifier)
              .loadCourseDetail(courseId);
        }
        return true;
      },
      err: (failure) {
        state = state.copyWith(
          isSubmitting: false,
          errorMessage: failure.message,
        );
        return false;
      },
    );
  }

  void restartQuiz() {
    final quiz = state.quiz;
    if (quiz != null) {
      _clearDraft(quiz.id);
    }
    state = state.copyWith(
      currentQuestionIndex: 0,
      selectedOptionIds: {},
      timeSpentSeconds: 0,
      clearResult: true,
      isSubmitted: false,
      clearError: true,
    );
  }

  Future<_QuizDraft?> _loadDraft(String quizId) async {
    try {
      final store = ref.read(keyValueStoreProvider);
      final raw = await store.getString('quiz_draft_$quizId');
      if (raw == null || raw.isEmpty) return null;
      final map = jsonDecode(raw) as Map<String, dynamic>;
      final rawAnswers =
          map['selectedOptionIds'] as Map<String, dynamic>? ?? {};
      final answers = rawAnswers.map(
        (k, v) =>
            MapEntry(k, (v as List<dynamic>).map((e) => e.toString()).toList()),
      );
      final index = map['currentQuestionIndex'] as int? ?? 0;
      return _QuizDraft(answers: answers, currentIndex: index);
    } catch (_) {
      return null;
    }
  }

  Future<void> _saveDraft() async {
    final quiz = state.quiz;
    if (quiz == null || state.isSubmitted) return;
    try {
      final store = ref.read(keyValueStoreProvider);
      final payload = jsonEncode({
        'selectedOptionIds': state.selectedOptionIds,
        'currentQuestionIndex': state.currentQuestionIndex,
      });
      await store.setString('quiz_draft_${quiz.id}', payload);
      ref.invalidate(hasQuizDraftProvider(quiz.id));
    } catch (_) {}
  }

  Future<void> _clearDraft(String quizId) async {
    try {
      final store = ref.read(keyValueStoreProvider);
      await store.remove('quiz_draft_$quizId');
      ref.invalidate(hasQuizDraftProvider(quizId));
    } catch (_) {}
  }
}

class _QuizDraft {
  const _QuizDraft({required this.answers, required this.currentIndex});

  final Map<String, List<String>> answers;
  final int currentIndex;
}
