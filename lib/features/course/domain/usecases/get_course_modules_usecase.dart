import 'package:rental_car/core/utils/result.dart';
import 'package:rental_car/features/course/domain/entities/module_entity.dart';
import 'package:rental_car/features/course/domain/repositories/course_repository.dart';

class GetCourseModulesUseCase {
  const GetCourseModulesUseCase(this._repository);

  final CourseRepository _repository;

  Future<Result<List<ModuleEntity>>> call(String courseId) {
    return _repository.getCourseModules(courseId);
  }
}
