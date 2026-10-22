import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_car/app/router/app_routes.dart';
import 'package:rental_car/core/providers/core_providers.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/features/course/domain/entities/course_entity.dart';
import 'package:rental_car/features/course/domain/entities/lesson_entity.dart';
import 'package:rental_car/features/course/domain/entities/module_entity.dart';
import 'package:rental_car/features/course/presentation/providers/course_providers.dart';
import 'package:rental_car/features/course/presentation/widgets/course_detail/course_about_section.dart';
import 'package:rental_car/features/course/presentation/widgets/course_detail/course_detail_bottom_bar.dart';
import 'package:rental_car/features/course/presentation/widgets/course_detail/course_detail_hero_header.dart';
import 'package:rental_car/features/course/presentation/widgets/course_detail/course_enroll_prompt_sheet.dart';
import 'package:rental_car/features/course/presentation/widgets/course_detail/course_syllabus_tab_view.dart';

class CourseDetailPage extends ConsumerStatefulWidget {
  const CourseDetailPage({required this.courseId, super.key});

  final String courseId;

  @override
  ConsumerState<CourseDetailPage> createState() => _CourseDetailPageState();
}

class _CourseDetailPageState extends ConsumerState<CourseDetailPage> {
  final GlobalKey _syllabusKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref
          .read(courseDetailControllerProvider.notifier)
          .loadCourseDetail(widget.courseId);
    });
  }

  @override
  void didUpdateWidget(covariant CourseDetailPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.courseId != widget.courseId) {
      ref
          .read(courseDetailControllerProvider.notifier)
          .loadCourseDetail(widget.courseId);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _navigateToLesson(String lessonId) async {
    await context.push(
      AppRoute.lessonDetail.path.replaceFirst(':id', lessonId),
    );
    if (mounted) {
      ref
          .read(courseDetailControllerProvider.notifier)
          .loadCourseDetail(widget.courseId);
    }
  }

  void _handleEnrollOrLearn(
    BuildContext context,
    CourseEntity course,
    bool isUserPlus,
    LessonEntity? targetLesson,
  ) {
    if (course.isEnrolled) {
      if (targetLesson != null) {
        _navigateToLesson(targetLesson.id);
      }
    } else {
      if (course.isPremium && !isUserPlus) {
        context.push(AppRoute.upgradePlus.path);
      } else {
        ref.read(courseDetailControllerProvider.notifier).enroll();
      }
    }
  }

  void _showEnrollPrompt(
    BuildContext context,
    CourseEntity course,
    LessonEntity lesson,
    bool isUserPlus,
  ) {
    CourseEnrollPromptSheet.show(
      context: context,
      course: course,
      lesson: lesson,
      isUserPlus: isUserPlus,
      onEnroll: () =>
          ref.read(courseDetailControllerProvider.notifier).enroll(),
      onUpgradePlus: () => context.push(AppRoute.upgradePlus.path),
    );
  }

  LessonEntity? _findFirstIncompleteLesson(List<ModuleEntity> modules) {
    for (final module in modules) {
      for (final lesson in module.lessons) {
        if (!lesson.isCompleted) {
          return lesson;
        }
      }
    }
    return null;
  }

  void _scrollToSyllabus() {
    final keyContext = _syllabusKey.currentContext;
    if (keyContext != null) {
      Scrollable.ensureVisible(
        keyContext,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(courseDetailControllerProvider);
    final controller = ref.read(courseDetailControllerProvider.notifier);
    final user = ref.watch(currentUserProvider);
    final isUserPlus = user?.isPlus ?? false;

    final isDifferentCourse =
        state.course != null && state.course!.id != widget.courseId;
    final isDataReady = state.course != null && !isDifferentCourse;

    if (state.isLoading || !isDataReady) {
      if (state.errorMessage != null && !isDataReady) {
        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
              onPressed: () => context.pop(),
            ),
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.error_outline_rounded,
                    size: 48,
                    color: Color(0xFFEF4444),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    state.errorMessage!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF64748B),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () =>
                        controller.loadCourseDetail(widget.courseId),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Thử lại'),
                  ),
                ],
              ),
            ),
          ),
        );
      }

      return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
            onPressed: () => context.pop(),
          ),
        ),
        body: const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
          ),
        ),
      );
    }

    final course = state.course!;
    final modules = state.modules;

    final totalFromModules = modules.fold<int>(
      0,
      (sum, m) => sum + m.lessons.length,
    );
    final totalLessons = totalFromModules > 0
        ? totalFromModules
        : course.totalLessons;
    final completedCount = modules.isNotEmpty
        ? modules.fold<int>(0, (sum, m) => sum + m.completedLessonsCount)
        : (course.progress * totalLessons).round();
    final isCourseCompleted =
        course.isEnrolled &&
        ((totalLessons > 0 && completedCount >= totalLessons) ||
            course.progress >= 1.0);

    final firstLesson = modules.isNotEmpty && modules.first.lessons.isNotEmpty
        ? modules.first.lessons.first
        : null;
    final incompleteLesson = _findFirstIncompleteLesson(modules);
    final targetLesson = isCourseCompleted
        ? firstLesson
        : (incompleteLesson ?? firstLesson);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Scrollable Body
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 96),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 1. Sleek Hero Header chuẩn ApSkil
                CourseDetailHeroHeader(
                  course: course,
                  completedCount: completedCount,
                  totalLessons: totalLessons,
                  onPlayTrailer: () => _handleEnrollOrLearn(
                    context,
                    course,
                    isUserPlus,
                    targetLesson,
                  ),
                ),

                // 2. Main Content: Giới thiệu ở TRÊN, Giáo trình ở DƯỚI chung 1 trang
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // 2.1 Giới thiệu môn học (TRÊN)
                      CourseAboutSection(course: course),
                      const SizedBox(height: 24),

                      // 2.2 Giáo trình môn học (DƯỚI)
                      KeyedSubtree(
                        key: _syllabusKey,
                        child: CourseSyllabusTabView(
                          modules: modules,
                          isEnrolled: course.isEnrolled,
                          isCourseCompleted: isCourseCompleted,
                          incompleteLesson: incompleteLesson,
                          onTapLesson: (lesson) {
                            if (course.isEnrolled) {
                              _navigateToLesson(lesson.id);
                            } else {
                              _showEnrollPrompt(
                                context,
                                course,
                                lesson,
                                isUserPlus,
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // 3. Sticky Bottom Action Bar chuẩn ApSkil
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CourseDetailBottomBar(
              isEnrolled: course.isEnrolled,
              isEnrolling: state.isEnrolling,
              isCompleted: isCourseCompleted,
              isPremium: course.isPremium,
              isUserPlus: isUserPlus,
              onTapCurriculum: _scrollToSyllabus,
              lessonLabel: isCourseCompleted
                  ? 'Bạn đã hoàn thành tất cả bài học'
                  : (incompleteLesson != null
                        ? '${incompleteLesson.title} • ${incompleteLesson.estimatedMinutes} phút'
                        : (firstLesson != null
                              ? '${firstLesson.title} • ${firstLesson.estimatedMinutes} phút'
                              : 'Tiếp tục bài học dở dang')),
              onTapPrimary: () => _handleEnrollOrLearn(
                context,
                course,
                isUserPlus,
                targetLesson,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
