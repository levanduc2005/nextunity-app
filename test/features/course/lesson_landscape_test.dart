import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rental_car/features/course/domain/entities/course_entity.dart';
import 'package:rental_car/features/course/domain/entities/lesson_entity.dart';
import 'package:rental_car/features/course/domain/entities/module_entity.dart';
import 'package:rental_car/features/course/presentation/widgets/lesson_detail/lesson_app_bar.dart';
import 'package:rental_car/features/course/presentation/widgets/lesson_detail/lesson_bottom_bar.dart';
import 'package:rental_car/features/course/presentation/widgets/lesson_detail/lesson_content_card.dart';
import 'package:rental_car/features/course/presentation/widgets/lesson_detail/lesson_video_player_box.dart';

void main() {
  const sampleCourse = CourseEntity(
    id: 'c1',
    code: 'PRN211',
    title: 'Mobile Programming',
    categoryName: 'SE',
    creatorName: 'TS. Phong',
    totalLessons: 10,
    totalModules: 2,
    reviewCount: 100,
    isEnrolled: true,
  );

  const sampleLesson = LessonEntity(
    id: 'l1',
    moduleId: 'm1',
    title: '1. Video bài giảng Clean Architecture',
    type: 'VIDEO',
    typeName: 'Video bài giảng',
    estimatedMinutes: 20,
    videoUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
    content: '## Nội dung bài học rất dài\n\n'
        'Đoạn văn bản 1 giới thiệu tổng quan kiến trúc...\n\n'
        '```dart\nvoid main() => runApp(const MyApp());\n```\n\n'
        'Phép toán logic: (p → q) ≡ (¬p ∨ q)\n\n'
        'Đoạn văn bản 2 kết luận...',
  );

  const sampleModules = [
    ModuleEntity(
      id: 'm1',
      courseId: 'c1',
      title: 'Chương 1',
      lessons: [sampleLesson],
    ),
  ];

  Widget buildTestWidget() {
    return MaterialApp(
      home: Scaffold(
        appBar: const LessonAppBar(
          lesson: sampleLesson,
          course: sampleCourse,
          modules: sampleModules,
          onSelectLesson: _dummyTap,
          isCompleted: false,
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            final isLandscape = constraints.maxWidth > constraints.maxHeight;

            if (isLandscape) {
              final maxVideoWidth = constraints.maxWidth * 0.50;
              final naturalVideoWidth = constraints.maxHeight * (16 / 9);
              final videoWidth = math.min(naturalVideoWidth, maxVideoWidth);

              return Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    width: videoWidth,
                    color: Colors.black,
                    child: Center(
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: LessonVideoPlayerBox(
                          estimatedMinutes: sampleLesson.estimatedMinutes,
                          videoUrl: sampleLesson.videoUrl,
                          title: sampleLesson.title,
                          isCinemaMode: true,
                        ),
                      ),
                    ),
                  ),
                  const VerticalDivider(width: 1, thickness: 1),
                  Expanded(
                    child: SingleChildScrollView(
                      key: const ValueKey('lesson_content_scroll'),
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                      physics: const BouncingScrollPhysics(),
                      child: const LessonContentCard(
                        lesson: sampleLesson,
                        isCompleted: false,
                        showMediaHeader: false,
                      ),
                    ),
                  ),
                ],
              );
            }

            return Column(
              children: [
                LessonVideoPlayerBox(
                  estimatedMinutes: sampleLesson.estimatedMinutes,
                  videoUrl: sampleLesson.videoUrl,
                  title: sampleLesson.title,
                  isCinemaMode: true,
                ),
                const Expanded(
                  child: SingleChildScrollView(
                    key: ValueKey('lesson_content_scroll'),
                    padding: EdgeInsets.fromLTRB(16, 14, 16, 28),
                    child: LessonContentCard(
                      lesson: sampleLesson,
                      isCompleted: false,
                      showMediaHeader: false,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        bottomNavigationBar: LessonBottomBar(
          isCompleted: false,
          isUpdating: false,
          hasPrevious: false,
          hasNext: true,
          isQuiz: false,
          onTapPrevious: () {},
          onToggleComplete: () {},
          onTapNext: () {},
        ),
      ),
    );
  }

  testWidgets('1. Test Standard Phone Landscape (844x390)', (tester) async {
    tester.view.physicalSize = const Size(844 * 3.0, 390 * 3.0);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(buildTestWidget());
    await tester.pump();

    expect(find.byType(LessonVideoPlayerBox), findsOneWidget);
    expect(find.byKey(const ValueKey('lesson_content_scroll')), findsOneWidget);
    await tester.drag(find.byKey(const ValueKey('lesson_content_scroll')), const Offset(0, -150));
    await tester.pump();
  });

  testWidgets('2. Test Compact Phone Landscape (640x360)', (tester) async {
    tester.view.physicalSize = const Size(640 * 2.0, 360 * 2.0);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(buildTestWidget());
    await tester.pump();

    expect(find.byType(LessonVideoPlayerBox), findsOneWidget);
    expect(find.byKey(const ValueKey('lesson_content_scroll')), findsOneWidget);
    await tester.drag(find.byKey(const ValueKey('lesson_content_scroll')), const Offset(0, -100));
    await tester.pump();
  });

  testWidgets('3. Test Tablet Landscape (1024x768)', (tester) async {
    tester.view.physicalSize = const Size(1024 * 2.0, 768 * 2.0);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(buildTestWidget());
    await tester.pump();

    expect(find.byType(LessonVideoPlayerBox), findsOneWidget);
    expect(find.byKey(const ValueKey('lesson_content_scroll')), findsOneWidget);
    await tester.drag(find.byKey(const ValueKey('lesson_content_scroll')), const Offset(0, -100));
    await tester.pump();
  });

  testWidgets('4. Test Portrait Mode (390x844) retains original behavior', (tester) async {
    tester.view.physicalSize = const Size(390 * 3.0, 844 * 3.0);
    tester.view.devicePixelRatio = 3.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(buildTestWidget());
    await tester.pump();

    expect(find.byType(LessonVideoPlayerBox), findsOneWidget);
    expect(find.byKey(const ValueKey('lesson_content_scroll')), findsOneWidget);
    await tester.drag(find.byKey(const ValueKey('lesson_content_scroll')), const Offset(0, -100));
    await tester.pump();
  });
}

void _dummyTap(LessonEntity l) {}
