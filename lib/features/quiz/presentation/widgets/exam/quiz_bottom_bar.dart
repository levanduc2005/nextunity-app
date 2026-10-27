import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';

/// Thanh điều hướng bài thi (Bottom Bar) chuẩn phong cách hiện đại
/// - Nút lùi lại tròn dạng icon ở góc trái
/// - Nút 'Tiếp theo' / 'Nộp bài' dạng pill bo góc đầy đặn ở góc phải
class QuizBottomBar extends StatelessWidget {
  const QuizBottomBar({
    super.key,
    required this.currentIndex,
    required this.totalQuestions,
    required this.onNextOrSubmit,
    this.onPrevious,
    this.isSubmitting = false,
    this.canGoNext = true,
  });

  final int currentIndex;
  final int totalQuestions;
  final VoidCallback onNextOrSubmit;
  final VoidCallback? onPrevious;
  final bool isSubmitting;
  final bool canGoNext;

  @override
  Widget build(BuildContext context) {
    final isLastQuestion = currentIndex >= totalQuestions - 1;
    final canGoBack = currentIndex > 0 && onPrevious != null;

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Nút quay lại tròn (Circular Back Button)
          InkWell(
            onTap: canGoBack ? onPrevious : null,
            borderRadius: BorderRadius.circular(26),
            child: Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: canGoBack
                    ? AppColors.primaryContainer
                    : const Color(0xFFF8FAFC),
                border: Border.all(
                  color: canGoBack
                      ? AppColors.primaryBorder
                      : const Color(0xFFE2E8F0),
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 18,
                  color: canGoBack
                      ? AppColors.primaryForeground
                      : const Color(0xFFCBD5E1),
                ),
              ),
            ),
          ),

          // Nút Tiếp theo / Nộp bài (Next / Submit Button)
          InkWell(
            onTap: canGoNext && !isSubmitting ? onNextOrSubmit : null,
            borderRadius: BorderRadius.circular(16),
            child: Container(
              height: 52,
              padding: const EdgeInsets.symmetric(horizontal: 40),
              decoration: BoxDecoration(
                color: canGoNext ? AppColors.primary : const Color(0xFFCBD5E1),
                borderRadius: BorderRadius.circular(16),
                boxShadow: canGoNext
                    ? [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.32),
                          blurRadius: 14,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : null,
              ),
              child: Center(
                child: isSubmitting
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      )
                    : Text(
                        isLastQuestion ? 'Nộp bài thi' : 'Tiếp theo',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          letterSpacing: 0.3,
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
