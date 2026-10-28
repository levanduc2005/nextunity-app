import 'package:flutter/material.dart';

import 'package:rental_car/core/theme/app_colors.dart';
/// Hộp hiển thị quy chế & hướng dẫn thi trắc nghiệm
class LessonAssessmentRulesBox extends StatelessWidget {
  const LessonAssessmentRulesBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.rule_rounded, size: 16, color: AppColors.textSecondaryDark),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Quy chế & Hướng dẫn thi:',
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _buildAssessmentRuleItem(
            'Hệ thống tự động chấm điểm và phản hồi chi tiết ngay khi bạn bấm Nộp bài.',
          ),
          const SizedBox(height: 6),
          _buildAssessmentRuleItem(
            'Cần đạt từ 80% điểm số để hệ thống ghi nhận hoàn thành bài học vào tiến độ khóa học.',
          ),
          const SizedBox(height: 6),
          _buildAssessmentRuleItem(
            'Bạn có thể xem lại đáp án, giải thích chi tiết và làm lại nhiều lần để cải thiện kết quả.',
          ),
        ],
      ),
    );
  }

  Widget _buildAssessmentRuleItem(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 6),
          width: 4,
          height: 4,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.textMuted,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 11,
              color: AppColors.textSecondaryDark,
              height: 1.35,
            ),
          ),
        ),
      ],
    );
  }
}
