import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rental_car/core/providers/core_providers.dart';
import 'package:rental_car/features/course/domain/entities/course_entity.dart';
import 'package:rental_car/features/course/domain/entities/enrollment_entity.dart';
import 'package:rental_car/features/course/presentation/pages/courses_page.dart';
import 'package:rental_car/features/course/presentation/providers/course_providers.dart';
import 'package:rental_car/features/course/presentation/widgets/courses_tab/discovery_course_card.dart';
import 'package:rental_car/features/course/presentation/widgets/courses_tab/ongoing_courses_section.dart';

class _FakeCoursesController extends CoursesController {
  _FakeCoursesController(this._initial);

  final CoursesState _initial;

  @override
  CoursesState build() => _initial;
}

void main() {
  const sampleEnrollment = EnrollmentEntity(
    id: 'enr-1',
    courseId: 'c1',
    courseCode: 'EXE201',
    courseTitle: 'Khởi nghiệp Đổi mới Sáng tạo',
    courseDifficultyName: 'Cơ bản',
    totalLessons: 20,
    progressPercent: 40,
    instructorName: 'TS. Nguyễn Xuân Phong',
  );

  const sampleCourse = CourseEntity(
    id: 'c1',
    code: 'EXE201',
    title: 'Khởi nghiệp Đổi mới Sáng tạo',
    categoryName: 'Khởi nghiệp',
    difficultyName: 'Cơ bản',
    totalLessons: 20,
    totalModules: 5,
    creatorName: 'TS. Nguyễn Xuân Phong',
    isEnrolled: true,
  );

  testWidgets(
    'Test CoursesPage ApSkil layout renders Ongoing and Discovery sections',
    (tester) async {
      final state = const CoursesState().copyWith(
        isLoading: false,
        myEnrollments: [sampleEnrollment],
        allCourses: [sampleCourse],
        categories: {'SE': 'Kỹ thuật phần mềm', 'AI': 'Trí tuệ nhân tạo'},
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            currentUserProvider.overrideWithValue(null),
            coursesControllerProvider.overrideWith(
              () => _FakeCoursesController(state),
            ),
          ],
          child: const MaterialApp(home: CoursesPage()),
        ),
      );
      await tester.pump();

      // Verify sections
      expect(find.byType(OngoingCoursesSection), findsOneWidget);
      expect(find.byType(DiscoveryCourseCard), findsOneWidget);

      // Verify texts
      expect(find.text('Môn học đang học'), findsOneWidget);
      expect(find.text('Danh sách môn học'), findsOneWidget);
      expect(find.text('1 môn học'), findsOneWidget);
    },
  );

  testWidgets(
    'Test OngoingCoursesSection switches between ongoing and completed tabs',
    (tester) async {
      const completedEnrollment = EnrollmentEntity(
        id: 'enr-2',
        courseId: 'c2',
        courseCode: 'PRN231',
        courseTitle: 'Lập trình .NET nâng cao',
        courseDifficultyName: 'Nâng cao',
        totalLessons: 10,
        progressPercent: 100,
        status: 'COMPLETED',
      );

      final state = const CoursesState().copyWith(
        isLoading: false,
        myEnrollments: [sampleEnrollment, completedEnrollment],
        allCourses: [sampleCourse],
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            currentUserProvider.overrideWithValue(null),
            coursesControllerProvider.overrideWith(
              () => _FakeCoursesController(state),
            ),
          ],
          child: const MaterialApp(home: CoursesPage()),
        ),
      );
      await tester.pump();

      // Verify pill counts
      expect(find.text('Đang học (1)'), findsOneWidget);
      expect(find.text('Đã xong (1)'), findsOneWidget);
      expect(find.text('Môn học đang học'), findsOneWidget);
      expect(find.text('Khởi nghiệp Đổi mới Sáng tạo'), findsWidgets);

      // Tap on completed tab
      await tester.tap(find.text('Đã xong (1)'));
      await tester.pumpAndSettle();

      // Verify title changes and completed course is shown
      expect(find.text('Môn học đã hoàn thành'), findsOneWidget);
      expect(find.text('Lập trình .NET nâng cao'), findsOneWidget);
      expect(find.text('Hoàn thành'), findsOneWidget);

      // Switch back to ongoing tab
      await tester.tap(find.text('Đang học (1)'));
      await tester.pumpAndSettle();

      expect(find.text('Môn học đang học'), findsOneWidget);
      expect(find.text('Khởi nghiệp Đổi mới Sáng tạo'), findsWidgets);
    },
  );
}
