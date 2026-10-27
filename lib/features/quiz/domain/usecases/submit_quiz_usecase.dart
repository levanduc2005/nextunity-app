import 'package:rental_car/core/utils/result.dart';
import 'package:rental_car/features/quiz/domain/entities/quiz_result_entity.dart';
import 'package:rental_car/features/quiz/domain/repositories/quiz_repository.dart';

class SubmitQuizUseCase {
  const SubmitQuizUseCase(this._repository);

  final QuizRepository _repository;

  Future<Result<QuizResultEntity>> call(
    String quizId, {
    required int timeSpentSeconds,
    required Map<String, List<String>> answers,
  }) {
    return _repository.submitQuiz(
      quizId,
      timeSpentSeconds: timeSpentSeconds,
      answers: answers,
    );
  }
}
