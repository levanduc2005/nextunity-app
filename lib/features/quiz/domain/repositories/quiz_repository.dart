import 'package:rental_car/core/utils/result.dart';
import 'package:rental_car/features/quiz/domain/entities/quiz_detail_entity.dart';
import 'package:rental_car/features/quiz/domain/entities/quiz_result_entity.dart';
import 'package:rental_car/features/quiz/domain/entities/quiz_submission_summary_entity.dart';

abstract interface class QuizRepository {
  Future<Result<QuizDetailEntity>> getQuizDetail(String quizId);

  Future<Result<QuizResultEntity>> submitQuiz(
    String quizId, {
    required int timeSpentSeconds,
    required Map<String, List<String>> answers,
  });

  Future<Result<List<QuizSubmissionSummaryEntity>>> getMySubmissions(
    String quizId,
  );

  Future<Result<QuizResultEntity>> getSubmissionDetail(String submissionId);
}
