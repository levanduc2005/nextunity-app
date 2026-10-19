import 'package:rental_car/core/utils/result.dart';
import 'package:rental_car/features/course/domain/entities/course_entity.dart';
import 'package:rental_car/features/course/domain/repositories/course_repository.dart';

class GetCoursesUseCase {
  const GetCoursesUseCase(this._repository);

  final CourseRepository _repository;

  Future<Result<List<CourseEntity>>> call({
    String? category,
    String? difficulty,
    String? search,
  }) {
    return _repository.getCourses(
      category: category,
      difficulty: difficulty,
      search: search,
    );
  }
}
