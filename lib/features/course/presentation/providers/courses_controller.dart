import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_car/features/course/domain/entities/course_entity.dart';
import 'package:rental_car/features/course/domain/entities/enrollment_entity.dart';
import 'package:rental_car/features/course/presentation/providers/course_providers.dart';

class CoursesState {
  const CoursesState({
    this.activeTab = 0, // 0: Khóa học của tôi, 1: Khám phá tất cả
    this.myEnrollments = const [],
    this.allCourses = const [],
    this.popularCourses = const [],
    this.categories = const {},
    this.difficulties = const {},
    this.selectedCategory, // null nghĩa là 'Tất cả'
    this.selectedDifficulty, // null nghĩa là 'Tất cả'
    this.searchQuery = '',
    this.isLoading = false,
    this.isRefreshing = false,
    this.errorMessage,
  });

  final int activeTab;
  final List<EnrollmentEntity> myEnrollments;
  final List<CourseEntity> allCourses;
  final List<CourseEntity> popularCourses;
  final Map<String, String> categories;
  final Map<String, String> difficulties;
  final String? selectedCategory;
  final String? selectedDifficulty;
  final String searchQuery;
  final bool isLoading;
  final bool isRefreshing;
  final String? errorMessage;

  bool get hasActiveFilter =>
      selectedCategory != null || selectedDifficulty != null;

  CoursesState copyWith({
    int? activeTab,
    List<EnrollmentEntity>? myEnrollments,
    List<CourseEntity>? allCourses,
    List<CourseEntity>? popularCourses,
    Map<String, String>? categories,
    Map<String, String>? difficulties,
    String? selectedCategory,
    bool clearCategory = false,
    String? selectedDifficulty,
    bool clearDifficulty = false,
    String? searchQuery,
    bool? isLoading,
    bool? isRefreshing,
    String? errorMessage,
    bool clearError = false,
  }) {
    return CoursesState(
      activeTab: activeTab ?? this.activeTab,
      myEnrollments: myEnrollments ?? this.myEnrollments,
      allCourses: allCourses ?? this.allCourses,
      popularCourses: popularCourses ?? this.popularCourses,
      categories: categories ?? this.categories,
      difficulties: difficulties ?? this.difficulties,
      selectedCategory: clearCategory
          ? null
          : (selectedCategory ?? this.selectedCategory),
      selectedDifficulty: clearDifficulty
          ? null
          : (selectedDifficulty ?? this.selectedDifficulty),
      searchQuery: searchQuery ?? this.searchQuery,
      isLoading: isLoading ?? this.isLoading,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}

class CoursesController extends Notifier<CoursesState> {
  @override
  CoursesState build() {
    // Tự động load dữ liệu khi khởi tạo
    Future.microtask(() => loadInitialData());
    return const CoursesState(isLoading: true);
  }

  Future<void> loadInitialData() async {
    state = state.copyWith(isLoading: true, clearError: true);

    final enrollmentsResult = await ref
        .read(getMyEnrollmentsUseCaseProvider)
        .call();
    final filtersResult = await ref
        .read(getCourseFilterOptionsUseCaseProvider)
        .call();
    final coursesResult = await ref
        .read(getCoursesUseCaseProvider)
        .call(
          category: state.selectedCategory,
          difficulty: state.selectedDifficulty,
          search: state.searchQuery.isEmpty ? null : state.searchQuery,
        );

    final popularResult =
        await ref.read(getPopularCoursesUseCaseProvider).call();

    List<EnrollmentEntity> enrollments = [];
    Map<String, String> categories = {};
    Map<String, String> difficulties = {};
    List<CourseEntity> courses = [];
    List<CourseEntity> popularCourses = [];
    String? error;

    enrollmentsResult.when(
      ok: (data) => enrollments = data,
      err: (failure) => error = failure.message,
    );

    filtersResult.when(
      ok: (data) {
        categories = data.categories;
        difficulties = data.difficulties;
      },
      err: (_) {},
    );

    coursesResult.when(
      ok: (data) => courses = data,
      err: (failure) => error ??= failure.message,
    );

    popularResult.when(
      ok: (data) => popularCourses = data,
      err: (_) {},
    );

    state = state.copyWith(
      myEnrollments: enrollments,
      allCourses: courses,
      popularCourses: popularCourses.isNotEmpty
          ? popularCourses
          : courses.take(5).toList(),
      categories: categories,
      difficulties: difficulties,
      isLoading: false,
      errorMessage: error,
    );
  }

  void switchTab(int tabIndex) {
    if (state.activeTab != tabIndex) {
      state = state.copyWith(activeTab: tabIndex);
    }
  }

  Future<void> setCategory(String? category) async {
    await applyFilters(
      category: category,
      difficulty: state.selectedDifficulty,
    );
  }

  Future<void> applyFilters({String? category, String? difficulty}) async {
    state = state.copyWith(
      selectedCategory: category,
      clearCategory: category == null,
      selectedDifficulty: difficulty,
      clearDifficulty: difficulty == null,
      isLoading: true,
    );

    final result = await ref
        .read(getCoursesUseCaseProvider)
        .call(
          category: category,
          difficulty: difficulty,
          search: state.searchQuery.isEmpty ? null : state.searchQuery,
        );

    result.when(
      ok: (data) => state = state.copyWith(allCourses: data, isLoading: false),
      err: (failure) => state = state.copyWith(
        errorMessage: failure.message,
        isLoading: false,
      ),
    );
  }

  Future<void> resetFilters() async {
    await applyFilters();
  }

  Future<void> search(String query) async {
    final trimmed = query.trim();
    state = state.copyWith(searchQuery: trimmed, isLoading: true);
    final result = await ref
        .read(getCoursesUseCaseProvider)
        .call(
          category: state.selectedCategory,
          difficulty: state.selectedDifficulty,
          search: trimmed.isEmpty ? null : trimmed,
        );

    result.when(
      ok: (data) => state = state.copyWith(allCourses: data, isLoading: false),
      err: (failure) => state = state.copyWith(
        errorMessage: failure.message,
        isLoading: false,
      ),
    );
  }

  Future<void> refresh() async {
    state = state.copyWith(isRefreshing: true);
    await loadInitialData();
    state = state.copyWith(isRefreshing: false);
  }
}
