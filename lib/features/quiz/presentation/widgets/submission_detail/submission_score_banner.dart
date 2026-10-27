import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rental_car/features/quiz/domain/entities/quiz_result_entity.dart';

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
          color: isPassed ? const Color(0xFFA7F3D0) : const Color(0xFFFECDD3),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withValues(alpha: 0.05),
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
                  ? const Color(0xFFDCFCE7)
                  : const Color(0xFFFEE2E2),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isPassed
                    ? const Color(0xFF86EFAC)
                    : const Color(0xFFFCA5A5),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isPassed ? Icons.check_circle_rounded : Icons.cancel_rounded,
                  size: 15,
                  color: isPassed
                      ? const Color(0xFF16A34A)
                      : const Color(0xFFEF4444),
                ),
                const SizedBox(width: 6),
                Text(
                  isPassed ? 'ĐẠT CHUẨN ĐẦU RA' : 'CHƯA ĐẠT CHUẨN',
                  style: TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w800,
                    color: isPassed
                        ? const Color(0xFF15803D)
                        : const Color(0xFFB91C1C),
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
                  ? const Color(0xFF059669)
                  : const Color(0xFFDC2626),
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
                  : const Color(0xFFB91C1C),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),

          // 3 Thong ke nho ben trong banner
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildHeroStatItem(
                  label: 'Số câu đúng',
                  value: '$correctCount/$totalQuestions câu',
                ),
                Container(width: 1, height: 26, color: const Color(0xFFE2E8F0)),
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
              color: Color(0xFF94A3B8),
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
            color: Color(0xFF64748B),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13.5,
            fontWeight: FontWeight.w800,
            color: Color(0xFF0F172A),
          ),
        ),
      ],
    );
  }
}
