import 'package:rental_car/core/utils/result.dart';
import 'package:rental_car/features/course/domain/entities/enrollment_entity.dart';
import 'package:rental_car/features/course/domain/repositories/course_repository.dart';

class GetMyEnrollmentsUseCase {
  const GetMyEnrollmentsUseCase(this._repository);

  final CourseRepository _repository;

  Future<Result<List<EnrollmentEntity>>> call() {
    return _repository.getMyEnrollments();
  }
}
