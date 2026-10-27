import 'package:rental_car/core/utils/result.dart';
import 'package:rental_car/features/quiz/domain/entities/quiz_submission_summary_entity.dart';
import 'package:rental_car/features/quiz/domain/repositories/quiz_repository.dart';

class GetMyQuizSubmissionsUseCase {
  const GetMyQuizSubmissionsUseCase(this._repository);

  final QuizRepository _repository;

  Future<Result<List<QuizSubmissionSummaryEntity>>> call(String quizId) {
    return _repository.getMySubmissions(quizId);
  }
}
