import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_car/core/providers/core_providers.dart';
import 'package:rental_car/features/course/data/datasources/course_remote_data_source.dart';
import 'package:rental_car/features/course/data/repositories/course_repository_impl.dart';
import 'package:rental_car/features/course/domain/repositories/course_repository.dart';
import 'package:rental_car/features/course/domain/usecases/enroll_course_usecase.dart';
import 'package:rental_car/features/course/domain/usecases/get_course_detail_usecase.dart';
import 'package:rental_car/features/course/domain/usecases/get_course_filter_options_usecase.dart';
import 'package:rental_car/features/course/domain/usecases/get_course_modules_usecase.dart';
import 'package:rental_car/features/course/domain/usecases/get_courses_usecase.dart';
import 'package:rental_car/features/course/domain/usecases/get_lesson_detail_usecase.dart';
import 'package:rental_car/features/course/domain/usecases/get_my_enrollments_usecase.dart';
import 'package:rental_car/features/course/domain/usecases/update_lesson_progress_usecase.dart';
import 'package:rental_car/features/course/presentation/providers/course_detail_controller.dart';
import 'package:rental_car/features/course/presentation/providers/courses_controller.dart';
import 'package:rental_car/features/course/presentation/providers/lesson_detail_controller.dart';

export 'course_detail_controller.dart';
export 'courses_controller.dart';
export 'lesson_detail_controller.dart';

// ============================================================================
// DEPENDENCY INJECTION PROVIDERS
// ============================================================================

final courseRemoteDataSourceProvider = Provider<CourseRemoteDataSource>((ref) {
  return CourseRemoteDataSourceImpl(dio: ref.watch(dioProvider));
});

final courseRepositoryProvider = Provider<CourseRepository>((ref) {
  return CourseRepositoryImpl(
    remoteDataSource: ref.watch(courseRemoteDataSourceProvider),
  );
});

final getCourseFilterOptionsUseCaseProvider =
    Provider<GetCourseFilterOptionsUseCase>((ref) {
      return GetCourseFilterOptionsUseCase(ref.watch(courseRepositoryProvider));
    });

final getCoursesUseCaseProvider = Provider<GetCoursesUseCase>((ref) {
  return GetCoursesUseCase(ref.watch(courseRepositoryProvider));
});

final getMyEnrollmentsUseCaseProvider = Provider<GetMyEnrollmentsUseCase>((
  ref,
) {
  return GetMyEnrollmentsUseCase(ref.watch(courseRepositoryProvider));
});

final getCourseDetailUseCaseProvider = Provider<GetCourseDetailUseCase>((ref) {
  return GetCourseDetailUseCase(ref.watch(courseRepositoryProvider));
});

final enrollCourseUseCaseProvider = Provider<EnrollCourseUseCase>((ref) {
  return EnrollCourseUseCase(ref.watch(courseRepositoryProvider));
});

final getCourseModulesUseCaseProvider = Provider<GetCourseModulesUseCase>((
  ref,
) {
  return GetCourseModulesUseCase(ref.watch(courseRepositoryProvider));
});

final getLessonDetailUseCaseProvider = Provider<GetLessonDetailUseCase>((ref) {
  return GetLessonDetailUseCase(ref.watch(courseRepositoryProvider));
});

final updateLessonProgressUseCaseProvider =
    Provider<UpdateLessonProgressUseCase>((ref) {
      return UpdateLessonProgressUseCase(ref.watch(courseRepositoryProvider));
    });

// ============================================================================
// PRESENTATION CONTROLLER PROVIDERS
// ============================================================================

final coursesControllerProvider =
    NotifierProvider<CoursesController, CoursesState>(CoursesController.new);

final courseDetailControllerProvider =
    NotifierProvider<CourseDetailController, CourseDetailState>(
      CourseDetailController.new,
    );

final lessonDetailControllerProvider =
    NotifierProvider<LessonDetailController, LessonDetailState>(
      LessonDetailController.new,
    );
