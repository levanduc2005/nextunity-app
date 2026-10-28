import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rental_car/features/quiz/domain/entities/quiz_result_entity.dart';

import 'package:rental_car/core/theme/app_colors.dart';
class SubmissionScoreBanner extends StatelessWidget {
  const SubmissionScoreBanner({super.key, required this.submission});

  final QuizResultEntity submission;

  @override
  Widget build(BuildContext context) {
    final isPassed = submission.isPassed;
    final totalQuestions = submission.questionResults.length;
    final correctCount = submission.questionResults
        .where((q) => q.isCorrect)
        .length;
    final dateFormatted = submission.submittedAt != null
        ? DateFormat(
            'dd/MM/yyyy HH:mm',
          ).format(submission.submittedAt!.toLocal())
        : 'Vừa xong';

    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isPassed ? AppColors.successBorder : AppColors.expiredBorder,
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.textPrimary.withValues(alpha: 0.05),
            blurRadius: 18,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Tag Trang thai Dat / Chua dat
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: isPassed
                  ? AppColors.successContainer
                  : AppColors.errorContainer,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isPassed
                    ? const Color(0xFF86EFAC)
                    : AppColors.errorBorderLight,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isPassed ? Icons.check_circle_rounded : Icons.cancel_rounded,
                  size: 15,
                  color: isPassed
                      ? AppColors.successVibrant
                      : AppColors.error,
                ),
                const SizedBox(width: 6),
                Text(
                  isPassed ? 'ĐẠT CHUẨN ĐẦU RA' : 'CHƯA ĐẠT CHUẨN',
                  style: TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w800,
                    color: isPassed
                        ? AppColors.successDarkText
                        : AppColors.errorDark,
                    letterSpacing: 0.4,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Ty le phan tram (%)
          Text(
            '${submission.percentage.toStringAsFixed(0)}%',
            style: TextStyle(
              fontSize: 54,
              fontWeight: FontWeight.w900,
              color: isPassed
                  ? AppColors.successDark
                  : AppColors.errorForeground,
              letterSpacing: -1.5,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            isPassed
                ? 'Xin chúc mừng! Bạn đã hoàn thành xuất sắc bài kiểm tra.'
                : 'Cần đạt từ 80% trở lên để hoàn thành bài học này.',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isPassed
                  ? const Color(0xFF047857)
                  : AppColors.errorDark,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),

          // 3 Thong ke nho ben trong banner
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildHeroStatItem(
                  label: 'Số câu đúng',
                  value: '$correctCount/$totalQuestions câu',
                ),
                Container(width: 1, height: 26, color: AppColors.border),
                _buildHeroStatItem(
                  label: 'Điểm số',
                  value:
                      '${submission.score.toStringAsFixed(1)} / ${submission.totalPoints.toStringAsFixed(1)}',
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Thời gian nộp: $dateFormatted',
            style: const TextStyle(
              fontSize: 11,
              color: AppColors.textMuted,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroStatItem({required String label, required String value}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13.5,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
