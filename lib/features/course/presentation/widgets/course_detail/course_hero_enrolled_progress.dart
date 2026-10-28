import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';

/// Thẻ hiển thị thanh tiến độ học tập môn học đã đăng ký chuẩn ApSkil 'Kelas Berlangsung'
class CourseHeroEnrolledProgress extends StatelessWidget {
  const CourseHeroEnrolledProgress({
    super.key,
    required this.completedCount,
    required this.effectiveTotal,
    required this.progressFraction,
    required this.progressPercent,
  });

  final int completedCount;
  final int effectiveTotal;
  final double progressFraction;
  final int progressPercent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: AppColors.textPrimary.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  '$completedCount bài học đã hoàn thành',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '$effectiveTotal bài học',
                style: const TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Progress Bar với chấm tròn chuẩn ApSkil
          Stack(
            alignment: Alignment.centerLeft,
            children: [
              Container(
                height: 6,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              FractionallySizedBox(
                widthFactor: progressFraction.clamp(0.02, 1.0),
                child: Container(
                  height: 6,
                  decoration: BoxDecoration(
                    color: progressFraction >= 1.0
                        ? AppColors.success
                        : AppColors.primary,
                    gradient: progressFraction < 1.0
                        ? const LinearGradient(
                            colors: [AppColors.primary, AppColors.accent],
                          )
                        : null,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Text(
                'Tiến độ: $progressPercent%',
                style: TextStyle(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                  color: progressFraction >= 1.0
                      ? AppColors.successForeground
                      : AppColors.primaryForeground,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  progressFraction >= 1.0
                      ? 'Đã hoàn thành xuất sắc'
                      : 'Còn ${effectiveTotal - completedCount} bài học tiếp theo',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.end,
                  style: const TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
