import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rental_car/features/course/domain/entities/course_entity.dart';
import 'package:rental_car/features/course/domain/entities/lesson_entity.dart';
import 'package:rental_car/features/course/domain/entities/module_entity.dart';
import 'package:rental_car/features/course/presentation/widgets/course_detail/course_about_section.dart';
import 'package:rental_car/features/course/presentation/widgets/course_detail/course_detail_bottom_bar.dart';
import 'package:rental_car/features/course/presentation/widgets/course_detail/course_detail_hero_header.dart';
import 'package:rental_car/features/course/presentation/widgets/course_detail/course_sliver_hero_header.dart';
import 'package:rental_car/features/course/presentation/widgets/course_detail/course_syllabus_tab_view.dart';
import 'package:rental_car/features/course/presentation/widgets/course_detail/course_tab_header_delegate.dart';
import 'package:rental_car/features/course/presentation/widgets/lesson_detail/lesson_app_bar.dart';
import 'package:rental_car/features/course/presentation/widgets/lesson_detail/lesson_assessment_result_box.dart';
import 'package:rental_car/features/course/presentation/widgets/lesson_detail/lesson_bottom_bar.dart';
import 'package:rental_car/features/course/presentation/widgets/lesson_detail/lesson_content_card.dart';
import 'package:rental_car/features/course/presentation/widgets/lesson_detail/lesson_toc_bottom_sheet.dart';
import 'package:rental_car/features/course/presentation/widgets/lesson_detail/lesson_video_player_box.dart';

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
    title:
        '1. Giới thiệu tổng quan về kiến trúc Clean Architecture trong Mobile App',
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

  testWidgets(
    'Test CourseDetail single-page layout (About top, Syllabus below) on 360px screen',
    (tester) async {
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
    },
  );

  testWidgets(
    'Test LessonContentCard on compact 320px screen without overflow',
    (tester) async {
      tester.view.physicalSize = const Size(640, 1280);
      tester.view.devicePixelRatio = 2.0; // 320 logical width
      addTearDown(() => tester.view.resetPhysicalSize());

      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
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
        ),
      );
      await tester.pump();

      expect(find.byType(LessonContentCard), findsOneWidget);
      expect(find.text('Nội dung bài học'), findsOneWidget);
      expect(find.text('Tài liệu & Slide'), findsOneWidget);
      expect(find.text('TS. Nguyễn Xuân Phong'), findsNothing);
      expect(find.text('Bài đọc lý thuyết'), findsNothing);
    },
  );
  testWidgets(
    'Test LessonContentCard for Quiz on compact 320px screen without overflow',
    (tester) async {
      tester.view.physicalSize = const Size(640, 1280);
      tester.view.devicePixelRatio = 2.0; // 320 logical width
      addTearDown(() => tester.view.resetPhysicalSize());

      const quizLesson = LessonEntity(
        id: 'l_quiz',
        moduleId: 'm1',
        title: '2. Bài kiểm tra đánh giá cuối chương Clean Architecture',
        type: 'QUIZ',
        typeName: 'Bài tập trắc nghiệm',
        estimatedMinutes: 25,
        quizId: 'quiz_123',
      );

      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: SingleChildScrollView(
                child: LessonContentCard(
                  lesson: quizLesson,
                  isCompleted: false,
                  instructorName: 'TS. Nguyễn Xuân Phong',
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(LessonContentCard), findsOneWidget);
      // Lesson title is hidden in card for quiz (already in AppBar)
      expect(
        find.text('2. Bài kiểm tra đánh giá cuối chương Clean Architecture'),
        findsNothing,
      );
      expect(find.text('Trắc nghiệm'), findsOneWidget);
      expect(find.text('25 phút'), findsOneWidget);
      expect(find.text('80% Đạt'), findsOneWidget);
      expect(find.text('Bắt đầu làm'), findsOneWidget);
      // Description is inside the card at the top
      expect(
        find.text(
          'Vượt qua bài kiểm tra trắc nghiệm với điểm số từ 80% trở lên để hoàn thành bài học.',
        ),
        findsOneWidget,
      );
      // Ensure redundant elements are removed
      expect(find.text('BÀI KIỂM TRA ĐÁNH GIÁ'), findsNothing);
      expect(find.text('TS. Nguyễn Xuân Phong'), findsNothing);
      expect(
        find.text('Người biên soạn • Giảng viên Đại học FPT'),
        findsNothing,
      );
      expect(find.text('Mẹo làm bài hiệu quả:'), findsNothing);
      expect(find.text('Mục tiêu kiến thức cần đạt:'), findsNothing);
    },
  );

  testWidgets(
    'Test LessonBottomBar for Quiz hides complete button and shows navigation',
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            bottomNavigationBar: LessonBottomBar(
              isCompleted: false,
              isUpdating: false,
              isQuiz: true,
              onTapPrevious: () {},
              onToggleComplete: () {},
              onTapNext: () {},
            ),
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(LessonBottomBar), findsOneWidget);
      expect(find.text('Hoàn thành bài học'), findsNothing);
      expect(find.text('Bài tiếp'), findsOneWidget);
      expect(find.text('Bài trước'), findsOneWidget);
    },
  );

  testWidgets('Test LessonAppBar has no heart icon and renders TOC button', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          appBar: LessonAppBar(
            lesson: sampleLesson,
            course: sampleCourse,
            modules: sampleModules,
            onSelectLesson: _dummyTap,
          ),
        ),
      ),
    );
    await tester.pump();

    expect(find.byIcon(Icons.favorite_border_rounded), findsNothing);
    expect(find.byIcon(Icons.format_list_bulleted_rounded), findsOneWidget);
    expect(find.textContaining('PRN211'), findsOneWidget);
    expect(find.text('Đã học'), findsNothing);

    // Test with isCompleted: true
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          appBar: LessonAppBar(
            lesson: sampleLesson,
            course: sampleCourse,
            modules: sampleModules,
            onSelectLesson: _dummyTap,
            isCompleted: true,
          ),
        ),
      ),
    );
    await tester.pump();
    expect(find.text('Đã học'), findsOneWidget);
  });

  testWidgets(
    'Test LessonTocBottomSheet renders modules, green checkmark for completed, and lesson type badges',
    (tester) async {
      const moduleWithLessons = ModuleEntity(
        id: 'm1',
        courseId: 'c1',
        title: 'Chương 1: Khởi động',
        lessons: [
          LessonEntity(
            id: 'l1',
            moduleId: 'm1',
            title: 'Bài 1: Giới thiệu',
            type: 'VIDEO',
            isCompleted: true,
          ),
          LessonEntity(id: 'l2', moduleId: 'm1', title: 'Bài 2: Thực hành'),
          LessonEntity(
            id: 'l3',
            moduleId: 'm1',
            title: 'Bài 3: Kiểm tra',
            type: 'QUIZ',
          ),
        ],
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: LessonTocBottomSheet(
              currentLessonId: 'l2',
              modules: [moduleWithLessons],
              onSelectLesson: _dummyTap,
            ),
          ),
        ),
      );
      await tester.pump();

      expect(find.text('Mục lục khóa học'), findsOneWidget);
      expect(find.text('MỤC 1'), findsOneWidget);
      expect(find.text('Chương 1: Khởi động'), findsOneWidget);
      // Completed lesson checkmark
      expect(find.byIcon(Icons.check_rounded), findsOneWidget);
      // Lesson type badges
      expect(find.text('Video'), findsOneWidget);
      expect(find.text('Lý thuyết'), findsOneWidget);
      expect(find.text('Kiểm tra'), findsOneWidget);
    },
  );

  testWidgets(
    'Test LessonAssessmentResultBox renders failed state with target requirement',
    (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: LessonAssessmentResultBox(
              isPassed: false,
              bestPercentage: 60.0,
            ),
          ),
        ),
      );
      await tester.pump();

      expect(find.text('CHƯA ĐẠT'), findsOneWidget);
      expect(find.text('60%'), findsOneWidget);
      expect(find.text('Điểm cao nhất'), findsOneWidget);
      expect(find.textContaining('Điều kiện đạt:'), findsOneWidget);
      expect(find.textContaining('≥ 80%'), findsOneWidget);
      expect(find.textContaining('+20%'), findsOneWidget);
      expect(find.byIcon(Icons.cancel_rounded), findsOneWidget);
    },
  );

  testWidgets(
    'Test LessonAssessmentResultBox renders passed state with congratulations',
    (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: LessonAssessmentResultBox(
              isPassed: true,
              bestPercentage: 90.0,
            ),
          ),
        ),
      );
      await tester.pump();

      expect(find.text('ĐẠT YÊU CẦU'), findsOneWidget);
      expect(find.text('90%'), findsOneWidget);
      expect(find.text('Điểm cao nhất'), findsOneWidget);
      expect(
        find.text(
          'Xin chúc mừng! Bạn đã hoàn thành xuất sắc bài kiểm tra này.',
        ),
        findsOneWidget,
      );
      expect(find.byIcon(Icons.check_circle_rounded), findsOneWidget);
    },
  );

  testWidgets(
    'Test CourseSliverHeroHeader and CourseTabHeaderDelegate render smoothly',
    (tester) async {
      int activeTab = 0;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomScrollView(
              slivers: [
                const CourseSliverHeroHeader(
                  course: sampleCourse,
                  completedCount: 6,
                  totalLessons: 24,
                ),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: CourseTabHeaderDelegate(
                    selectedIndex: activeTab,
                    totalLessons: 24,
                    onTabChanged: (i) => activeTab = i,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(CourseSliverHeroHeader), findsOneWidget);
      expect(find.text('PRN211'), findsAtLeastNWidgets(1));
      expect(find.text('Giáo trình (24 bài)'), findsOneWidget);
      expect(find.text('Tổng quan & CLO'), findsOneWidget);
    },
  );

  testWidgets(
    'Test Option 1: LessonDetail layout with LessonAppBar and Cinema Video',
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            appBar: const LessonAppBar(
              lesson: sampleLesson,
              course: sampleCourse,
              modules: sampleModules,
              onSelectLesson: _dummyTap,
              isCompleted: true,
            ),
            body: Column(
              children: [
                LessonVideoPlayerBox(
                  estimatedMinutes: sampleLesson.estimatedMinutes,
                  videoUrl: 'https://www.youtube.com/watch?v=KJgsSFOSQv0',
                  title: sampleLesson.title,
                  isCinemaMode: true,
                ),
                const Expanded(
                  child: SingleChildScrollView(
                    child: LessonContentCard(
                      lesson: sampleLesson,
                      isCompleted: true,
                      showMediaHeader: false,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(LessonAppBar), findsOneWidget);
      expect(find.byType(LessonVideoPlayerBox), findsOneWidget);
      expect(find.byType(LessonContentCard), findsOneWidget);
      expect(find.textContaining('PRN211'), findsOneWidget);
      expect(find.text('Đã học'), findsOneWidget);
      expect(find.byIcon(Icons.format_list_bulleted_rounded), findsOneWidget);
    },
  );
}

void _dummyTap(LessonEntity l) {}
