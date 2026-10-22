import 'package:rental_car/core/utils/result.dart';
import 'package:rental_car/features/course/domain/entities/course_entity.dart';
import 'package:rental_car/features/course/domain/repositories/course_repository.dart';

class GetPopularCoursesUseCase {
  const GetPopularCoursesUseCase(this._repository);

  final CourseRepository _repository;

  Future<Result<List<CourseEntity>>> call({int limit = 5}) {
    return _repository.getPopularCourses(limit: limit);
  }
}
