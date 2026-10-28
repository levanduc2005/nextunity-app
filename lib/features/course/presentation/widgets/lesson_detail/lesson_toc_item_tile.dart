import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/features/course/domain/entities/lesson_entity.dart';

/// Dòng hiển thị bài học trong mục lục bài giảng (Table of Contents)
class LessonTocItemTile extends StatelessWidget {
  const LessonTocItemTile({
    super.key,
    required this.lesson,
    required this.isCurrent,
    required this.onSelect,
  });

  final LessonEntity lesson;
  final bool isCurrent;
  final VoidCallback onSelect;

  @override
  Widget build(BuildContext context) {
    final isCompleted = lesson.isCompleted;

    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      decoration: BoxDecoration(
        color: isCurrent ? AppColors.primaryContainer : AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isCurrent ? AppColors.primaryBorder : AppColors.surfaceSubtle,
          width: isCurrent ? 1.2 : 1.0,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onSelect,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
            child: Row(
              children: [
                // 1. Icon trạng thái bên trái: tích xanh khi hoàn thành, xanh theme app khi đang học
                if (isCompleted)
                  Container(
                    width: 26,
                    height: 26,
                    decoration: const BoxDecoration(
                      color: AppColors.successContainer,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.check_rounded,
                        color: AppColors.successVibrant,
                        size: 15,
                      ),
                    ),
                  )
                else if (isCurrent)
                  Container(
                    width: 26,
                    height: 26,
                    decoration: const BoxDecoration(
                      color: AppColors.primaryContainer,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.play_arrow_rounded,
                        color: AppColors.primary,
                        size: 17,
                      ),
                    ),
                  )
                else
                  Container(
                    width: 26,
                    height: 26,
                    decoration: const BoxDecoration(
                      color: AppColors.surfaceSubtle,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.radio_button_unchecked_rounded,
                        color: AppColors.textMuted,
                        size: 14,
                      ),
                    ),
                  ),
                const SizedBox(width: 10),

                // 2. Tiêu đề bài học
                Expanded(
                  child: Text(
                    lesson.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: isCurrent ? FontWeight.w800 : FontWeight.w600,
                      color: isCurrent
                          ? AppColors.primary
                          : AppColors.textPrimary,
                    ),
                  ),
                ),
                const SizedBox(width: 8),

                // 3. Phía bên phải ngoài cùng: Type của lesson
                _buildLessonTypeBadge(lesson),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLessonTypeBadge(LessonEntity lesson) {
    final type = lesson.type.toUpperCase();
    String label;
    Color bg;
    Color text;
    Color border;
    IconData icon;

    switch (type) {
      case 'QUIZ':
        label = 'Kiểm tra';
        bg = const Color(0xFFFAF5FF);
        text = const Color(0xFF7E22CE);
        border = const Color(0xFFE9D5FF);
        icon = Icons.quiz_outlined;
      case 'VIDEO':
        label = 'Video';
        bg = AppColors.primaryContainer;
        text = AppColors.primaryForeground;
        border = AppColors.primaryBorder;
        icon = Icons.play_circle_outline_rounded;
      case 'TEXT':
      default:
        label = 'Lý thuyết';
        bg = AppColors.surfaceLight;
        text = AppColors.textSecondaryDark;
        border = AppColors.border;
        icon = Icons.menu_book_rounded;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: text),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10.5,
              fontWeight: FontWeight.w700,
              color: text,
            ),
          ),
        ],
      ),
    );
  }
}
