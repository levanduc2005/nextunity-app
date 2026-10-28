import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/features/course/domain/entities/lesson_entity.dart';

/// Dòng hiển thị bài học con trong danh sách giáo trình (Syllabus)
class SyllabusLessonTile extends StatelessWidget {
  const SyllabusLessonTile({
    super.key,
    required this.lesson,
    required this.moduleIndex,
    required this.lessonIndex,
    required this.isEnrolled,
    required this.isActive,
    required this.onTap,
  });

  final LessonEntity lesson;
  final int moduleIndex;
  final int lessonIndex;
  final bool isEnrolled;
  final bool isActive;
  final ValueChanged<LessonEntity> onTap;

  @override
  Widget build(BuildContext context) {
    final isCompleted = isEnrolled && lesson.isCompleted;

    Color itemBg = AppColors.surfaceLight;
    Color itemBorder = AppColors.surfaceSubtle;
    if (isActive) {
      itemBg = AppColors.primaryContainer;
      itemBorder = AppColors.primaryBorder;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: itemBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: itemBorder),
      ),
      child: InkWell(
        onTap: () => onTap(lesson),
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              // Icon Status
              Container(
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                  color: isCompleted
                      ? const Color(0xFFD1FAE5)
                      : (isActive
                            ? AppColors.primary
                            : AppColors.border),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: isCompleted
                      ? const Icon(
                          Icons.check_rounded,
                          size: 14,
                          color: AppColors.successDark,
                        )
                      : (isActive
                            ? Icon(
                                lesson.type == 'QUIZ'
                                    ? Icons.quiz_rounded
                                    : Icons.play_arrow_rounded,
                                size: 16,
                                color: Colors.white,
                              )
                            : Icon(
                                isEnrolled
                                    ? (lesson.type == 'QUIZ'
                                          ? Icons.quiz_outlined
                                          : Icons
                                                .radio_button_unchecked_rounded)
                                    : Icons.lock_outline_rounded,
                                size: 14,
                                color: AppColors.textSecondary,
                              )),
                ),
              ),
              const SizedBox(width: 10),

              // Title & Type Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$moduleIndex.$lessonIndex: ${lesson.title}',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: isActive
                            ? FontWeight.w800
                            : FontWeight.w600,
                        color: isActive
                            ? AppColors.primary
                            : AppColors.textDark,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${lesson.typeName ?? (lesson.type == 'QUIZ' ? 'Bài kiểm tra' : lesson.type)} • ${lesson.estimatedMinutes} phút',
                      style: const TextStyle(
                        fontSize: 10,
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              // Status chip or button
              if (isCompleted)
                const Text(
                  'Đã học',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: AppColors.successDark,
                  ),
                )
              else if (isActive)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        lesson.type == 'QUIZ' ? 'Làm bài' : 'Học',
                        style: const TextStyle(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 3),
                      Icon(
                        lesson.type == 'QUIZ'
                            ? Icons.quiz_rounded
                            : Icons.play_arrow_rounded,
                        size: 13,
                        color: Colors.white,
                      ),
                    ],
                  ),
                )
              else if (!isEnrolled)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceSubtle,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.visibility_outlined,
                        size: 11,
                        color: AppColors.textSecondary,
                      ),
                      SizedBox(width: 3),
                      Text(
                        'Xem trước',
                        style: TextStyle(
                          fontSize: 9.5,
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                )
              else
                const Text(
                  'Chưa học',
                  style: TextStyle(
                    fontSize: 10,
                    color: AppColors.textMuted,
                    fontWeight: FontWeight.w500,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
