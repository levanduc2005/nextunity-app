import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rental_car/core/error/failure.dart';
import 'package:rental_car/core/utils/result.dart';
import 'package:rental_car/features/course/domain/entities/course_entity.dart';
import 'package:rental_car/features/course/domain/entities/course_filter_options_entity.dart';
import 'package:rental_car/features/course/domain/entities/enrollment_entity.dart';
import 'package:rental_car/features/course/domain/entities/lesson_entity.dart';
import 'package:rental_car/features/course/domain/entities/module_entity.dart';
import 'package:rental_car/features/course/domain/repositories/course_repository.dart';
import 'package:rental_car/features/course/domain/usecases/enroll_course_usecase.dart';
import 'package:rental_car/features/course/domain/usecases/get_course_detail_usecase.dart';
import 'package:rental_car/features/course/domain/usecases/get_course_filter_options_usecase.dart';
import 'package:rental_car/features/course/domain/usecases/get_course_modules_usecase.dart';
import 'package:rental_car/features/course/domain/usecases/get_courses_usecase.dart';
import 'package:rental_car/features/course/domain/usecases/get_lesson_detail_usecase.dart';
import 'package:rental_car/features/course/domain/usecases/get_my_enrollments_usecase.dart';
import 'package:rental_car/features/course/domain/usecases/update_lesson_progress_usecase.dart';

class MockCourseRepository extends Mock implements CourseRepository {}

