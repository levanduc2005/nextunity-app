import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_car/core/providers/core_providers.dart';
import 'package:rental_car/features/quiz/data/datasources/quiz_remote_data_source.dart';
import 'package:rental_car/features/quiz/data/repositories/quiz_repository_impl.dart';
import 'package:rental_car/features/quiz/domain/entities/quiz_detail_entity.dart';
import 'package:rental_car/features/quiz/domain/entities/quiz_result_entity.dart';
import 'package:rental_car/features/quiz/domain/entities/quiz_submission_summary_entity.dart';
import 'package:rental_car/features/quiz/domain/repositories/quiz_repository.dart';
import 'package:rental_car/features/quiz/domain/usecases/get_my_quiz_submissions_usecase.dart';
import 'package:rental_car/features/quiz/domain/usecases/get_quiz_detail_usecase.dart';
import 'package:rental_car/features/quiz/domain/usecases/get_quiz_submission_detail_usecase.dart';
import 'package:rental_car/features/quiz/domain/usecases/submit_quiz_usecase.dart';
import 'package:rental_car/features/quiz/presentation/providers/quiz_controller.dart';

export 'quiz_controller.dart';

// ============================================================================
// DEPENDENCY INJECTION PROVIDERS
// ============================================================================

final quizRemoteDataSourceProvider = Provider<QuizRemoteDataSource>((ref) {
  return QuizRemoteDataSourceImpl(dio: ref.watch(dioProvider));
});

final quizRepositoryProvider = Provider<QuizRepository>((ref) {
  return QuizRepositoryImpl(
    remoteDataSource: ref.watch(quizRemoteDataSourceProvider),
  );
});

final getQuizDetailUseCaseProvider = Provider<GetQuizDetailUseCase>((ref) {
  return GetQuizDetailUseCase(ref.watch(quizRepositoryProvider));
});

final submitQuizUseCaseProvider = Provider<SubmitQuizUseCase>((ref) {
  return SubmitQuizUseCase(ref.watch(quizRepositoryProvider));
});

final getMyQuizSubmissionsUseCaseProvider =
    Provider<GetMyQuizSubmissionsUseCase>((ref) {
      return GetMyQuizSubmissionsUseCase(ref.watch(quizRepositoryProvider));
    });

final getQuizSubmissionDetailUseCaseProvider =
    Provider<GetQuizSubmissionDetailUseCase>((ref) {
      return GetQuizSubmissionDetailUseCase(ref.watch(quizRepositoryProvider));
    });

final myQuizSubmissionsProvider = FutureProvider.autoDispose
    .family<List<QuizSubmissionSummaryEntity>, String>((ref, quizId) async {
      final useCase = ref.watch(getMyQuizSubmissionsUseCaseProvider);
      final result = await useCase(quizId);
      return result.when(ok: (data) => data, err: (failure) => throw failure);
    });

final quizSubmissionDetailProvider = FutureProvider.autoDispose
    .family<QuizResultEntity, String>((ref, submissionId) async {
      final useCase = ref.watch(getQuizSubmissionDetailUseCaseProvider);
      final result = await useCase(submissionId);
      return result.when(ok: (data) => data, err: (failure) => throw failure);
    });

final quizDetailFutureProvider = FutureProvider.autoDispose
    .family<QuizDetailEntity, String>((ref, quizId) async {
      final useCase = ref.watch(getQuizDetailUseCaseProvider);
      final result = await useCase(quizId);
      return result.when(ok: (data) => data, err: (failure) => throw failure);
    });

final quizControllerProvider = NotifierProvider<QuizController, QuizState>(
  QuizController.new,
);

final hasQuizDraftProvider = FutureProvider.autoDispose.family<bool, String>((
  ref,
  quizId,
) async {
  try {
    final store = ref.watch(keyValueStoreProvider);
    final raw = await store.getString('quiz_draft_$quizId');
    if (raw == null || raw.isEmpty) return false;
    final map = jsonDecode(raw) as Map<String, dynamic>;
    final selectedOptionIds = map['selectedOptionIds'] as Map<String, dynamic>?;
    return selectedOptionIds != null && selectedOptionIds.isNotEmpty;
  } catch (_) {
    return false;
  }
});
