import 'package:rental_car/core/utils/result.dart';
import 'package:rental_car/features/course/domain/entities/course_entity.dart';
import 'package:rental_car/features/course/domain/entities/course_filter_options_entity.dart';
import 'package:rental_car/features/course/domain/entities/enrollment_entity.dart';
import 'package:rental_car/features/course/domain/entities/lesson_entity.dart';
import 'package:rental_car/features/course/domain/entities/module_entity.dart';

abstract interface class CourseRepository {
  Future<Result<CourseFilterOptionsEntity>> getFilterOptions();

  Future<Result<List<CourseEntity>>> getCourses({
    String? category,
    String? difficulty,
    String? search,
  });

  Future<Result<List<CourseEntity>>> getPopularCourses({int limit = 5});

  Future<Result<List<EnrollmentEntity>>> getMyEnrollments();

  Future<Result<CourseEntity>> getCourseDetail(String courseId);

  Future<Result<EnrollmentEntity>> enrollCourse(String courseId);

  Future<Result<List<ModuleEntity>>> getCourseModules(String courseId);

  Future<Result<LessonEntity>> getLessonDetail(String lessonId);

  Future<Result<int>> updateLessonProgress(
    String lessonId, {
    required bool isCompleted,
  });
}
