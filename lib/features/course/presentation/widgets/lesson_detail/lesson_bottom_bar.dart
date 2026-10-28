import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';

class LessonBottomBar extends StatelessWidget {
  const LessonBottomBar({
    super.key,
    required this.isCompleted,
    required this.isUpdating,
    required this.onTapPrevious,
    required this.onToggleComplete,
    required this.onTapNext,
    this.hasPrevious = true,
    this.hasNext = true,
    this.isQuiz = false,
  });

  final bool isCompleted;
  final bool isUpdating;
  final VoidCallback onTapPrevious;
  final VoidCallback onToggleComplete;
  final VoidCallback onTapNext;
  final bool hasPrevious;
  final bool hasNext;
  final bool isQuiz;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.95),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: AppColors.textPrimary.withValues(alpha: 0.1),
              blurRadius: 20,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            if (isQuiz) ...[
              // Khi là Quiz: chỉ hiển thị 2 nút điều hướng Bài trước và Bài tiếp theo
              Expanded(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: onTapPrevious,
                    borderRadius: BorderRadius.circular(14),
                    child: Container(
                      height: 42,
                      decoration: BoxDecoration(
                        color: AppColors.surfaceLight,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            hasPrevious
                                ? Icons.arrow_back_rounded
                                : Icons.arrow_back_ios_new_rounded,
                            size: 16,
                            color: AppColors.textSecondaryDark,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            hasPrevious ? 'Bài trước' : 'Quay lại',
                            style: const TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textSecondaryDark,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: onTapNext,
                    borderRadius: BorderRadius.circular(14),
                    child: Container(
                      height: 42,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            hasNext ? 'Bài tiếp' : 'Hoàn tất',
                            style: const TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Icon(
                            hasNext
                                ? Icons.arrow_forward_rounded
                                : Icons.check_circle_outline_rounded,
                            size: 16,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ] else ...[
              // Khi là bài học thông thường: 3 nút (Bài trước - Hoàn thành - Bài tiếp theo)
              // 1. Nút quay lại bài trước
              Tooltip(
                message: hasPrevious ? 'Bài trước' : 'Đầu khóa học',
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: hasPrevious ? onTapPrevious : null,
                    borderRadius: BorderRadius.circular(14),
                    child: Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: AppColors.surfaceLight,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Center(
                        child: Icon(
                          hasPrevious
                              ? Icons.arrow_back_rounded
                              : Icons.arrow_back_ios_new_rounded,
                          size: 18,
                          color: AppColors.textSecondaryDark,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),

              // 2. Nút trạng thái hoàn thành bài học (Primary Action Center)
              Expanded(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: (isUpdating || isCompleted)
                        ? null
                        : onToggleComplete,
                    borderRadius: BorderRadius.circular(14),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      height: 42,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: isCompleted
                            ? AppColors.successVibrant
                            : AppColors.primaryContainer,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: isCompleted
                              ? AppColors.successDarkText
                              : AppColors.primaryBorder,
                        ),
                        boxShadow: isCompleted
                            ? [
                                BoxShadow(
                                  color: const Color(
                                    0xFF16A34A,
                                  ).withValues(alpha: 0.25),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ]
                            : null,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (isUpdating)
                            const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                            )
                          else
                            Container(
                              width: 18,
                              height: 18,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isCompleted
                                    ? Colors.white
                                    : Colors.transparent,
                                border: Border.all(
                                  color: isCompleted
                                      ? Colors.white
                                      : AppColors.primary,
                                  width: 1.5,
                                ),
                              ),
                              child: isCompleted
                                  ? const Center(
                                      child: Icon(
                                        Icons.check_rounded,
                                        size: 12,
                                        color: AppColors.successDarkText,
                                      ),
                                    )
                                  : null,
                            ),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              isCompleted
                                  ? 'Đã hoàn thành'
                                  : 'Hoàn thành bài học',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                color: isCompleted
                                    ? Colors.white
                                    : AppColors.primaryForeground,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),

              // 3. Nút chuyển sang bài tiếp theo / Hoàn tất
              Tooltip(
                message: hasNext ? 'Bài tiếp' : 'Hoàn tất',
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: onTapNext,
                    borderRadius: BorderRadius.circular(14),
                    child: Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Icon(
                          hasNext
                              ? Icons.arrow_forward_rounded
                              : Icons.check_circle_outline_rounded,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