void main() {
  late MockCourseRepository repository;
  late GetCourseFilterOptionsUseCase getCourseFilterOptionsUseCase;
  late GetCoursesUseCase getCoursesUseCase;
  late GetMyEnrollmentsUseCase getMyEnrollmentsUseCase;
  late GetCourseDetailUseCase getCourseDetailUseCase;
  late EnrollCourseUseCase enrollCourseUseCase;
  late GetCourseModulesUseCase getCourseModulesUseCase;
  late GetLessonDetailUseCase getLessonDetailUseCase;
  late UpdateLessonProgressUseCase updateLessonProgressUseCase;

  setUp(() {
    repository = MockCourseRepository();
    getCourseFilterOptionsUseCase = GetCourseFilterOptionsUseCase(repository);
    getCoursesUseCase = GetCoursesUseCase(repository);
    getMyEnrollmentsUseCase = GetMyEnrollmentsUseCase(repository);
    getCourseDetailUseCase = GetCourseDetailUseCase(repository);
    enrollCourseUseCase = EnrollCourseUseCase(repository);
    getCourseModulesUseCase = GetCourseModulesUseCase(repository);
    getLessonDetailUseCase = GetLessonDetailUseCase(repository);
    updateLessonProgressUseCase = UpdateLessonProgressUseCase(repository);
  });

  const testCourse = CourseEntity(
    id: 'course-exe201',
    code: 'EXE201',
    title: 'Khởi nghiệp Đổi mới Sáng tạo',
    totalLessons: 24,
    totalModules: 6,
    progress: 0.42,
    isEnrolled: true,
  );

  const testEnrollment = EnrollmentEntity(
    id: 'enr-exe201',
    courseId: 'course-exe201',
    courseCode: 'EXE201',
    courseTitle: 'Khởi nghiệp Đổi mới Sáng tạo',
    totalLessons: 24,
    progressPercent: 42,
  );

  const testModule = ModuleEntity(
    id: 'mod-1',
    courseId: 'course-exe201',
    title: 'Module 1: Ý tưởng',
  );

  const testLesson = LessonEntity(
    id: 'lesson-2-3',
    moduleId: 'mod-2',
    title: 'Bài 2.3: Phỏng vấn The Mom Test',
    estimatedMinutes: 25,
  );

  group('Course UseCases Tests', () {
    test(
      'GetCourseFilterOptionsUseCase returns combined filter options on success',
      () async {
        const options = CourseFilterOptionsEntity(
          categories: {
            'FPT_COURSES': 'FPT Courses',
            'SOFTWARE_ENGINEERING': 'Kỹ thuật phần mềm (SE)',
          },
          difficulties: {
            'BEGINNER': 'Cơ bản',
            'INTERMEDIATE': 'Trung cấp',
            'ADVANCED': 'Nâng cao',
          },
        );
        when(
          () => repository.getFilterOptions(),
        ).thenAnswer((_) async => const Result.ok(options));

        final result = await getCourseFilterOptionsUseCase();

        expect(result.isOk, isTrue);
        expect(result.valueOrNull, equals(options));
        verify(() => repository.getFilterOptions()).called(1);
      },
    );

    test('GetCoursesUseCase returns list of courses on success', () async {
      when(
        () => repository.getCourses(),
      ).thenAnswer((_) async => const Result.ok([testCourse]));

      final result = await getCoursesUseCase();

      expect(result.isOk, isTrue);
      expect(result.valueOrNull, equals([testCourse]));
      verify(() => repository.getCourses()).called(1);
    });

    test(
      'GetMyEnrollmentsUseCase returns list of enrollments on success',
      () async {
        when(
          () => repository.getMyEnrollments(),
        ).thenAnswer((_) async => const Result.ok([testEnrollment]));

        final result = await getMyEnrollmentsUseCase();

        expect(result.isOk, isTrue);
        expect(result.valueOrNull, equals([testEnrollment]));
        verify(() => repository.getMyEnrollments()).called(1);
      },
    );

    test('GetCourseDetailUseCase returns CourseEntity on success', () async {
      when(
        () => repository.getCourseDetail('course-exe201'),
      ).thenAnswer((_) async => const Result.ok(testCourse));

      final result = await getCourseDetailUseCase('course-exe201');

      expect(result.isOk, isTrue);
      expect(result.valueOrNull, equals(testCourse));
      verify(() => repository.getCourseDetail('course-exe201')).called(1);
    });

    test('EnrollCourseUseCase returns EnrollmentEntity on success', () async {
      when(
        () => repository.enrollCourse('course-exe201'),
      ).thenAnswer((_) async => const Result.ok(testEnrollment));

      final result = await enrollCourseUseCase('course-exe201');

      expect(result.isOk, isTrue);
      expect(result.valueOrNull, equals(testEnrollment));
      verify(() => repository.enrollCourse('course-exe201')).called(1);
    });

    test('EnrollCourseUseCase returns Failure on error', () async {
      when(() => repository.enrollCourse('course-exe201')).thenAnswer(
        (_) async =>
            const Result.err(ServerFailure(message: 'Lỗi đăng ký khóa học')),
      );

      final result = await enrollCourseUseCase('course-exe201');

      expect(result.isErr, isTrue);
      expect(result.failureOrNull, isA<ServerFailure>());
      verify(() => repository.enrollCourse('course-exe201')).called(1);
    });

    test(
      'GetCourseModulesUseCase returns list of modules on success',
      () async {
        when(
          () => repository.getCourseModules('course-exe201'),
        ).thenAnswer((_) async => const Result.ok([testModule]));

        final result = await getCourseModulesUseCase('course-exe201');

        expect(result.isOk, isTrue);
        expect(result.valueOrNull, equals([testModule]));
        verify(() => repository.getCourseModules('course-exe201')).called(1);
      },
    );

    test('GetLessonDetailUseCase returns LessonEntity on success', () async {
      when(
        () => repository.getLessonDetail('lesson-2-3'),
      ).thenAnswer((_) async => const Result.ok(testLesson));

      final result = await getLessonDetailUseCase('lesson-2-3');

      expect(result.isOk, isTrue);
      expect(result.valueOrNull, equals(testLesson));
      verify(() => repository.getLessonDetail('lesson-2-3')).called(1);
    });

    test(
      'UpdateLessonProgressUseCase returns updated progress percent',
      () async {
        when(
          () =>
              repository.updateLessonProgress('lesson-2-3', isCompleted: true),
        ).thenAnswer((_) async => const Result.ok(50));

        final result = await updateLessonProgressUseCase(
          'lesson-2-3',
          isCompleted: true,
        );

        expect(result.isOk, isTrue);
        expect(result.valueOrNull, equals(50));
        verify(
          () =>
              repository.updateLessonProgress('lesson-2-3', isCompleted: true),
        ).called(1);
      },
    );
  });
}
