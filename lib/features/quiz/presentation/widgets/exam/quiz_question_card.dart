import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';

/// Hiển thị nội dung câu hỏi trắc nghiệm thoáng đãng, tinh gọn
class QuizQuestionCard extends StatelessWidget {
  const QuizQuestionCard({
    super.key,
    required this.content,
    this.questionNumber,
    this.isMultiChoice = false,
    this.points,
  });

  final String content;
  final int? questionNumber;
  final bool isMultiChoice;
  final double? points;

  @override
  Widget build(BuildContext context) {
    final questionLabel = questionNumber != null ? 'Câu $questionNumber' : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (questionLabel != null || isMultiChoice) ...[
          Row(
            children: [
              if (questionLabel != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primaryContainer,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.primaryBorder),
                  ),
                  child: Text(
                    questionLabel,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primaryForeground,
                    ),
                  ),
                ),
              if (isMultiChoice) ...[
                if (questionLabel != null) const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE0F2FE),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFBAE6FD)),
                  ),
                  child: const Text(
                    'Chọn nhiều đáp án',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0284C7),
                    ),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 12),
        ],
        Text(
          content,
          style: const TextStyle(
            fontSize: 16.5,
            fontWeight: FontWeight.w800,
            color: Color(0xFF0F172A),
            height: 1.45,
            letterSpacing: -0.2,
          ),
        ),
      ],
    );
  }
}
