import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/features/course/domain/entities/lesson_entity.dart';
import 'package:rental_car/features/course/domain/entities/module_entity.dart';
import 'package:rental_car/features/course/presentation/widgets/course_detail/syllabus_lesson_tile.dart';

class SyllabusModuleItem extends StatefulWidget {
  const SyllabusModuleItem({
    super.key,
    required this.module,
    required this.index,
    required this.isExpandedInitially,
    required this.onTapLesson,
    this.isCourseEnrolled = false,
    this.activeLessonId,
  });

  final ModuleEntity module;
  final int index;
  final bool isExpandedInitially;
  final bool isCourseEnrolled;
  final String? activeLessonId;
  final ValueChanged<LessonEntity> onTapLesson;

  @override
  State<SyllabusModuleItem> createState() => _SyllabusModuleItemState();
}

class _SyllabusModuleItemState extends State<SyllabusModuleItem> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.isExpandedInitially;
  }

  @override
  Widget build(BuildContext context) {
    final module = widget.module;
    final isEnrolled = widget.isCourseEnrolled;
    final isCompleted = isEnrolled && module.isAllCompleted;

    // Header styling based on state
    Color headerBorderColor = AppColors.border;
    if (isCompleted) {
      headerBorderColor = AppColors.successBorder;
    } else if (isEnrolled) {
      headerBorderColor = AppColors.primaryBorder;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: headerBorderColor,
          width: isEnrolled && !isCompleted ? 1.5 : 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.textPrimary.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header Row
          InkWell(
            onTap: () => setState(() => _isExpanded = !_isExpanded),
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  // Icon badge (Check or Module Number)
                  Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      color: isCompleted
                          ? const Color(0xFFD1FAE5)
                          : (isEnrolled
                                ? AppColors.primary
                                : AppColors.surfaceSubtle),
                      borderRadius: BorderRadius.circular(10),
                      border: isEnrolled
                          ? null
                          : Border.all(color: AppColors.borderMedium),
                    ),
                    child: Center(
                      child: isCompleted
                          ? const Icon(
                              Icons.check_rounded,
                              size: 18,
                              color: AppColors.successDark,
                            )
                          : Text(
                              '0${widget.index + 1}',
                              style: TextStyle(
                                color: isEnrolled
                                    ? Colors.white
                                    : AppColors.textSecondaryDark,
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // Module Title & Metadata
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'MODULE ${widget.index + 1}',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                                color: isCompleted
                                    ? AppColors.successDark
                                    : AppColors.primary,
                                letterSpacing: 0.5,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              isEnrolled
                                  ? '• ${module.completedLessonsCount}/${module.lessons.length} BÀI'
                                  : '• ${module.lessons.length} BÀI HỌC',
                              style: const TextStyle(
                                fontSize: 10,
                                color: AppColors.textMuted,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(
                          module.title,
                          style: const TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textPrimary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),

                  // Expand/Collapse Chevron
                  Icon(
                    _isExpanded
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    color: AppColors.textMuted,
                    size: 22,
                  ),
                ],
              ),
            ),
          ),

          // Sub-lessons list if expanded
          if (_isExpanded && module.lessons.isNotEmpty) ...[
            const Divider(height: 1, color: AppColors.surfaceSubtle),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: module.lessons.asMap().entries.map((entry) {
                  final idx = entry.key;
                  final lesson = entry.value;
                  final isLessonCompleted = isEnrolled && lesson.isCompleted;
                  final isLessonActive =
                      isEnrolled &&
                      !isLessonCompleted &&
                      lesson.id == widget.activeLessonId;

                  return SyllabusLessonTile(
                    lesson: lesson,
                    moduleIndex: widget.index + 1,
                    lessonIndex: idx + 1,
                    isEnrolled: isEnrolled,
                    isActive: isLessonActive,
                    onTap: widget.onTapLesson,
                  );
                }).toList(),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
