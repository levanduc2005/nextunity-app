import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/features/course/domain/entities/enrollment_entity.dart';
import 'package:rental_car/features/course/presentation/widgets/courses_tab/ongoing_course_card.dart';
import 'package:rental_car/features/course/presentation/widgets/courses_tab/ongoing_empty_state_card.dart';
import 'package:rental_car/features/course/presentation/widgets/courses_tab/ongoing_initial_banner.dart';

class OngoingCoursesSection extends StatefulWidget {
  const OngoingCoursesSection({
    super.key,
    required this.enrollments,
    required this.onTapCourse,
  });

  final List<EnrollmentEntity> enrollments;
  final ValueChanged<EnrollmentEntity> onTapCourse;

  @override
  State<OngoingCoursesSection> createState() => _OngoingCoursesSectionState();
}

class _OngoingCoursesSectionState extends State<OngoingCoursesSection> {
  bool _showCompleted = false;

  @override
  Widget build(BuildContext context) {
    if (widget.enrollments.isEmpty) {
      return const OngoingInitialBanner();
    }

    final ongoingList = widget.enrollments
        .where((e) => !e.isCompleted)
        .toList();
    final completedList = widget.enrollments
        .where((e) => e.isCompleted)
        .toList();
    final activeList = _showCompleted ? completedList : ongoingList;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header Row
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
            Expanded(
              child: Text(
                _showCompleted ? 'Môn học đã hoàn thành' : 'Môn học đang học',
                style: const TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF0F172A),
                  letterSpacing: -0.2,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
            // Segmented Pills [Đang học] | [Đã xong]
            Container(
              padding: const EdgeInsets.all(2.5),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildPill(
                    title: 'Đang học (${ongoingList.length})',
                    isSelected: !_showCompleted,
                    onTap: () => setState(() => _showCompleted = false),
                  ),
                  _buildPill(
                    title: 'Đã xong (${completedList.length})',
                    isSelected: _showCompleted,
                    onTap: () => setState(() => _showCompleted = true),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),

        if (activeList.isEmpty)
          OngoingEmptyStateCard(showCompleted: _showCompleted)
        else
          SizedBox(
            height: 154,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: activeList.length,
              separatorBuilder: (_, _) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final enr = activeList[index];
                return OngoingCourseCard(
                  enrollment: enr,
                  onTap: () => widget.onTapCourse(enr),
                );
              },
            ),
          ),
        const SizedBox(height: 18),
      ],
    );
  }

  Widget _buildPill({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3.5),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ]
              : null,
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 10.5,
            fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
            color: isSelected ? AppColors.primary : const Color(0xFF64748B),
          ),
        ),
      ),
    );
  }
}
