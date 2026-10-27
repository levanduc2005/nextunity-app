import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';

/// Thanh đánh giá mức độ ghi nhớ (ApSkil Pill Buttons): Cần ôn lại, Tương đối nhớ, Đã thuộc
class FlashcardMemoryFeedbackBar extends StatelessWidget {
  const FlashcardMemoryFeedbackBar({super.key, required this.onFeedback});

  final VoidCallback onFeedback;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 12),
      child: Row(
        children: [
          Expanded(
            child: _buildMemoryFeedbackButton(
              label: 'Cần ôn lại',
              color: AppColors.alertBannerText,
              bgColor: AppColors.alertBannerBg,
              onTap: onFeedback,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _buildMemoryFeedbackButton(
              label: 'Tương đối nhớ',
              color: AppColors.primaryAction,
              bgColor: AppColors.primaryContainer,
              onTap: onFeedback,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _buildMemoryFeedbackButton(
              label: 'Đã thuộc',
              color: AppColors.successForeground,
              bgColor: AppColors.successContainer,
              onTap: onFeedback,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMemoryFeedbackButton({
    required String label,
    required Color color,
    required Color bgColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w800,
              color: color,
            ),
          ),
        ),
      ),
    );
  }
}
