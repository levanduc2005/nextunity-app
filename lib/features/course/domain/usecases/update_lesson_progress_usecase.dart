import 'package:rental_car/core/utils/result.dart';
import 'package:rental_car/features/course/domain/repositories/course_repository.dart';

class UpdateLessonProgressUseCase {
  const UpdateLessonProgressUseCase(this._repository);

  final CourseRepository _repository;

  Future<Result<int>> call(String lessonId, {required bool isCompleted}) {
    return _repository.updateLessonProgress(lessonId, isCompleted: isCompleted);
  }
}
