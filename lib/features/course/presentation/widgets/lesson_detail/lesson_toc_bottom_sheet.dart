import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/features/course/domain/entities/lesson_entity.dart';
import 'package:rental_car/features/course/domain/entities/module_entity.dart';
import 'package:rental_car/features/course/presentation/widgets/lesson_detail/lesson_toc_item_tile.dart';
import 'package:rental_car/features/course/presentation/widgets/lesson_detail/lesson_toc_module_header.dart';

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
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withValues(alpha: 0.5),
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
    final maxHeight = MediaQuery.of(context).size.height * 0.8;

    return Container(
      constraints: BoxConstraints(maxHeight: maxHeight),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Drag handle
            Center(
              child: Container(
                width: 44,
                height: 4.5,
                decoration: BoxDecoration(
                  color: AppColors.borderMedium,
                  borderRadius: BorderRadius.circular(2.5),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Header
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryContainer,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.format_list_bulleted_rounded,
                      color: AppColors.primary,
                      size: 20,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Mục lục khóa học',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                          letterSpacing: -0.3,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Chạm vào bài học để chuyển bài nhanh',
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.close_rounded,
                    size: 22,
                    color: AppColors.textSecondary,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 14),

            if (modules.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 36),
                child: Center(
                  child: Text(
                    'Không có bài học nào trong danh mục',
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.textMuted,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: modules.length,
                  itemBuilder: (ctx, mIdx) {
                    final mod = modules[mIdx];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Module Heading Header
                        LessonTocModuleHeader(
                          moduleIndex: mIdx + 1,
                          title: mod.title,
                          isFirst: mIdx == 0,
                        ),

                        // Module Lessons List
                        ...mod.lessons.map((lesson) {
                          return LessonTocItemTile(
                            lesson: lesson,
                            isCurrent: lesson.id == currentLessonId,
                            onSelect: () => onSelectLesson(lesson),
                          );
                        }),
                      ],
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
