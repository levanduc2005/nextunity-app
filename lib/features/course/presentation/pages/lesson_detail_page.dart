import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/core/widgets/widgets.dart';
import 'package:rental_car/features/course/presentation/providers/course_providers.dart';
import 'package:rental_car/features/course/presentation/widgets/lesson_detail/lesson_app_bar.dart';
import 'package:rental_car/features/course/presentation/widgets/lesson_detail/lesson_bottom_bar.dart';
import 'package:rental_car/features/course/presentation/widgets/lesson_detail/lesson_content_card.dart';
import 'package:rental_car/features/course/presentation/widgets/lesson_detail/lesson_video_player_box.dart';
import 'package:rental_car/features/quiz/domain/entities/quiz_submission_summary_entity.dart';
import 'package:rental_car/features/quiz/presentation/providers/quiz_providers.dart';

class LessonDetailPage extends ConsumerStatefulWidget {
  const LessonDetailPage({required this.lessonId, super.key});

  final String lessonId;

  @override
  ConsumerState<LessonDetailPage> createState() => _LessonDetailPageState();
}

class _LessonDetailPageState extends ConsumerState<LessonDetailPage> {
  final ScrollController _scrollController = ScrollController();
  late String _currentLessonId;

  @override
  void initState() {
    super.initState();
    _currentLessonId = widget.lessonId;
    Future.microtask(() {
      ref
          .read(lessonDetailControllerProvider.notifier)
          .loadLesson(_currentLessonId);
    });
  }

  @override
  void didUpdateWidget(covariant LessonDetailPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.lessonId != widget.lessonId) {
      _switchLesson(widget.lessonId);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(0);
    }
  }

  void _switchLesson(String newLessonId) {
    if (_currentLessonId == newLessonId &&
        ref.read(lessonDetailControllerProvider).lesson?.id == newLessonId) {
      return;
    }
    _scrollToTop();
    setState(() {
      _currentLessonId = newLessonId;
    });
    ref.read(lessonDetailControllerProvider.notifier).loadLesson(newLessonId);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(lessonDetailControllerProvider);
    final controller = ref.read(lessonDetailControllerProvider.notifier);
    final courseDetailState = ref.watch(courseDetailControllerProvider);

    final isDifferentLesson =
        state.lesson != null && state.lesson!.id != _currentLessonId;
    final isDataReady = state.lesson != null && !isDifferentLesson;

    if (state.isLoading || !isDataReady) {
      if (state.errorMessage != null && !isDataReady) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
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
                    color: AppColors.error,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    state.errorMessage!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => controller.loadLesson(_currentLessonId),
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
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
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

    final lesson = state.lesson!;

    final quizId = lesson.quizId;
    bool hasPassedQuiz = false;
    if (quizId != null && quizId.isNotEmpty) {
      final quizSubmissions =
          ref.watch(myQuizSubmissionsProvider(quizId)).asData?.value ??
          const <QuizSubmissionSummaryEntity>[];
      final quizState = ref.watch(quizControllerProvider);
      final justPassed =
          quizState.isSubmitted &&
          quizState.result?.quizId == quizId &&
          (quizState.result?.isPassed ?? false);
      hasPassedQuiz =
          justPassed ||
          quizSubmissions.any((QuizSubmissionSummaryEntity s) => s.isPassed);
    }
    final effectiveIsCompleted = state.isCompleted || hasPassedQuiz;

    final modulesWithUpdatedStatus = hasPassedQuiz
        ? courseDetailState.modules.map((m) {
            return m.copyWith(
              lessons: m.lessons.map((l) {
                if (l.id == lesson.id) {
                  return l.copyWith(isCompleted: true);
                }
                return l;
              }).toList(),
            );
          }).toList()
        : courseDetailState.modules;

    final allLessons = [
      for (final module in modulesWithUpdatedStatus) ...module.lessons,
    ];
    final currentIndex = allLessons.indexWhere((l) => l.id == lesson.id);
    final hasPrev = currentIndex > 0;
    final hasNext = currentIndex >= 0 && currentIndex < allLessons.length - 1;
    final prevLesson = hasPrev ? allLessons[currentIndex - 1] : null;
    final nextLesson = hasNext ? allLessons[currentIndex + 1] : null;

    final isQuiz = lesson.type == 'QUIZ';
    final isVideoLesson =
        !isQuiz &&
        (lesson.type == 'VIDEO' ||
            (lesson.videoUrl != null && lesson.videoUrl!.trim().isNotEmpty));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: LessonAppBar(
        lesson: lesson,
        course: courseDetailState.course,
        modules: modulesWithUpdatedStatus,
        onSelectLesson: (selected) => _switchLesson(selected.id),
        isCompleted: effectiveIsCompleted,
      ),
      body: Column(
        children: [
          // 1. Sticky Zero-Margin Cinema Video Player nếu là bài có Video
          if (isVideoLesson)
            LessonVideoPlayerBox(
              estimatedMinutes: lesson.estimatedMinutes,
              videoUrl: lesson.videoUrl,
              title: lesson.title,
              isCinemaMode: true,
            ),

          // 2. Khung đọc bài cuộn độc lập (Không còn Subheader trùng lặp với AppBar)
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 28),
              physics: const BouncingScrollPhysics(),
              child: LessonContentCard(
                lesson: lesson,
                isCompleted: effectiveIsCompleted,
                instructorName: courseDetailState.course?.creatorName,
                showMediaHeader: isQuiz,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: LessonBottomBar(
        isCompleted: effectiveIsCompleted,
        isUpdating: state.isUpdatingProgress,
        hasPrevious: hasPrev,
        hasNext: hasNext,
        isQuiz: isQuiz,
        onTapPrevious: () {
          if (hasPrev && prevLesson != null) {
            _switchLesson(prevLesson.id);
          } else {
            context.pop();
          }
        },
        onToggleComplete: controller.markAsComplete,
        onTapNext: () {
          if (hasNext && nextLesson != null) {
            _switchLesson(nextLesson.id);
          } else {
            context.showSuccessSnackBar(
              'Bạn đã học tới bài cuối cùng của khóa học!',
            );
          }
        },
      ),
    );
  }
}
