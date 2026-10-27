import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';

/// Thanh tiến trình lướt bộ thẻ flashcards
class FlashcardProgressHeader extends StatelessWidget {
  const FlashcardProgressHeader({
    super.key,
    required this.currentIndex,
    required this.totalCards,
  });

  final int currentIndex;
  final int totalCards;

  @override
  Widget build(BuildContext context) {
    final progress = totalCards > 0 ? (currentIndex + 1) / totalCards : 0.0;

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 6, 24, 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Thẻ ${currentIndex + 1}/$totalCards',
                style: const TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              Text(
                '${(progress * 100).round()}% hoàn thành',
                style: const TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6,
              backgroundColor: AppColors.border,
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
