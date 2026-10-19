import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/features/course/domain/entities/enrollment_entity.dart';

class EnrolledCourseCard extends StatelessWidget {
  const EnrolledCourseCard({
    super.key,
    required this.enrollment,
    required this.onTapDetail,
    required this.onTapContinue,
  });

  final EnrollmentEntity enrollment;
  final VoidCallback onTapDetail;
  final VoidCallback onTapContinue;

  @override
  Widget build(BuildContext context) {
    final code = enrollment.courseCode?.isNotEmpty == true
        ? enrollment.courseCode!
        : 'FPT';

    final progress = enrollment.progressPercent;
    final isHighProgress = progress >= 60;
    final progressColor = isHighProgress
        ? const Color(0xFF10B981)
        : const Color(0xFFF59E0B);
    final progressBg = isHighProgress
        ? const Color(0xFFECFDF5)
        : const Color(0xFFFFFBEB);

    final imageUrl = enrollment.courseThumbnailUrl;

    return InkWell(
      onTap: onTapDetail,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: const Color(0xFFF1F5F9)),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF1E3A8A).withValues(alpha: 0.04),
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
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: SizedBox(
                width: 105,
                height: 105,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    if (imageUrl != null && imageUrl.isNotEmpty)
                      Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) =>
                            _buildFallbackThumbnail(code),
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            color: const Color(0xFFF1F5F9),
                            child: const Center(
                              child: SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    else
                      _buildFallbackThumbnail(code),

                    // Badge: % hoàn thành góc dưới
                    Positioned(
                      left: 6,
                      bottom: 6,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: progressBg,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: progressColor.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Text(
                          '$progress%',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            color: progressColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(width: 12),

            // Right: Course Information
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Row 1: Code badge & Difficulty
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFF6FF),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: const Color(0xFFBFDBFE)),
                        ),
                        child: Text(
                          code,
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF1D4ED8),
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        enrollment.courseDifficultyName ??
                            enrollment.courseDifficulty,
                        style: const TextStyle(
                          fontSize: 10.5,
                          color: Color(0xFF64748B),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 5),

                  // Row 2: Title
                  Text(
                    enrollment.courseTitle,
                    style: const TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF0F172A),
                      height: 1.25,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 4),

                  // Row 3: Instructor & Total lessons
                  Row(
                    children: [
                      const Icon(
                        Icons.person_outline_rounded,
                        size: 12,
                        color: Color(0xFF64748B),
                      ),
                      const SizedBox(width: 3),
                      Expanded(
                        child: Text(
                          '${enrollment.instructorName ?? "Ban Đào Tạo FPT"} • ${enrollment.totalLessons} bài',
                          style: const TextStyle(
                            fontSize: 10.5,
                            color: Color(0xFF64748B),
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // Row 4: Progress Bar & Continue button
                  Row(
                    children: [
                      // Mini Progress bar
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 5,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF1F5F9),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: FractionallySizedBox(
                                alignment: Alignment.centerLeft,
                                widthFactor: enrollment.progressRatio,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: LinearGradient(
                                      colors: isHighProgress
                                          ? [
                                              const Color(0xFF34D399),
                                              const Color(0xFF10B981),
                                            ]
                                          : [
                                              const Color(0xFFFBBF24),
                                              const Color(0xFFF59E0B),
                                            ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              enrollment.isCompleted
                                  ? 'Đã hoàn thành toàn bộ bài học 🎉'
                                  : (enrollment.currentLessonTitle ??
                                        'Xem chi tiết môn học'),
                              style: const TextStyle(
                                fontSize: 10,
                                color: Color(0xFF94A3B8),
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 8),

                      // Button Học tiếp / Ôn tập
                      InkWell(
                        onTap: onTapContinue,
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 9,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: enrollment.isCompleted
                                ? const Color(0xFFECFDF5)
                                : const Color(0xFFEEF2FF),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                enrollment.isCompleted ? 'Ôn tập' : 'Học tiếp',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w800,
                                  color: enrollment.isCompleted
                                      ? const Color(0xFF059669)
                                      : AppColors.primary,
                                ),
                              ),
                              const SizedBox(width: 3),
                              Icon(
                                enrollment.isCompleted
                                    ? Icons.replay_rounded
                                    : Icons.arrow_forward_rounded,
                                size: 12,
                                color: enrollment.isCompleted
                                    ? const Color(0xFF059669)
                                    : AppColors.primary,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFallbackThumbnail(String code) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1E3A8A), Color(0xFF2563EB)],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.auto_stories_rounded,
              color: Colors.white70,
              size: 26,
            ),
            const SizedBox(height: 4),
            Text(
              code,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
