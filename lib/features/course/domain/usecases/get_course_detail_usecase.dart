import 'package:rental_car/core/utils/result.dart';
import 'package:rental_car/features/course/domain/entities/course_entity.dart';
import 'package:rental_car/features/course/domain/repositories/course_repository.dart';

class GetCourseDetailUseCase {
  const GetCourseDetailUseCase(this._repository);

  final CourseRepository _repository;

  Future<Result<CourseEntity>> call(String courseId) {
    return _repository.getCourseDetail(courseId);
  }
}
