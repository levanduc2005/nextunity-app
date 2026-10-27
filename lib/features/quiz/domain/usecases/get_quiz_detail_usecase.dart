import 'package:rental_car/core/utils/result.dart';
import 'package:rental_car/features/quiz/domain/entities/quiz_detail_entity.dart';
import 'package:rental_car/features/quiz/domain/repositories/quiz_repository.dart';

class GetQuizDetailUseCase {
  const GetQuizDetailUseCase(this._repository);

  final QuizRepository _repository;

  Future<Result<QuizDetailEntity>> call(String quizId) {
    return _repository.getQuizDetail(quizId);
  }
}
