import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/features/course/domain/entities/course_entity.dart';
import 'package:rental_car/features/course/domain/entities/lesson_entity.dart';
import 'package:rental_car/features/course/domain/entities/module_entity.dart';
import 'package:rental_car/features/course/presentation/widgets/lesson_detail/lesson_toc_bottom_sheet.dart';

/// App Bar chi tiết bài học chuẩn Phương Án 1:
/// Dòng 1: [MÃ MÔN] • BÀI X/Y
/// Dòng 2: Tên bài học
/// Cạnh phải: Huy hiệu [Đã học] và nút [Mục lục]
class LessonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const LessonAppBar({
    super.key,
    required this.lesson,
    required this.course,
    required this.modules,
    required this.onSelectLesson,
    this.isCompleted = false,
  });

  final LessonEntity lesson;
  final CourseEntity? course;
  final List<ModuleEntity> modules;
  final ValueChanged<LessonEntity> onSelectLesson;
  final bool isCompleted;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    // Tính toán số thứ tự bài học trong toàn bộ khóa học
    final allLessons = [
      for (final module in modules) ...module.lessons,
    ];
    final currentIndex = allLessons.indexWhere((l) => l.id == lesson.id);
    final displayIndex = currentIndex >= 0 ? currentIndex + 1 : 1;
    final totalLessons = allLessons.isNotEmpty ? allLessons.length : 1;

    final code = (course?.code.isNotEmpty == true ? course!.code : 'BÀI HỌC').toUpperCase();
    final progressBadge = allLessons.isNotEmpty
        ? '$code • BÀI $displayIndex/$totalLessons'
        : code;

    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 1,
      surfaceTintColor: Colors.transparent,
      leading: Center(
        child: InkWell(
          onTap: () => context.pop(),
          borderRadius: BorderRadius.circular(18),
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.surfaceLight,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.border),
            ),
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 15,
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ),
      titleSpacing: 4,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            progressBadge,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w800,
              color: AppColors.primary,
              letterSpacing: 0.6,
            ),
          ),
          const SizedBox(height: 1),
          Text(
            lesson.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.w900,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
      actions: [
        if (isCompleted)
          Center(
            child: Container(
              margin: const EdgeInsets.only(right: 6),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.successContainer,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.successBorderLight),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.check_circle_rounded,
                    size: 13,
                    color: AppColors.successForeground,
                  ),
                  SizedBox(width: 4),
                  Text(
                    'Đã học',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: AppColors.successForeground,
                    ),
                  ),
                ],
              ),
            ),
          ),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 12),
            child: InkWell(
              onTap: () {
                LessonTocBottomSheet.show(
                  context: context,
                  currentLessonId: lesson.id,
                  modules: modules,
                  onSelectLesson: onSelectLesson,
                );
              },
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.surfaceLight,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                child: const Icon(
                  Icons.format_list_bulleted_rounded,
                  size: 18,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
