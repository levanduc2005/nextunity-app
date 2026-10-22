import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rental_car/features/course/domain/entities/course_entity.dart';
import 'package:rental_car/features/course/domain/entities/lesson_entity.dart';
import 'package:rental_car/features/course/domain/entities/module_entity.dart';
import 'package:rental_car/features/course/presentation/widgets/course_detail/course_about_section.dart';
import 'package:rental_car/features/course/presentation/widgets/course_detail/course_detail_bottom_bar.dart';
import 'package:rental_car/features/course/presentation/widgets/course_detail/course_detail_hero_header.dart';
import 'package:rental_car/features/course/presentation/widgets/course_detail/course_syllabus_tab_view.dart';
import 'package:rental_car/features/course/presentation/widgets/lesson_detail/lesson_content_card.dart';

void main() {
  const sampleCourse = CourseEntity(
    id: 'c1',
    code: 'PRN211',
    title: 'Basic Cross-Platform Application Programming with Flutter & .NET',
    categoryName: 'Software Engineering',
    creatorName: 'TS. Nguyễn Xuân Phong',
    totalLessons: 24,
    totalModules: 4,
    reviewCount: 1420,
    isEnrolled: true,
  );

  const sampleLesson = LessonEntity(
    id: 'l1',
    moduleId: 'm1',
    title: '1. Giới thiệu tổng quan về kiến trúc Clean Architecture trong Mobile App',
    type: 'VIDEO',
    typeName: 'Video bài giảng',
    estimatedMinutes: 20,
    slideUrl: 'https://example.com/prn211_slide.pdf',
    content: '## Giới thiệu\n\nNội dung bài học lý thuyết...',
  );

  const sampleModules = [
    ModuleEntity(
      id: 'm1',
      courseId: 'c1',
      title: 'Chương 1: Tổng quan Flutter và Clean Architecture',
      lessons: [sampleLesson],
    ),
  ];

  testWidgets('Test CourseDetail single-page layout (About top, Syllabus below) on 360px screen', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 3.0; // 360 logical width
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: const SingleChildScrollView(
            child: Column(
              children: [
                CourseDetailHeroHeader(
                  course: sampleCourse,
                  completedCount: 6,
                  totalLessons: 24,
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      CourseAboutSection(course: sampleCourse),
                      SizedBox(height: 24),
                      CourseSyllabusTabView(
                        modules: sampleModules,
                        isEnrolled: true,
                        isCourseCompleted: false,
                        onTapLesson: _dummyTap,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: CourseDetailBottomBar(
            isEnrolled: true,
            isEnrolling: false,
            onTapPrimary: () {},
            onTapCurriculum: () {},
          ),
        ),
      ),
    );
    await tester.pump();

    expect(find.byType(CourseDetailHeroHeader), findsOneWidget);
    expect(find.byType(CourseAboutSection), findsOneWidget);
    expect(find.byType(CourseSyllabusTabView), findsOneWidget);
    expect(find.byType(CourseDetailBottomBar), findsOneWidget);
    expect(find.text('Giáo trình'), findsOneWidget);
    expect(find.text('Vào học ngay'), findsOneWidget);
    expect(find.text('Giới thiệu môn học'), findsOneWidget);
    expect(find.text('Giáo trình bài học'), findsOneWidget);
  });

  testWidgets('Test LessonContentCard on compact 320px screen without overflow', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(640, 1280);
    tester.view.devicePixelRatio = 2.0; // 320 logical width
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: LessonContentCard(
              lesson: sampleLesson,
              isCompleted: false,
              instructorName: 'TS. Nguyễn Xuân Phong',
            ),
          ),
        ),
      ),
    );
    await tester.pump();

    expect(find.byType(LessonContentCard), findsOneWidget);
    expect(find.text('Nội dung bài học'), findsOneWidget);
    expect(find.text('Tài liệu & Slide'), findsOneWidget);
  });
}

void _dummyTap(LessonEntity l) {}
