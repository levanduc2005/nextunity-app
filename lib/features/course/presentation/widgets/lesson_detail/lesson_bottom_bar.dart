import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';

/// Bottom Navigation Bar tinh gọn theo chuẩn Phương Án 1:
/// - Nút Lùi tròn (circular button) nhẹ nhàng bên trái
/// - Nút Hoàn thành pill ở giữa (chuyển đổi Đã hoàn thành / Hoàn thành bài học)
/// - Nút Bài tiếp pill primary hiện đại bên phải
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
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 10),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.96),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: AppColors.textPrimary.withValues(alpha: 0.07),
              blurRadius: 18,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            if (isQuiz) ...[
              // Khi là Quiz: hiển thị 2 nút điều hướng Bài trước và Bài tiếp theo
              Expanded(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: onTapPrevious,
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.surfaceLight,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            hasPrevious
                                ? Icons.chevron_left_rounded
                                : Icons.arrow_back_ios_new_rounded,
                            size: 18,
                            color: AppColors.textSecondaryDark,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            hasPrevious ? 'Bài trước' : 'Quay lại',
                            style: const TextStyle(
                              fontSize: 12,
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
              const SizedBox(width: 8),
              Expanded(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: onTapNext,
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.28),
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
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            hasNext
                                ? Icons.chevron_right_rounded
                                : Icons.check_rounded,
                            size: 18,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ] else ...[
              // Khi là bài học thông thường: Tinh gọn theo chuẩn PA 1
              // 1. Nút Lùi tròn gọn gàng
              Tooltip(
                message: hasPrevious ? 'Bài trước' : 'Đầu khóa học',
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: hasPrevious ? onTapPrevious : null,
                    borderRadius: BorderRadius.circular(19),
                    child: Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: hasPrevious
                            ? AppColors.surfaceLight
                            : AppColors.surfaceLight.withValues(alpha: 0.5),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: hasPrevious
                              ? AppColors.border
                              : AppColors.border.withValues(alpha: 0.5),
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.chevron_left_rounded,
                          size: 22,
                          color: hasPrevious
                              ? AppColors.textPrimary
                              : AppColors.textMuted,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),

              // 2. Nút trạng thái hoàn thành bài học (Pill ở giữa)
              Expanded(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: (isUpdating || isCompleted)
                        ? null
                        : onToggleComplete,
                    borderRadius: BorderRadius.circular(19),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      height: 38,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: isCompleted
                            ? AppColors.successContainer
                            : AppColors.primaryContainer,
                        borderRadius: BorderRadius.circular(19),
                        border: Border.all(
                          color: isCompleted
                              ? AppColors.successBorderLight
                              : AppColors.primaryBorder,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (isUpdating)
                            const SizedBox(
                              width: 15,
                              height: 15,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  AppColors.primary,
                                ),
                              ),
                            )
                          else
                            Icon(
                              isCompleted
                                  ? Icons.check_circle_rounded
                                  : Icons.check_circle_outline_rounded,
                              size: 16,
                              color: isCompleted
                                  ? AppColors.successForeground
                                  : AppColors.primaryForeground,
                            ),
                          const SizedBox(width: 6),
                          Flexible(
                            child: Text(
                              isCompleted
                                  ? 'Đã hoàn thành'
                                  : 'Hoàn thành bài học',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                color: isCompleted
                                    ? AppColors.successForeground
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

              // 3. Nút chuyển sang Bài tiếp theo (Pill primary gọn gàng chuẩn PA 1)
              Tooltip(
                message: hasNext ? 'Bài tiếp' : 'Hoàn tất khóa học',
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: onTapNext,
                    borderRadius: BorderRadius.circular(19),
                    child: Container(
                      height: 38,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(19),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.28),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            hasNext ? 'Bài tiếp' : 'Hoàn tất',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 3),
                          Icon(
                            hasNext
                                ? Icons.chevron_right_rounded
                                : Icons.check_rounded,
                            size: 18,
                            color: Colors.white,
                          ),
                        ],
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
