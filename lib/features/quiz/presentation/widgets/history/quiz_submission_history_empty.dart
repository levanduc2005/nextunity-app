import 'package:flutter/material.dart';

import 'package:rental_car/core/theme/app_colors.dart';
/// Trạng thái rỗng khi chưa có lượt làm bài nào trong lịch sử
class QuizSubmissionHistoryEmpty extends StatelessWidget {
  const QuizSubmissionHistoryEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 36),
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: const BoxDecoration(
              color: AppColors.surfaceSubtle,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(
                Icons.assignment_late_outlined,
                size: 28,
                color: AppColors.textMuted,
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Chưa có lượt làm bài nào',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppColors.textLabel,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Hãy làm bài kiểm tra để lưu kết quả và theo dõi tiến độ.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12.5, color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}
