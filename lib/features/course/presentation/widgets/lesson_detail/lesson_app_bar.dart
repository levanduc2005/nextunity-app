import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_car/features/course/domain/entities/course_entity.dart';
import 'package:rental_car/features/course/domain/entities/lesson_entity.dart';
import 'package:rental_car/features/course/domain/entities/module_entity.dart';
import 'package:rental_car/features/course/presentation/widgets/lesson_detail/lesson_toc_bottom_sheet.dart';

class LessonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const LessonAppBar({
    super.key,
    required this.lesson,
    required this.course,
    required this.modules,
    required this.onSelectLesson,
  });

  final LessonEntity lesson;
  final CourseEntity? course;
  final List<ModuleEntity> modules;
  final ValueChanged<LessonEntity> onSelectLesson;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
        color: const Color(0xFF1E293B),
        onPressed: () => context.pop(),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            course?.code ?? 'KHÓA HỌC',
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w800,
              color: Color(0xFF94A3B8),
              letterSpacing: 0.5,
            ),
          ),
          Text(
            lesson.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: Color(0xFF0F172A),
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.menu_book_rounded, size: 20),
          color: const Color(0xFF475569),
          tooltip: 'Mục lục bài học',
          onPressed: () {
            LessonTocBottomSheet.show(
              context: context,
              currentLessonId: lesson.id,
              modules: modules,
              onSelectLesson: onSelectLesson,
            );
          },
        ),
      ],
    );
  }
}
