import 'package:flutter/material.dart';
import 'package:rental_car/features/course/domain/entities/lesson_entity.dart';
import 'package:rental_car/features/course/domain/entities/module_entity.dart';
import 'package:rental_car/features/course/presentation/widgets/course_detail/syllabus_module_item.dart';

class CourseSyllabusTabView extends StatelessWidget {
  const CourseSyllabusTabView({
    super.key,
    required this.modules,
    required this.isEnrolled,
    required this.isCourseCompleted,
    this.incompleteLesson,
    required this.onTapLesson,
  });

  final List<ModuleEntity> modules;
  final bool isEnrolled;
  final bool isCourseCompleted;
  final LessonEntity? incompleteLesson;
  final ValueChanged<LessonEntity> onTapLesson;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Section Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Expanded(
              child: Text(
                'Giáo trình bài học',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF0F172A),
                  letterSpacing: -0.3,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '${modules.length} chương',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Color(0xFF64748B),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),

        if (modules.isEmpty)
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: const Center(
              child: Text(
                'Đang cập nhật lộ trình bài học...',
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF64748B),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          )
        else
          ...modules.asMap().entries.map((entry) {
            final idx = entry.key;
            final mod = entry.value;
            final isCurrentActiveModule =
                !isCourseCompleted && incompleteLesson != null
                ? mod.lessons.any((l) => l.id == incompleteLesson!.id)
                : idx == 0;
            return SyllabusModuleItem(
              module: mod,
              index: idx,
              isCourseEnrolled: isEnrolled,
              activeLessonId: isCourseCompleted ? null : incompleteLesson?.id,
              isExpandedInitially: isEnrolled
                  ? isCurrentActiveModule
                  : idx == 0,
              onTapLesson: onTapLesson,
            );
          }),
      ],
    );
  }
}
