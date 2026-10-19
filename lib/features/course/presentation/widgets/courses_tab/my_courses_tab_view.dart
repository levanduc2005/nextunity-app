import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_car/app/router/app_routes.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/features/course/domain/entities/enrollment_entity.dart';
import 'package:rental_car/features/course/presentation/widgets/courses_tab/courses_empty_view.dart';
import 'package:rental_car/features/course/presentation/widgets/courses_tab/enrolled_course_card.dart';

class MyCoursesTabView extends StatefulWidget {
  const MyCoursesTabView({
    super.key,
    required this.enrollments,
    required this.onExplore,
  });

  final List<EnrollmentEntity> enrollments;
  final VoidCallback onExplore;

  @override
  State<MyCoursesTabView> createState() => _MyCoursesTabViewState();
}

class _MyCoursesTabViewState extends State<MyCoursesTabView> {
  // 0: Đang học, 1: Đã hoàn thành
  int _selectedSubTab = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.enrollments.isEmpty) {
      return CoursesEmptyEnrolledView(onExplore: widget.onExplore);
    }

    final inProgressList = widget.enrollments
        .where((e) => !e.isCompleted)
        .toList();
    final completedList = widget.enrollments
        .where((e) => e.isCompleted)
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // 2-Option Segmented Switcher (Đang học & Đã hoàn thành)
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: const Color(0xFFE2E8F0).withValues(alpha: 0.65),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              _buildSegmentItem(
                label: 'Đang học (${inProgressList.length})',
                index: 0,
                activeColor: AppColors.primary,
              ),
              _buildSegmentItem(
                label: 'Đã hoàn thành (${completedList.length})',
                index: 1,
                activeColor: const Color(0xFF059669),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // Section Title & Counter
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 4,
                  height: 14,
                  decoration: BoxDecoration(
                    color: _selectedSubTab == 0
                        ? AppColors.primary
                        : const Color(0xFF059669),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  _selectedSubTab == 0
                      ? 'Môn học đang học'
                      : 'Môn học đã hoàn thành',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF0F172A),
                  ),
                ),
              ],
            ),
            Text(
              _selectedSubTab == 0
                  ? '${inProgressList.length} môn'
                  : '${completedList.length} môn',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: _selectedSubTab == 0
                    ? AppColors.primary
                    : const Color(0xFF059669),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Tab Content
        if (_selectedSubTab == 0) ...[
          if (inProgressList.isEmpty)
            _buildEmptySubCategory(
              icon: Icons.check_circle_outline_rounded,
              title: 'Tuyệt vời!',
              subtitle: 'Bạn không có môn học nào đang dang dở.',
            )
          else
            ...inProgressList.map((enr) => _buildCard(context, enr)),
        ] else ...[
          if (completedList.isEmpty)
            _buildEmptySubCategory(
              icon: Icons.school_outlined,
              title: 'Chưa có môn học hoàn thành',
              subtitle:
                  'Hãy hoàn thành các bài học để nhận chứng chỉ tốt nghiệp!',
            )
          else
            ...completedList.map((enr) => _buildCard(context, enr)),
        ],
      ],
    );
  }

  Widget _buildSegmentItem({
    required String label,
    required int index,
    required Color activeColor,
  }) {
    final isSelected = _selectedSubTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedSubTab = index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? activeColor : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: activeColor.withValues(alpha: 0.25),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w800,
              color: isSelected ? Colors.white : const Color(0xFF64748B),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, EnrollmentEntity enr) {
    return EnrolledCourseCard(
      enrollment: enr,
      onTapDetail: () => context.push(
        AppRoute.courseDetail.path.replaceFirst(':id', enr.courseId),
      ),
      onTapContinue: () => context.push(
        AppRoute.courseDetail.path.replaceFirst(':id', enr.courseId),
      ),
    );
  }

  Widget _buildEmptySubCategory({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        children: [
          Icon(icon, size: 40, color: const Color(0xFF94A3B8)),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.w800,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 11.5,
              color: Color(0xFF64748B),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
