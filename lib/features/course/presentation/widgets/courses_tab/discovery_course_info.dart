import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/features/course/domain/entities/course_entity.dart';

/// Phần hiển thị thông tin khóa học: Mã môn, tiêu đề, giảng viên, số chương/bài và nút hành động
class DiscoveryCourseInfo extends StatelessWidget {
  const DiscoveryCourseInfo({
    super.key,
    required this.course,
    required this.isEnrolled,
  });

  final CourseEntity course;
  final bool isEnrolled;

  @override
  Widget build(BuildContext context) {
    final code = course.code.isNotEmpty ? course.code : 'FPT';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Row 1: Code badge & Status / Category
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.primaryContainer,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: AppColors.primaryBorder),
              ),
              child: Text(
                code,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  color: AppColors.primaryForeground,
                  letterSpacing: 0.3,
                ),
              ),
            ),
            const SizedBox(width: 6),
            if (isEnrolled)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 6,
                  vertical: 1.5,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primaryContainer,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: AppColors.primaryBorder),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.check_rounded,
                      size: 11,
                      color: AppColors.primaryForeground,
                    ),
                    SizedBox(width: 2.5),
                    Text(
                      'Đã đăng ký',
                      style: TextStyle(
                        fontSize: 9.5,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryForeground,
                      ),
                    ),
                  ],
                ),
              )
            else if (course.categoryName != null)
              Expanded(
                child: Text(
                  course.categoryName!,
                  style: const TextStyle(
                    fontSize: 10.5,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
          ],
        ),

        const SizedBox(height: 5),

        // Row 2: Title
        Text(
          course.title,
          style: const TextStyle(
            fontSize: 13.5,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
            height: 1.25,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),

        const SizedBox(height: 4),

        // Row 3: Instructor
        Row(
          children: [
            const Icon(
              Icons.person_outline_rounded,
              size: 12,
              color: AppColors.textSecondary,
            ),
            const SizedBox(width: 3),
            Expanded(
              child: Text(
                course.creatorName ?? 'Ban Đào Tạo FPT',
                style: const TextStyle(
                  fontSize: 10.5,
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),

        const SizedBox(height: 8),

        // Row 4: Module & Lesson count & Action Button
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Lesson stats
            Row(
              children: [
                const Icon(
                  Icons.auto_stories_outlined,
                  size: 13,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(width: 4),
                Text(
                  course.totalModules > 0
                      ? '${course.totalModules} chương • ${course.totalLessons} bài'
                      : '${course.totalLessons} bài học',
                  style: const TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),

            // Action button
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5.5),
              decoration: BoxDecoration(
                color: isEnrolled
                    ? AppColors.primary
                    : AppColors.surfaceSubtle,
                borderRadius: BorderRadius.circular(8),
                boxShadow: isEnrolled
                    ? [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.25),
                          blurRadius: 4,
                          offset: const Offset(0, 1.5),
                        ),
                      ]
                    : null,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    isEnrolled ? 'Vào học' : 'Chi tiết',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: isEnrolled
                          ? Colors.white
                          : AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: 3),
                  Icon(
                    Icons.arrow_forward_rounded,
                    size: 12,
                    color: isEnrolled
                        ? Colors.white
                        : AppColors.primary,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
