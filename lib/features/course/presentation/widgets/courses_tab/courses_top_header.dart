import 'package:flutter/material.dart';
import 'package:rental_car/core/widgets/widgets.dart';
import 'package:rental_car/features/course/presentation/widgets/courses_tab/course_search_bar.dart';

class CoursesTopHeader extends StatelessWidget {
  const CoursesTopHeader({
    super.key,
    required this.university,
    required this.streak,
    required this.searchQuery,
    required this.onSearch,
    required this.onOpenFilter,
    this.hasActiveFilter = false,
  });

  final String university;
  final int streak;
  final String searchQuery;
  final ValueChanged<String> onSearch;
  final VoidCallback onOpenFilter;
  final bool hasActiveFilter;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 6),
      child: Column(
        children: [
          MainTabHeader(
            subtitle: 'Chương trình $university',
            streak: streak,
            padding: EdgeInsets.zero,
          ),
          const SizedBox(height: 10),
          CourseSearchBar(
            initialValue: searchQuery,
            onSearch: onSearch,
            onOpenFilter: onOpenFilter,
            hasActiveFilter: hasActiveFilter,
          ),
        ],
      ),
    );
  }
}
