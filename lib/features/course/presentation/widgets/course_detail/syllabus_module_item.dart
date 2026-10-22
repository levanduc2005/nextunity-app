import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/features/course/domain/entities/lesson_entity.dart';
import 'package:rental_car/features/course/domain/entities/module_entity.dart';

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
    Color headerBorderColor = const Color(0xFFE2E8F0);
    if (isCompleted) {
      headerBorderColor = const Color(0xFFA7F3D0);
    } else if (isEnrolled) {
      headerBorderColor = const Color(0xFFBBF7D0);
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
            color: const Color(0xFF0F172A).withValues(alpha: 0.04),
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
                                : const Color(0xFFF1F5F9)),
                      borderRadius: BorderRadius.circular(10),
                      border: isEnrolled
                          ? null
                          : Border.all(color: const Color(0xFFCBD5E1)),
                    ),
                    child: Center(
                      child: isCompleted
                          ? const Icon(
                              Icons.check_rounded,
                              size: 18,
                              color: Color(0xFF059669),
                            )
                          : Text(
                              '0${widget.index + 1}',
                              style: TextStyle(
                                color: isEnrolled
                                    ? Colors.white
                                    : const Color(0xFF475569),
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
                                    ? const Color(0xFF059669)
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
                                color: Color(0xFF94A3B8),
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
                            color: Color(0xFF0F172A),
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
                    color: const Color(0xFF94A3B8),
                    size: 22,
                  ),
                ],
              ),
            ),
          ),

          // Sub-lessons list if expanded
          if (_isExpanded && module.lessons.isNotEmpty) ...[
            const Divider(height: 1, color: Color(0xFFF1F5F9)),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: module.lessons.asMap().entries.map((entry) {
                  final idx = entry.key;
                  final lesson = entry.value;
                  return _buildLessonSubItem(
                    context,
                    lesson,
                    idx + 1,
                    isEnrolled,
                  );
                }).toList(),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildLessonSubItem(
    BuildContext context,
    LessonEntity lesson,
    int lessonIndex,
    bool isEnrolled,
  ) {
    final isCompleted = isEnrolled && lesson.isCompleted;
    final isActive =
        isEnrolled && !isCompleted && lesson.id == widget.activeLessonId;

    Color itemBg = const Color(0xFFF8FAFC);
    Color itemBorder = const Color(0xFFF1F5F9);
    if (isActive) {
      itemBg = const Color(0xFFF0FDF4);
      itemBorder = const Color(0xFF86EFAC);
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: itemBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: itemBorder),
      ),
      child: InkWell(
        onTap: () => widget.onTapLesson(lesson),
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
                            : const Color(0xFFE2E8F0)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: isCompleted
                      ? const Icon(
                          Icons.check_rounded,
                          size: 14,
                          color: Color(0xFF059669),
                        )
                      : (isActive
                            ? const Icon(
                                Icons.play_arrow_rounded,
                                size: 16,
                                color: Colors.white,
                              )
                            : Icon(
                                isEnrolled
                                    ? Icons.radio_button_unchecked_rounded
                                    : Icons.lock_outline_rounded,
                                size: 14,
                                color: const Color(0xFF64748B),
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
                      '${widget.index + 1}.$lessonIndex: ${lesson.title}',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: isActive
                            ? FontWeight.w800
                            : FontWeight.w600,
                        color: isActive
                            ? AppColors.primary
                            : const Color(0xFF1E293B),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${lesson.typeName ?? lesson.type} • ${lesson.estimatedMinutes} phút',
                      style: const TextStyle(
                        fontSize: 10,
                        color: Color(0xFF64748B),
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
                    color: Color(0xFF059669),
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
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Học',
                        style: TextStyle(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 3),
                      Icon(
                        Icons.play_arrow_rounded,
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
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.visibility_outlined,
                        size: 11,
                        color: Color(0xFF64748B),
                      ),
                      SizedBox(width: 3),
                      Text(
                        'Xem trước',
                        style: TextStyle(
                          fontSize: 9.5,
                          color: Color(0xFF64748B),
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
                    color: Color(0xFF94A3B8),
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
