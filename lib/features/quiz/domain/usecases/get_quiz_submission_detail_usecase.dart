import 'package:rental_car/core/utils/result.dart';
import 'package:rental_car/features/quiz/domain/entities/quiz_result_entity.dart';
import 'package:rental_car/features/quiz/domain/repositories/quiz_repository.dart';

class GetQuizSubmissionDetailUseCase {
  const GetQuizSubmissionDetailUseCase(this._repository);

  final QuizRepository _repository;

  Future<Result<QuizResultEntity>> call(String submissionId) {
    return _repository.getSubmissionDetail(submissionId);
  }
}
