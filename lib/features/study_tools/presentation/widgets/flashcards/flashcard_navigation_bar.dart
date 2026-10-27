import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';

/// Thanh điều hướng thẻ trước, lật thẻ và thẻ sau
class FlashcardNavigationBar extends StatelessWidget {
  const FlashcardNavigationBar({
    super.key,
    required this.hasPrevious,
    required this.hasNext,
    required this.onPrevious,
    required this.onNext,
    required this.onFlip,
  });

  final bool hasPrevious;
  final bool hasNext;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final VoidCallback onFlip;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: hasPrevious ? onPrevious : null,
              icon: const Icon(Icons.arrow_back_rounded),
              color: AppColors.textSecondaryDark,
              tooltip: 'Thẻ trước',
            ),
            TextButton.icon(
              onPressed: onFlip,
              icon: const Icon(
                Icons.flip_rounded,
                size: 16,
                color: AppColors.primary,
              ),
              label: const Text(
                'Lật thẻ để xem giải thích',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
            ),
            IconButton(
              onPressed: hasNext ? onNext : null,
              icon: const Icon(Icons.arrow_forward_rounded),
              color: AppColors.textSecondaryDark,
              tooltip: 'Thẻ sau',
            ),
          ],
        ),
      ),
    );
  }
}
