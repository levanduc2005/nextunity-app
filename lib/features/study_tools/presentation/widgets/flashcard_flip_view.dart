import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/core/theme/app_spacing.dart';
import 'package:rental_car/core/theme/app_text_styles.dart';
import 'package:rental_car/core/widgets/widgets.dart';

/// Thẻ flashcard lật 2 mặt (Câu hỏi / Đáp án)
class FlashcardFlipView extends StatelessWidget {
  const FlashcardFlipView({
    super.key,
    required this.isFlipped,
    required this.question,
    required this.answer,
    required this.onTap,
  });

  final bool isFlipped;
  final String question;
  final String answer;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: double.infinity,
        padding: const EdgeInsets.all(AppSpacing.xl),
        decoration: BoxDecoration(
          color: isFlipped ? const Color(0xFFF0FDF4) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isFlipped ? Colors.green.shade400 : Colors.indigo.shade200,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(12),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isFlipped ? '💡 ĐÁP ÁN' : '❓ CÂU HỎI',
              style: TextStyle(
                color: isFlipped ? Colors.green.shade700 : AppColors.primary,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            const Gap(AppSpacing.lg),
            Text(
              isFlipped ? answer : question,
              style: AppTextStyles.heading2.copyWith(fontSize: 20, height: 1.4),
              textAlign: TextAlign.center,
            ),
            const Gap(AppSpacing.xl),
            const Text(
              'Chạm để lật thẻ',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
