import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/features/course/domain/entities/enrollment_entity.dart';

/// Thẻ môn học đang học chuẩn phong cách ApSkil
class OngoingCourseCard extends StatelessWidget {
  const OngoingCourseCard({
    super.key,
    required this.enrollment,
    required this.onTap,
  });

  final EnrollmentEntity enrollment;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final code = enrollment.courseCode?.isNotEmpty == true
        ? enrollment.courseCode!
        : 'FPT';
    final completedCount =
        ((enrollment.totalLessons * enrollment.progressPercent) / 100).round();
    final progress = enrollment.progressRatio;
    final imageUrl = enrollment.courseThumbnailUrl;
    final isCompleted = enrollment.isCompleted;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 290,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: AppColors.textPrimary.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Top Row: Thumbnail + Code & Title
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: SizedBox(
                    width: 52,
                    height: 52,
                    child: (imageUrl != null && imageUrl.isNotEmpty)
                        ? Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (_, _, _) =>
                                _buildFallbackThumbnail(code),
                          )
                        : _buildFallbackThumbnail(code),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 1.5,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primaryContainer,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: AppColors.primaryBorder,
                              ),
                            ),
                            child: Text(
                              code,
                              style: const TextStyle(
                                fontSize: 9.5,
                                fontWeight: FontWeight.w800,
                                color: AppColors.primaryForeground,
                                letterSpacing: 0.3,
                              ),
                            ),
                          ),
                          if (isCompleted) ...[
                            const SizedBox(width: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 5,
                                vertical: 1.5,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.successContainer,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.check_circle_rounded,
                                    size: 10,
                                    color: AppColors.successVibrant,
                                  ),
                                  SizedBox(width: 2),
                                  Text(
                                    'Hoàn thành',
                                    style: TextStyle(
                                      fontSize: 9,
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.successForeground,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 3),
                      Text(
                        enrollment.courseTitle.isNotEmpty
                            ? enrollment.courseTitle
                            : 'Khóa học FPT',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                          height: 1.25,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Middle: ApSkil Signature Progress Bar with Endpoint Indicator
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LayoutBuilder(
                  builder: (context, constraints) {
                    final barWidth = constraints.maxWidth;
                    final activeWidth = (barWidth * progress).clamp(
                      0.0,
                      barWidth,
                    );

                    return Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.centerLeft,
                      children: [
                        // Background track
                        Container(
                          height: 6,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColors.border,
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        // Active track
                        Container(
                          height: 6,
                          width: activeWidth,
                          decoration: BoxDecoration(
                            color: isCompleted
                                ? AppColors.success
                                : AppColors.primary,
                            gradient: !isCompleted
                                ? const LinearGradient(
                                    colors: [
                                      AppColors.primary,
                                      AppColors.accent,
                                    ],
                                  )
                                : null,
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        // Endpoint circular dot (ApSkil signature style)
                        if (activeWidth > 4)
                          Positioned(
                            left: (activeWidth - 4).clamp(0.0, barWidth - 8),
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: isCompleted
                                    ? AppColors.successDark
                                    : AppColors.accent,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 1.5,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: (isCompleted
                                            ? AppColors.success
                                            : AppColors.primary)
                                        .withValues(alpha: 0.35),
                                    blurRadius: 3,
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 5),

                // Metrics text row (ApSkil style: "4 bài đã học ... 8 bài" or "Đã hoàn thành")
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        isCompleted
                            ? 'Đã hoàn thành'
                            : '$completedCount bài đã học',
                        style: TextStyle(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w800,
                          color: isCompleted
                              ? AppColors.successDarkText
                              : AppColors.primaryForeground,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '${enrollment.totalLessons} bài học',
                      style: const TextStyle(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // Bottom row: Difficulty & Instructor
            Text(
              '${enrollment.courseDifficultyName ?? enrollment.courseDifficulty} • ${enrollment.instructorName ?? "Ban Đào Tạo FPT"}',
              style: const TextStyle(
                fontSize: 10,
                color: AppColors.textMuted,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFallbackThumbnail(String code) {
    return Container(
      color: AppColors.primaryDark,
      child: Center(
        child: Text(
          code,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.4,
          ),
        ),
      ),
    );
  }
}
