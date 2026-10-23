import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_car/app/router/app_routes.dart';
import 'package:rental_car/core/providers/core_providers.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/core/widgets/main_tab_header.dart';
import 'package:rental_car/features/course/presentation/providers/course_providers.dart';
import 'package:rental_car/features/course/presentation/widgets/courses_tab/course_filter_modal.dart';
import 'package:rental_car/features/course/presentation/widgets/courses_tab/course_search_bar.dart';
import 'package:rental_car/features/course/presentation/widgets/courses_tab/courses_active_filters_bar.dart';
import 'package:rental_car/features/course/presentation/widgets/courses_tab/courses_empty_view.dart';
import 'package:rental_car/features/course/presentation/widgets/courses_tab/discovery_course_card.dart';
import 'package:rental_car/features/course/presentation/widgets/courses_tab/ongoing_courses_section.dart';

class CoursesPage extends ConsumerWidget {
  const CoursesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(coursesControllerProvider);
    final controller = ref.read(coursesControllerProvider.notifier);
    final user = ref.watch(currentUserProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Sticky Top Header with Search & Filter
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 6),
              child: Column(
                children: [
                  MainTabHeader(
                    displayName: user?.displayName,
                    avatarUrl: user?.avatarUrl,
                    isPlus: user?.isPlus == true,
                    padding: EdgeInsets.zero,
                  ),
                  const SizedBox(height: 12),
                  CourseSearchBar(
                    initialValue: state.searchQuery,
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
                    hasActiveFilter: state.hasActiveFilter,
                  ),
                ],
              ),
            ),

            // Continuous Scrollable Content (ApSkil Behance Style)
            Expanded(
              child: RefreshIndicator(
                onRefresh: controller.refresh,
                child: ListView(
                  padding: const EdgeInsets.fromLTRB(16, 6, 16, 24),
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    // Active Filters Summary (if any filter is selected)
                    if (state.hasActiveFilter) ...[
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
                      const SizedBox(height: 12),
                    ],

                    // Section 1: Ongoing Courses Carousel (Kelas berlangsung)
                    OngoingCoursesSection(
                      enrollments: state.myEnrollments,
                      onTapCourse: (enr) {
                        context.push(
                          AppRoute.courseDetail.path.replaceFirst(
                            ':id',
                            enr.courseId,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),

                    // Section 2 Header: All Courses Title & Count
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 4,
                              height: 14,
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Text(
                              'Danh sách môn học',
                              style: TextStyle(
                                fontSize: 13.5,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFF0F172A),
                                letterSpacing: -0.2,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '${state.allCourses.length} môn học',
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Section 3 Body: Discovery List
                    if (state.isLoading)
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.all(32),
                          child: CircularProgressIndicator(),
                        ),
                      )
                    else if (state.allCourses.isEmpty)
                      const CoursesEmptySearchView()
                    else
                      ...state.allCourses.map((c) {
                        final isEnrolled = state.myEnrollments.any(
                          (e) => e.courseId == c.id,
                        );
                        return DiscoveryCourseCard(
                          course: c,
                          isEnrolled: isEnrolled,
                          onTap: () => context.push(
                            AppRoute.courseDetail.path.replaceFirst(
                              ':id',
                              c.id,
                            ),
                          ),
                        );
                      }),
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
