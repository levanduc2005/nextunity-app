import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_car/app/router/app_routes.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/features/course/domain/entities/enrollment_entity.dart';
import 'package:rental_car/features/home/presentation/widgets/ongoing_courses/home_ongoing_course_card.dart';
import 'package:rental_car/features/home/presentation/widgets/ongoing_courses/home_ongoing_empty_card.dart';

/// Danh sách khóa học đang diễn ra chuẩn phong cách ApSkil
class HomeOngoingCourses extends StatelessWidget {
  const HomeOngoingCourses({
    super.key,
    required this.enrollments,
    this.isLoading = false,
  });

  final List<EnrollmentEntity> enrollments;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Tiêu đề phần "Khóa học đang học"
        const Text(
          'Khóa học đang học',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 12),

        if (isLoading && enrollments.isEmpty)
          const SizedBox(
            height: 160,
            child: Center(
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                color: AppColors.primary,
              ),
            ),
          )
        else if (enrollments.isEmpty)
          HomeOngoingEmptyCard(
            onExplore: () => context.go(AppRoute.courses.path),
          )
        else
          SizedBox(
            height: 168,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              clipBehavior: Clip.none,
              itemCount: enrollments.length,
              separatorBuilder: (context, index) => const SizedBox(width: 14),
              itemBuilder: (context, index) {
                final enrollment = enrollments[index];
                return HomeOngoingCourseCard(enrollment: enrollment);
              },
            ),
          ),
      ],
    );
  }
}
