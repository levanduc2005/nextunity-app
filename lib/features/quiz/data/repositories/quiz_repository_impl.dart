import 'package:rental_car/core/utils/result.dart';
import 'package:rental_car/core/utils/safe_call.dart';
import 'package:rental_car/features/quiz/data/datasources/quiz_remote_data_source.dart';
import 'package:rental_car/features/quiz/domain/entities/quiz_detail_entity.dart';
import 'package:rental_car/features/quiz/domain/entities/quiz_result_entity.dart';
import 'package:rental_car/features/quiz/domain/entities/quiz_submission_summary_entity.dart';
import 'package:rental_car/features/quiz/domain/repositories/quiz_repository.dart';

class QuizRepositoryImpl implements QuizRepository {
  QuizRepositoryImpl({required QuizRemoteDataSource remoteDataSource})
    : _remoteDataSource = remoteDataSource;

  final QuizRemoteDataSource _remoteDataSource;

  @override
  Future<Result<QuizDetailEntity>> getQuizDetail(String quizId) {
    return safeCall(() async {
      final model = await _remoteDataSource.getQuizDetail(quizId);
      return model.toEntity();
    });
  }

  @override
  Future<Result<QuizResultEntity>> submitQuiz(
    String quizId, {
    required int timeSpentSeconds,
    required Map<String, List<String>> answers,
  }) {
    return safeCall(() async {
      final model = await _remoteDataSource.submitQuiz(
        quizId,
        timeSpentSeconds: timeSpentSeconds,
        answers: answers,
      );
      return model.toEntity();
    });
  }

  @override
  Future<Result<List<QuizSubmissionSummaryEntity>>> getMySubmissions(
    String quizId,
  ) {
    return safeCall(() async {
      final models = await _remoteDataSource.getMySubmissions(quizId);
      return models.map((m) => m.toEntity()).toList();
    });
  }

  @override
  Future<Result<QuizResultEntity>> getSubmissionDetail(String submissionId) {
    return safeCall(() async {
      final model = await _remoteDataSource.getSubmissionDetail(submissionId);
      return model.toEntity();
    });
  }
}
