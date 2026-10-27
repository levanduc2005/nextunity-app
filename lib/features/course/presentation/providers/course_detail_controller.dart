import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_car/features/course/domain/entities/course_entity.dart';
import 'package:rental_car/features/course/domain/entities/module_entity.dart';
import 'package:rental_car/features/course/presentation/providers/course_providers.dart';

class CourseDetailState {
  const CourseDetailState({
    this.course,
    this.modules = const [],
    this.isLoading = false,
    this.isEnrolling = false,
    this.errorMessage,
  });

  final CourseEntity? course;
  final List<ModuleEntity> modules;
  final bool isLoading;
  final bool isEnrolling;
  final String? errorMessage;

  CourseDetailState copyWith({
    CourseEntity? course,
    List<ModuleEntity>? modules,
    bool? isLoading,
    bool? isEnrolling,
    String? errorMessage,
    bool clearError = false,
  }) {
    return CourseDetailState(
      course: course ?? this.course,
      modules: modules ?? this.modules,
      isLoading: isLoading ?? this.isLoading,
      isEnrolling: isEnrolling ?? this.isEnrolling,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}

class CourseDetailController extends Notifier<CourseDetailState> {
  @override
  CourseDetailState build() {
    return const CourseDetailState();
  }

  Future<void> loadCourseDetail(String courseId) async {
    if (state.course?.id != courseId) {
      state = const CourseDetailState(isLoading: true);
    } else {
      state = state.copyWith(isLoading: true, clearError: true);
    }

    final courseResult = await ref
        .read(getCourseDetailUseCaseProvider)
        .call(courseId);
    final modulesResult = await ref
        .read(getCourseModulesUseCaseProvider)
        .call(courseId);

    CourseEntity? course;
    List<ModuleEntity> modules = [];
    String? error;

    courseResult.when(
      ok: (data) => course = data,
      err: (failure) => error = failure.message,
    );

    modulesResult.when(
      ok: (data) {
        final locallyCompletedLessonIds = {
          for (final m in state.modules)
            for (final l in m.lessons)
              if (l.isCompleted) l.id,
        };

        if (locallyCompletedLessonIds.isNotEmpty) {
          modules = data.map((mod) {
            final lessons = mod.lessons.map((l) {
              if (locallyCompletedLessonIds.contains(l.id)) {
                return l.copyWith(isCompleted: true);
              }
              return l;
            }).toList();
            return mod.copyWith(lessons: lessons);
          }).toList();
        } else {
          modules = data;
        }
      },
      err: (failure) => error ??= failure.message,
    );

    state = state.copyWith(
      course: course,
      modules: modules,
      isLoading: false,
      errorMessage: error,
    );
  }

  void markLessonCompleted(String lessonId, {required bool isCompleted}) {
    final updatedModules = state.modules.map((module) {
      final updatedLessons = module.lessons.map((lesson) {
        if (lesson.id == lessonId) {
          return lesson.copyWith(isCompleted: isCompleted);
        }
        return lesson;
      }).toList();
      return module.copyWith(lessons: updatedLessons);
    }).toList();

    state = state.copyWith(modules: updatedModules);
  }

  Future<bool> enroll() async {
    final currentCourse = state.course;
    if (currentCourse == null) return false;

    state = state.copyWith(isEnrolling: true);
    final result = await ref
        .read(enrollCourseUseCaseProvider)
        .call(currentCourse.id);

    return result.when(
      ok: (enrollment) {
        state = state.copyWith(
          isEnrolling: false,
          course: currentCourse.copyWith(
            isEnrolled: true,
            progress: enrollment.progressRatio,
          ),
        );
        // Refresh danh sách khóa học bên ngoài
        ref.read(coursesControllerProvider.notifier).refresh();
        return true;
      },
      err: (failure) {
        state = state.copyWith(
          isEnrolling: false,
          errorMessage: failure.message,
        );
        return false;
      },
    );
  }

  void reset() {
    state = const CourseDetailState();
  }
}
