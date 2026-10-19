import 'package:rental_car/core/utils/result.dart';
import 'package:rental_car/features/course/domain/entities/course_filter_options_entity.dart';
import 'package:rental_car/features/course/domain/repositories/course_repository.dart';

class GetCourseFilterOptionsUseCase {
  const GetCourseFilterOptionsUseCase(this._repository);

  final CourseRepository _repository;

  Future<Result<CourseFilterOptionsEntity>> call() {
    return _repository.getFilterOptions();
  }
}
