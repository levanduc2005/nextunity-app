import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/features/course/domain/entities/course_entity.dart';
import 'package:rental_car/features/course/domain/entities/module_entity.dart';

class CourseProgressCard extends StatelessWidget {
  const CourseProgressCard({
    super.key,
    required this.course,
    required this.isEnrolled,
    required this.isEnrolling,
    required this.onTapCta,
    this.modules = const [],
    this.isUserPlus = false,
    this.ctaTitle,
  });

  final CourseEntity course;
  final List<ModuleEntity> modules;
  final bool isEnrolled;
  final bool isEnrolling;
  final bool isUserPlus;
  final VoidCallback onTapCta;
  final String? ctaTitle;

  @override
  Widget build(BuildContext context) {
    final totalFromModules = modules.fold<int>(
      0,
      (sum, m) => sum + m.lessons.length,
    );
    final totalLessons = totalFromModules > 0
        ? totalFromModules
        : course.totalLessons;
    final completedCount = modules.isNotEmpty
        ? modules.fold<int>(0, (sum, m) => sum + m.completedLessonsCount)
        : (course.progress * totalLessons).round();
    final progressFraction = totalLessons > 0
        ? (completedCount / totalLessons).clamp(0.0, 1.0)
        : course.progress.clamp(0.0, 1.0);
    final progressPercent = (progressFraction * 100).round();
    final remainingCount = (totalLessons - completedCount).clamp(
      0,
      totalLessons,
    );
    final isCompleted =
        isEnrolled &&
        ((totalLessons > 0 && completedCount >= totalLessons) ||
            progressFraction >= 1.0);

    final String buttonLabel;
    if (isCompleted) {
      buttonLabel = ctaTitle ?? 'Ôn tập lại bài học';
    } else if (isEnrolled) {
      buttonLabel = ctaTitle ?? 'Tiếp tục học bài gần nhất';
    } else if (course.isPremium) {
      buttonLabel = isUserPlus
          ? 'Đăng ký học ngay (Quyền lợi Plus)'
          : 'Nâng cấp Plus để mở khóa';
    } else {
      buttonLabel = 'Đăng ký học ngay (Miễn phí)';
    }

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withValues(alpha: 0.08),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. Title & Code Header
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (course.code.isNotEmpty)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2.5,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFF6FF),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          course.code,
                          style: const TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            color: AppColors.primary,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    const SizedBox(height: 4),
                    Text(
                      course.title,
                      style: const TextStyle(
                        fontSize: 16.5,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF0F172A),
                        letterSpacing: -0.3,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              // Difficulty tag
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  (course.difficultyName ?? course.difficulty).toUpperCase(),
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF475569),
                    letterSpacing: 0.3,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // 2. Instructor Row
          Container(
            padding: const EdgeInsets.only(top: 10),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Color(0xFFF1F5F9))),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 34,
                      height: 34,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [Color(0xFF2563EB), Color(0xFF4F46E5)],
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'GV',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          course.creatorName ?? 'Ban Đào Tạo FPT',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                        const Text(
                          'Giảng viên phụ trách môn',
                          style: TextStyle(
                            fontSize: 10.5,
                            color: Color(0xFF64748B),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          // 3. Progress Section (If enrolled)
          if (isEnrolled) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.only(top: 10),
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: Color(0xFFF1F5F9))),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 7,
                            height: 7,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFF10B981),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            isCompleted
                                ? 'Đã hoàn thành khóa học'
                                : 'Tiến độ hoàn thành',
                            style: TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w700,
                              color: isCompleted
                                  ? const Color(0xFF059669)
                                  : const Color(0xFF334155),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        isCompleted ? '100%' : '$progressPercent%',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w900,
                          color: isCompleted
                              ? const Color(0xFF059669)
                              : AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  // Gradient progress bar
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      height: 8,
                      color: const Color(0xFFF1F5F9),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: isCompleted ? 1.0 : progressFraction,
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.primary,
                                Color(0xFF3B82F6),
                                Color(0xFF10B981),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '$completedCount/$totalLessons bài học đã học',
                        style: const TextStyle(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF64748B),
                        ),
                      ),
                      Text(
                        isCompleted ? 'Xuất sắc!' : 'Còn $remainingCount bài',
                        style: const TextStyle(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF059669),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],

          const SizedBox(height: 14),

          // 4. Primary Action Button
          InkWell(
            onTap: isEnrolling ? null : onTapCta,
            borderRadius: BorderRadius.circular(16),
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isCompleted
                      ? const [Color(0xFF059669), Color(0xFF10B981)]
                      : const [Color(0xFF3D5AFE), Color(0xFF2563EB)],
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color:
                        (isCompleted
                                ? const Color(0xFF059669)
                                : const Color(0xFF3D5AFE))
                            .withValues(alpha: 0.35),
                    blurRadius: 14,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: isEnrolling
                  ? const Center(
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          isCompleted
                              ? Icons.replay_rounded
                              : Icons.play_circle_rounded,
                          color: Colors.white,
                          size: 19,
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            buttonLabel,
                            style: const TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Icon(
                          isCompleted
                              ? Icons.arrow_forward_rounded
                              : Icons.arrow_forward_rounded,
                          color: Colors.white,
                          size: 16,
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
