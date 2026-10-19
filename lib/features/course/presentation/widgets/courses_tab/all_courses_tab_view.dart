import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_car/app/router/app_routes.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/features/course/domain/entities/course_entity.dart';
import 'package:rental_car/features/course/domain/entities/enrollment_entity.dart';
import 'package:rental_car/features/course/presentation/widgets/courses_tab/courses_empty_view.dart';
import 'package:rental_car/features/course/presentation/widgets/courses_tab/discovery_course_card.dart';

class AllCoursesTabView extends StatelessWidget {
  const AllCoursesTabView({
    super.key,
    required this.courses,
    required this.enrollments,
  });

  final List<CourseEntity> courses;
  final List<EnrollmentEntity> enrollments;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
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
                  'Tất cả chương trình môn học',
                  style: TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF0F172A),
                  ),
                ),
              ],
            ),
            Text(
              '${courses.length} môn học',
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: Color(0xFF64748B),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (courses.isEmpty)
          const CoursesEmptySearchView()
        else
          ...courses.map((c) {
            final isEnrolled = enrollments.any((e) => e.courseId == c.id);
            return DiscoveryCourseCard(
              course: c,
              isEnrolled: isEnrolled,
              onTap: () => context.push(
                AppRoute.courseDetail.path.replaceFirst(':id', c.id),
              ),
            );
          }),
      ],
    );
  }
}
