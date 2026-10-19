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
  });

  final bool isCompleted;
  final bool isUpdating;
  final VoidCallback onTapPrevious;
  final VoidCallback onToggleComplete;
  final VoidCallback onTapNext;
  final bool hasPrevious;
  final bool hasNext;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.94),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF0F172A).withValues(alpha: 0.12),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            // Previous button
            InkWell(
              onTap: onTapPrevious,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFCBD5E1)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      hasPrevious
                          ? Icons.arrow_back_rounded
                          : Icons.arrow_back_ios_new_rounded,
                      size: 13,
                      color: const Color(0xFF475569),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      hasPrevious ? 'Bài trước' : 'Quay lại',
                      style: const TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF475569),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),

            // Toggle Completed Checkbox
            Expanded(
              child: InkWell(
                onTap: isUpdating ? null : onToggleComplete,
                borderRadius: BorderRadius.circular(12),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: isCompleted
                        ? const Color(0xFF10B981)
                        : const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isCompleted
                          ? const Color(0xFF059669)
                          : const Color(0xFFE2E8F0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (isUpdating)
                        const SizedBox(
                          width: 14,
                          height: 14,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        )
                      else
                        Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isCompleted
                                ? Colors.white
                                : Colors.transparent,
                            border: Border.all(
                              color: isCompleted
                                  ? Colors.white
                                  : const Color(0xFF94A3B8),
                              width: 1.5,
                            ),
                          ),
                          child: isCompleted
                              ? const Center(
                                  child: Icon(
                                    Icons.check_rounded,
                                    size: 11,
                                    color: Color(0xFF10B981),
                                  ),
                                )
                              : null,
                        ),
                      const SizedBox(width: 6),
                      Text(
                        isCompleted ? 'Đã hoàn thành' : 'Đánh dấu hoàn thành',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          color: isCompleted
                              ? Colors.white
                              : const Color(0xFF334155),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),

            // Next button
            InkWell(
              onTap: onTapNext,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.25),
                      blurRadius: 6,
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
                        fontSize: 11.5,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      hasNext
                          ? Icons.arrow_forward_rounded
                          : Icons.check_circle_outline_rounded,
                      size: 14,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
