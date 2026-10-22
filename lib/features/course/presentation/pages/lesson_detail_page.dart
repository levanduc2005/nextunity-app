import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/core/widgets/widgets.dart';
import 'package:rental_car/features/course/presentation/providers/course_providers.dart';
import 'package:rental_car/features/course/presentation/widgets/lesson_detail/lesson_app_bar.dart';
import 'package:rental_car/features/course/presentation/widgets/lesson_detail/lesson_bottom_bar.dart';
import 'package:rental_car/features/course/presentation/widgets/lesson_detail/lesson_content_card.dart';

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

    final allLessons = [
      for (final module in courseDetailState.modules) ...module.lessons,
    ];
    final currentIndex = allLessons.indexWhere((l) => l.id == lesson.id);
    final hasPrev = currentIndex > 0;
    final hasNext = currentIndex >= 0 && currentIndex < allLessons.length - 1;
    final prevLesson = hasPrev ? allLessons[currentIndex - 1] : null;
    final nextLesson = hasNext ? allLessons[currentIndex + 1] : null;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: LessonAppBar(
        lesson: lesson,
        course: courseDetailState.course,
        modules: courseDetailState.modules,
        onSelectLesson: (selected) => _switchLesson(selected.id),
        onFavorite: () {
          context.showSuccessSnackBar('Đã lưu bài học vào danh sách yêu thích');
        },
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        physics: const BouncingScrollPhysics(),
        child: LessonContentCard(
          lesson: lesson,
          isCompleted: state.isCompleted,
          instructorName: courseDetailState.course?.creatorName,
        ),
      ),
      bottomNavigationBar: LessonBottomBar(
        isCompleted: state.isCompleted,
        isUpdating: state.isUpdatingProgress,
        hasPrevious: hasPrev,
        hasNext: hasNext,
        onTapPrevious: () {
          if (hasPrev && prevLesson != null) {
            _switchLesson(prevLesson.id);
          } else {
            context.pop();
          }
        },
        onToggleComplete: controller.toggleComplete,
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
