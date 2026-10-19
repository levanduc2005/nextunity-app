import 'package:rental_car/core/utils/result.dart';
import 'package:rental_car/features/course/domain/entities/lesson_entity.dart';
import 'package:rental_car/features/course/domain/repositories/course_repository.dart';

class GetLessonDetailUseCase {
  const GetLessonDetailUseCase(this._repository);

  final CourseRepository _repository;

  Future<Result<LessonEntity>> call(String lessonId) {
    return _repository.getLessonDetail(lessonId);
  }
}
