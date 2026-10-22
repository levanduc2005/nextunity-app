import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/features/course/domain/entities/course_entity.dart';
import 'package:rental_car/features/course/domain/entities/lesson_entity.dart';

class CourseEnrollPromptSheet extends StatelessWidget {
  const CourseEnrollPromptSheet({
    super.key,
    required this.course,
    required this.lesson,
    required this.isUserPlus,
    required this.onEnroll,
    required this.onUpgradePlus,
  });

  final CourseEntity course;
  final LessonEntity lesson;
  final bool isUserPlus;
  final VoidCallback onEnroll;
  final VoidCallback onUpgradePlus;

  static void show({
    required BuildContext context,
    required CourseEntity course,
    required LessonEntity lesson,
    required bool isUserPlus,
    required VoidCallback onEnroll,
    required VoidCallback onUpgradePlus,
  }) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => CourseEnrollPromptSheet(
        course: course,
        lesson: lesson,
        isUserPlus: isUserPlus,
        onEnroll: () {
          Navigator.pop(ctx);
          onEnroll();
        },
        onUpgradePlus: () {
          Navigator.pop(ctx);
          onUpgradePlus();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLockedPlus = course.isPremium && !isUserPlus;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFCBD5E1),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: course.isPremium
                      ? const Color(0xFFFEF3C7)
                      : AppColors.primaryContainer,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                  child: Icon(
                    course.isPremium
                        ? Icons.workspace_premium_rounded
                        : Icons.school_rounded,
                    color: course.isPremium
                        ? const Color(0xFFD97706)
                        : AppColors.primary,
                    size: 24,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lesson.title,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF0F172A),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Khóa học: ${course.title}',
                      style: const TextStyle(
                        fontSize: 11.5,
                        color: Color(0xFF64748B),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            isLockedPlus
                ? 'Đây là khóa học chuyên sâu dành riêng cho thành viên NextUnity Plus. Vui lòng nâng cấp tài khoản để truy cập toàn bộ tài liệu & bài giảng.'
                : 'Bạn cần đăng ký khóa học này để bắt đầu học bài học, làm quiz và lưu tiến độ cá nhân.',
            style: const TextStyle(
              fontSize: 12.5,
              height: 1.5,
              color: Color(0xFF475569),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: isLockedPlus ? onUpgradePlus : onEnroll,
            style: ElevatedButton.styleFrom(
              backgroundColor: isLockedPlus
                  ? const Color(0xFFD97706)
                  : AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isLockedPlus) ...[
                  const Icon(Icons.workspace_premium_rounded, size: 16),
                  const SizedBox(width: 6),
                ],
                Text(
                  isLockedPlus
                      ? 'Nâng cấp Plus để học'
                      : 'Đăng ký học ngay (${course.isPremium ? 'Quyền lợi Plus' : 'Miễn phí'})',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
