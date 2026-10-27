import 'package:flutter/material.dart';
import 'package:rental_car/features/course/domain/entities/course_entity.dart';
import 'package:rental_car/features/course/presentation/widgets/courses_tab/discovery_course_info.dart';
import 'package:rental_car/features/course/presentation/widgets/courses_tab/discovery_course_thumbnail.dart';

/// Thẻ hiển thị khóa học trong danh mục khám phá (Discovery)
class DiscoveryCourseCard extends StatelessWidget {
  const DiscoveryCourseCard({
    super.key,
    required this.course,
    required this.onTap,
    this.isEnrolled = false,
  });

  final CourseEntity course;
  final VoidCallback onTap;
  final bool isEnrolled;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFFF1F5F9)),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF0F172A).withValues(alpha: 0.04),
              blurRadius: 12,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left: Course Image Thumbnail (105x105)
            DiscoveryCourseThumbnail(course: course),
            const SizedBox(width: 12),

            // Right: Course Information
            Expanded(
              child: DiscoveryCourseInfo(
                course: course,
                isEnrolled: isEnrolled,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
