import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_car/app/router/app_routes.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/features/course/domain/entities/enrollment_entity.dart';

/// Thẻ khóa học đang học trên trang chủ với thanh tiến độ slider pin ApSkil
class HomeOngoingCourseCard extends StatelessWidget {
  const HomeOngoingCourseCard({super.key, required this.enrollment});

  final EnrollmentEntity enrollment;

  @override
  Widget build(BuildContext context) {
    final title = enrollment.courseTitle.isNotEmpty
        ? enrollment.courseTitle
        : 'Khóa học FPT';
    final code = enrollment.courseCode?.isNotEmpty == true
        ? enrollment.courseCode!
        : 'FPT';
    final imageUrl = enrollment.courseThumbnailUrl;
    final progress = enrollment.progressRatio.clamp(0.0, 1.0);
    final totalLessons = enrollment.totalLessons > 0
        ? enrollment.totalLessons
        : 8;
    final completedCount = (progress * totalLessons).round();
    final metaText = [
      if (enrollment.courseDifficultyName != null &&
          enrollment.courseDifficultyName!.isNotEmpty)
        enrollment.courseDifficultyName!
      else if (enrollment.courseDifficulty.isNotEmpty)
        enrollment.courseDifficulty,
      if (enrollment.instructorName != null &&
          enrollment.instructorName!.isNotEmpty)
        enrollment.instructorName!
      else
        'Ban Đào Tạo FPT',
    ].join(' • ');

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => context.push(
          AppRoute.courseDetail.path.replaceFirst(':id', enrollment.courseId),
        ),
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: 300,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.border),
            boxShadow: [
              BoxShadow(
                color: AppColors.textPrimary.withValues(alpha: 0.03),
                blurRadius: 12,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Hàng 1: Thumbnail ảnh khóa học + Mã & Tên môn học
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: SizedBox(
                      width: 48,
                      height: 48,
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
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
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
                        const SizedBox(height: 3),
                        Text(
                          title,
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

              // Hàng 2: Thanh tiến độ có Slider Pin chuẩn ApSkil
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final trackWidth = constraints.maxWidth;
                      final thumbOffset = (trackWidth - 12) * progress;

                      return Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          // Nền ray trượt
                          Container(
                            height: 6,
                            decoration: BoxDecoration(
                              color: AppColors.border,
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                          // Đoạn ray đã hoàn thành
                          Container(
                            height: 6,
                            width: trackWidth * progress,
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                          // Nút tròn định vị tiến độ (Thumb pin)
                          Positioned(
                            left: thumbOffset,
                            child: Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primary.withValues(
                                      alpha: 0.35,
                                    ),
                                    blurRadius: 4,
                                    offset: const Offset(0, 1),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 7),

                  // Số bài học 2 đầu
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '$completedCount bài học',
                        style: const TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        '$totalLessons bài học',
                        style: const TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              // Hàng 3: Dòng meta tóm tắt
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Text(
                  metaText,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textMuted,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFallbackThumbnail(String code) {
    return Container(
      color: AppColors.primaryDark,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.school_rounded, size: 20, color: Colors.white),
            const SizedBox(height: 2),
            Text(
              code.length > 5 ? code.substring(0, 5) : code,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 8.5,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.3,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
