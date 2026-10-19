import 'package:rental_car/core/utils/result.dart';
import 'package:rental_car/core/utils/safe_call.dart';
import 'package:rental_car/features/course/data/datasources/course_remote_data_source.dart';
import 'package:rental_car/features/course/domain/entities/course_entity.dart';
import 'package:rental_car/features/course/domain/entities/course_filter_options_entity.dart';
import 'package:rental_car/features/course/domain/entities/enrollment_entity.dart';
import 'package:rental_car/features/course/domain/entities/lesson_entity.dart';
import 'package:rental_car/features/course/domain/entities/module_entity.dart';
import 'package:rental_car/features/course/domain/repositories/course_repository.dart';

class CourseRepositoryImpl implements CourseRepository {
  CourseRepositoryImpl({required CourseRemoteDataSource remoteDataSource})
    : _remoteDataSource = remoteDataSource;

  final CourseRemoteDataSource _remoteDataSource;

  @override
  Future<Result<CourseFilterOptionsEntity>> getFilterOptions() {
    return safeCall(() => _remoteDataSource.getFilterOptions());
  }

  @override
  Future<Result<List<CourseEntity>>> getCourses({
    String? category,
    String? difficulty,
    String? search,
  }) {
    return safeCall(() async {
      final models = await _remoteDataSource.getCourses(
        category: category,
        difficulty: difficulty,
        search: search,
      );
      return models.map((m) => m.toEntity()).toList();
    });
  }

  @override
  Future<Result<List<EnrollmentEntity>>> getMyEnrollments() {
    return safeCall(() async {
      final models = await _remoteDataSource.getMyEnrollments();
      return models.map((m) => m.toEntity()).toList();
    });
  }

  @override
  Future<Result<CourseEntity>> getCourseDetail(String courseId) {
    return safeCall(() async {
      final model = await _remoteDataSource.getCourseDetail(courseId);
      return model.toEntity();
    });
  }

  @override
  Future<Result<EnrollmentEntity>> enrollCourse(String courseId) {
    return safeCall(() async {
      final model = await _remoteDataSource.enrollCourse(courseId);
      return model.toEntity();
    });
  }

  @override
  Future<Result<List<ModuleEntity>>> getCourseModules(String courseId) {
    return safeCall(() async {
      final models = await _remoteDataSource.getCourseModules(courseId);
      return models.map((m) => m.toEntity()).toList();
    });
  }

  @override
  Future<Result<LessonEntity>> getLessonDetail(String lessonId) {
    return safeCall(() async {
      final model = await _remoteDataSource.getLessonById(lessonId);
      return model.toEntity();
    });
  }

  @override
  Future<Result<int>> updateLessonProgress(
    String lessonId, {
    required bool isCompleted,
  }) {
    return safeCall(() async {
      return await _remoteDataSource.updateLessonProgress(
        lessonId,
        isCompleted: isCompleted,
      );
    });
  }
}
