import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_car/features/course/domain/entities/course_entity.dart';
import 'package:rental_car/features/course/domain/entities/lesson_entity.dart';
import 'package:rental_car/features/course/domain/entities/module_entity.dart';
import 'package:rental_car/features/course/presentation/widgets/lesson_detail/lesson_toc_bottom_sheet.dart';

/// App Bar chi tiết bài học chuẩn phong cách ApSkil (Materi Kelas)
class LessonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const LessonAppBar({
    super.key,
    required this.lesson,
    required this.course,
    required this.modules,
    required this.onSelectLesson,
    this.onFavorite,
  });

  final LessonEntity lesson;
  final CourseEntity? course;
  final List<ModuleEntity> modules;
  final ValueChanged<LessonEntity> onSelectLesson;
  final VoidCallback? onFavorite;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 1,
      surfaceTintColor: Colors.transparent,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
        color: const Color(0xFF0F172A),
        onPressed: () => context.pop(),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            course?.code.isNotEmpty == true ? course!.code : 'BÀI HỌC',
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w800,
              color: Color(0xFF64748B),
              letterSpacing: 0.5,
            ),
          ),
          Text(
            lesson.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w900,
              color: Color(0xFF0F172A),
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.favorite_border_rounded, size: 20),
          color: const Color(0xFF0F172A),
          tooltip: 'Yêu thích bài học',
          onPressed: onFavorite,
        ),
        IconButton(
          icon: const Icon(Icons.format_list_bulleted_rounded, size: 22),
          color: const Color(0xFF0F172A),
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
        const SizedBox(width: 4),
      ],
    );
  }
}
