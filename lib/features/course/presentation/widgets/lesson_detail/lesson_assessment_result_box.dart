import 'package:flutter/material.dart';

import 'package:rental_car/core/theme/app_colors.dart';
/// Thẻ hiển thị kết quả kiểm tra (ĐẠT / CHƯA ĐẠT) thay thế cho quy chế khi học viên đã từng nộp bài
class LessonAssessmentResultBox extends StatelessWidget {
  const LessonAssessmentResultBox({
    super.key,
    required this.isPassed,
    required this.bestPercentage,
    this.targetPercentage = 80.0,
  });

  final bool isPassed;
  final double bestPercentage;
  final double targetPercentage;

  @override
  Widget build(BuildContext context) {
    final int roundedScore = bestPercentage.round();
    final int roundedTarget = targetPercentage.round();
    final int diffNeeded = (roundedTarget - roundedScore).clamp(0, 100);

    final statusColor = isPassed
        ? AppColors.successDark
        : AppColors.errorForeground;
    final bgColor = isPassed
        ? const Color(0xFFECFDF5)
        : AppColors.errorSurfaceLight;
    final borderColor = isPassed
        ? AppColors.successBorder
        : AppColors.errorBorder;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. Dòng trạng thái chính: Icon + PASS / FAIL TO + Điểm %
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: isPassed
                      ? const Color(0xFFD1FAE5)
                      : AppColors.errorContainer,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    isPassed
                        ? Icons.check_circle_rounded
                        : Icons.cancel_rounded,
                    color: statusColor,
                    size: 26,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'KẾT QUẢ ĐẠT ĐƯỢC',
                      style: TextStyle(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w700,
                        color: isPassed
                            ? const Color(0xFF047857)
                            : AppColors.errorDark,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      isPassed ? 'ĐẠT YÊU CẦU' : 'CHƯA ĐẠT',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: statusColor,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ],
                ),
              ),
              // Điểm % cao nhất
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: borderColor),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '$roundedScore%',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: statusColor,
                        height: 1.1,
                      ),
                    ),
                    const Text(
                      'Điểm cao nhất',
                      style: TextStyle(
                        fontSize: 9.5,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // 2. Hộp thông tin phụ: Điều kiện đạt / Lời chúc mừng
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.9),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: isPassed
                    ? const Color(0xFF6EE7B7)
                    : AppColors.errorBorderLight,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  isPassed ? Icons.verified_rounded : Icons.flag_rounded,
                  size: 16,
                  color: statusColor,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: isPassed
                      ? const Text(
                          'Xin chúc mừng! Bạn đã hoàn thành xuất sắc bài kiểm tra này.',
                          style: TextStyle(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF065F46),
                          ),
                        )
                      : Text.rich(
                          TextSpan(
                            text: 'Điều kiện đạt: ',
                            style: const TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textSecondaryDark,
                            ),
                            children: [
                              TextSpan(
                                text: '≥ $roundedTarget%',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.errorForeground,
                                ),
                              ),
                              if (diffNeeded > 0)
                                TextSpan(
                                  text: ' • Cần thêm +$diffNeeded% để vượt qua',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF991B1B),
                                  ),
                                ),
                            ],
                          ),
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
