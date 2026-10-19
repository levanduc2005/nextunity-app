import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_car/features/course/domain/entities/lesson_entity.dart';
import 'package:rental_car/features/course/presentation/providers/course_providers.dart';

class LessonDetailState {
  const LessonDetailState({
    this.lesson,
    this.isLoading = false,
    this.isUpdatingProgress = false,
    this.isCompleted = false,
    this.courseProgressPercent = 0,
    this.errorMessage,
  });

  final LessonEntity? lesson;
  final bool isLoading;
  final bool isUpdatingProgress;
  final bool isCompleted;
  final int courseProgressPercent;
  final String? errorMessage;

  LessonDetailState copyWith({
    LessonEntity? lesson,
    bool? isLoading,
    bool? isUpdatingProgress,
    bool? isCompleted,
    int? courseProgressPercent,
    String? errorMessage,
    bool clearError = false,
  }) {
    return LessonDetailState(
      lesson: lesson ?? this.lesson,
      isLoading: isLoading ?? this.isLoading,
      isUpdatingProgress: isUpdatingProgress ?? this.isUpdatingProgress,
      isCompleted: isCompleted ?? this.isCompleted,
      courseProgressPercent:
          courseProgressPercent ?? this.courseProgressPercent,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}

class LessonDetailController extends Notifier<LessonDetailState> {
  @override
  LessonDetailState build() {
    return const LessonDetailState();
  }

  Future<void> loadLesson(String lessonId) async {
    if (state.lesson?.id != lessonId) {
      state = const LessonDetailState(isLoading: true);
    } else {
      state = state.copyWith(isLoading: true, clearError: true);
    }
    final result = await ref
        .read(getLessonDetailUseCaseProvider)
        .call(lessonId);

    result.when(
      ok: (data) {
        state = state.copyWith(
          lesson: data,
          isCompleted: data.isCompleted,
          isLoading: false,
        );
      },
      err: (failure) {
        state = state.copyWith(isLoading: false, errorMessage: failure.message);
      },
    );
  }

  Future<bool> toggleComplete() async {
    final currentLesson = state.lesson;
    if (currentLesson == null) return false;

    final newCompletedStatus = !state.isCompleted;
    state = state.copyWith(isUpdatingProgress: true);

    final result = await ref
        .read(updateLessonProgressUseCaseProvider)
        .call(currentLesson.id, isCompleted: newCompletedStatus);

    return result.when(
      ok: (percent) {
        state = state.copyWith(
          isCompleted: newCompletedStatus,
          courseProgressPercent: percent,
          isUpdatingProgress: false,
          lesson: currentLesson.copyWith(isCompleted: newCompletedStatus),
        );
        // Refresh danh sách khóa học
        ref.read(coursesControllerProvider.notifier).refresh();
        // Cập nhật lại chi tiết khóa học nếu đang mở
        final courseId = ref.read(courseDetailControllerProvider).course?.id;
        if (courseId != null) {
          ref
              .read(courseDetailControllerProvider.notifier)
              .loadCourseDetail(courseId);
        }
        return true;
      },
      err: (failure) {
        state = state.copyWith(
          isUpdatingProgress: false,
          errorMessage: failure.message,
        );
        return false;
      },
    );
  }

  void reset() {
    state = const LessonDetailState();
  }
}
