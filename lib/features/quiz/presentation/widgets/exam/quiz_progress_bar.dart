import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';

/// Thanh trạng thái & tiến độ làm bài thi dạng tối giản
/// - Hiển thị số thứ tự câu hỏi dạng '03 / 10'
/// - Hiển thị pill badge số câu đã làm 'X đã làm'
/// - Thanh tiến độ chỉ tăng khi người dùng đã chọn đáp án
class QuizProgressBar extends StatelessWidget {
  const QuizProgressBar({
    super.key,
    required this.currentIndex,
    required this.totalQuestions,
    required this.answeredCount,
    this.isDark = true,
  });

  final int currentIndex;
  final int totalQuestions;
  final int answeredCount;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    if (totalQuestions <= 0) return const SizedBox.shrink();

    final progress = (answeredCount / totalQuestions).clamp(0.0, 1.0);
    final countText =
        '${(currentIndex + 1).toString().padLeft(2, '0')} / ${totalQuestions.toString().padLeft(2, '0')}';

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              countText,
              style: TextStyle(
                fontSize: 14.5,
                fontWeight: FontWeight.w800,
                color: isDark ? Colors.white : const Color(0xFF0F172A),
                letterSpacing: 0.5,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.18)
                    : const Color(0xFFEFF6FF),
                borderRadius: BorderRadius.circular(20),
                border: isDark
                    ? Border.all(color: Colors.white.withValues(alpha: 0.25))
                    : null,
              ),
              child: Text(
                '$answeredCount đã làm',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: isDark ? Colors.white : AppColors.primary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 4.5,
            backgroundColor: isDark
                ? Colors.white.withValues(alpha: 0.15)
                : const Color(0xFFE2E8F0),
            valueColor: AlwaysStoppedAnimation<Color>(
              isDark ? AppColors.accent : AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }
}
