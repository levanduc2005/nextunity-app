import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_car/core/providers/core_providers.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/features/course/presentation/providers/course_providers.dart';
import 'package:rental_car/features/course/presentation/widgets/courses_tab/all_courses_tab_view.dart';
import 'package:rental_car/features/course/presentation/widgets/courses_tab/course_filter_modal.dart';
import 'package:rental_car/features/course/presentation/widgets/courses_tab/courses_active_filters_bar.dart';
import 'package:rental_car/features/course/presentation/widgets/courses_tab/courses_tab_selector.dart';
import 'package:rental_car/features/course/presentation/widgets/courses_tab/courses_top_header.dart';
import 'package:rental_car/features/course/presentation/widgets/courses_tab/my_courses_tab_view.dart';

class CoursesPage extends ConsumerWidget {
  const CoursesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(coursesControllerProvider);
    final controller = ref.read(coursesControllerProvider.notifier);
    final user = ref.watch(currentUserProvider);

    final streak = user?.streak ?? 15;
    final university = user?.university ?? 'FPT University';

    return Scaffold(
      backgroundColor: AppColors.pastelBackground,
      body: SafeArea(
        child: Column(
          children: [
            // Sticky Top Header with Search & Filter
            CoursesTopHeader(
              university: university,
              streak: streak,
              searchQuery: state.searchQuery,
              hasActiveFilter: state.hasActiveFilter,
              onSearch: controller.search,
              onOpenFilter: () {
                CourseFilterModal.show(
                  context: context,
                  categories: state.categories,
                  difficulties: state.difficulties,
                  selectedCategory: state.selectedCategory,
                  selectedDifficulty: state.selectedDifficulty,
                  onApply: (category, difficulty) {
                    controller.applyFilters(
                      category: category,
                      difficulty: difficulty,
                    );
                  },
                );
              },
            ),

            // Scrollable Content
            Expanded(
              child: RefreshIndicator(
                onRefresh: controller.refresh,
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(16, 14, 16, 24),
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    // Segmented Pill Tab Switcher
                    CoursesTabSelector(
                      activeTab: state.activeTab,
                      enrolledCount: state.myEnrollments.length,
                      onTabChanged: controller.switchTab,
                    ),

                    // Active Filters Summary (if any filter is selected)
                    if (state.hasActiveFilter) ...[
                      const SizedBox(height: 10),
                      CoursesActiveFiltersBar(
                        categories: state.categories,
                        difficulties: state.difficulties,
                        selectedCategory: state.selectedCategory,
                        selectedDifficulty: state.selectedDifficulty,
                        onClearCategory: () => controller.applyFilters(
                          difficulty: state.selectedDifficulty,
                        ),
                        onClearDifficulty: () => controller.applyFilters(
                          category: state.selectedCategory,
                        ),
                        onResetAll: controller.resetFilters,
                      ),
                      const SizedBox(height: 10),
                    ] else ...[
                      const SizedBox(height: 14),
                    ],

                    if (state.isLoading)
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.all(32),
                          child: CircularProgressIndicator(),
                        ),
                      )
                    else if (state.activeTab == 0)
                      MyCoursesTabView(
                        enrollments: state.myEnrollments,
                        onExplore: () => controller.switchTab(1),
                      )
                    else
                      AllCoursesTabView(
                        courses: state.allCourses,
                        enrollments: state.myEnrollments,
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
