import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/features/course/domain/entities/lesson_entity.dart';
import 'package:rental_car/features/course/domain/entities/module_entity.dart';

class LessonTocBottomSheet extends StatelessWidget {
  const LessonTocBottomSheet({
    super.key,
    required this.currentLessonId,
    required this.modules,
    required this.onSelectLesson,
  });

  final String currentLessonId;
  final List<ModuleEntity> modules;
  final ValueChanged<LessonEntity> onSelectLesson;

  static Future<void> show({
    required BuildContext context,
    required String currentLessonId,
    required List<ModuleEntity> modules,
    required ValueChanged<LessonEntity> onSelectLesson,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => LessonTocBottomSheet(
        currentLessonId: currentLessonId,
        modules: modules,
        onSelectLesson: (lesson) {
          Navigator.pop(ctx);
          onSelectLesson(lesson);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Mục lục khóa học',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF0F172A),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close_rounded, size: 20),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 10),
          if (modules.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: Center(
                child: Text(
                  'Không có bài học nào trong danh mục',
                  style: TextStyle(fontSize: 12, color: Color(0xFF94A3B8)),
                ),
              ),
            )
          else
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: modules.length,
                itemBuilder: (ctx, mIdx) {
                  final mod = modules[mIdx];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Text(
                          'MODULE ${mIdx + 1}: ${mod.title}',
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF64748B),
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      ...mod.lessons.map((lesson) {
                        final isCurrent = lesson.id == currentLessonId;
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          dense: true,
                          leading: lesson.isCompleted
                              ? const Icon(
                                  Icons.check_circle,
                                  color: Color(0xFF10B981),
                                  size: 20,
                                )
                              : (isCurrent
                                    ? const Icon(
                                        Icons.play_circle_fill,
                                        color: AppColors.primary,
                                        size: 20,
                                      )
                                    : const Icon(
                                        Icons.radio_button_unchecked,
                                        color: Colors.grey,
                                        size: 20,
                                      )),
                          title: Text(
                            lesson.title,
                            style: TextStyle(
                              fontSize: 12.5,
                              fontWeight: isCurrent
                                  ? FontWeight.w800
                                  : FontWeight.w500,
                              color: isCurrent
                                  ? AppColors.primary
                                  : const Color(0xFF1E293B),
                            ),
                          ),
                          onTap: () => onSelectLesson(lesson),
                        );
                      }),
                    ],
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
