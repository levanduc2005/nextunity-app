import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_car/features/course/domain/entities/course_entity.dart';
import 'package:rental_car/features/course/presentation/widgets/course_detail/course_hero_enrolled_progress.dart';
import 'package:rental_car/features/course/presentation/widgets/course_detail/course_hero_meta_section.dart';
import 'package:rental_car/features/course/presentation/widgets/course_detail/course_hero_tip_banner.dart';
import 'package:rental_car/features/course/presentation/widgets/course_detail/course_hero_video_preview.dart';

import 'package:rental_car/core/theme/app_colors.dart';
/// Header chi tiết khóa học chuẩn ApSkil (Detail Kelas)
/// Thiết kế thanh lịch, thoáng đãng:
/// - Nút Back tròn tinh gọn
/// - Khung Video trailer xem trước 16:9 với nút Play trung tâm chuẩn ApSkil
/// - Thông tin khóa học liền mạch (Title, Phân loại, Giảng viên, Thống kê)
/// - Tiến độ học tập (khi đã ghi danh) và Banner mẹo học tập
class CourseDetailHeroHeader extends StatelessWidget {
  const CourseDetailHeroHeader({
    super.key,
    required this.course,
    this.completedCount = 0,
    this.totalLessons = 0,
    this.onPlayTrailer,
  });

  final CourseEntity course;
  final int completedCount;
  final int totalLessons;
  final VoidCallback? onPlayTrailer;

  @override
  Widget build(BuildContext context) {
    final effectiveTotal = totalLessons > 0
        ? totalLessons
        : course.totalLessons;
    final progressFraction = effectiveTotal > 0
        ? (completedCount / effectiveTotal).clamp(0.0, 1.0)
        : course.progress.clamp(0.0, 1.0);
    final progressPercent = (progressFraction * 100).round();

    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. Nút quay lại tròn tinh gọn
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  onTap: () => context.pop(),
                  borderRadius: BorderRadius.circular(22),
                  child: Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.border),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(
                            0xFF0F172A,
                          ).withValues(alpha: 0.04),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: AppColors.textPrimary,
                        size: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // 2. Hero Video Preview Card (16:9 Aspect Ratio chuẩn ApSkil)
          CourseHeroVideoPreview(
            course: course,
            effectiveTotal: effectiveTotal,
            onPlayTrailer: onPlayTrailer,
          ),
          const SizedBox(height: 14),

          // 3. Thông tin môn học thoáng đãng liền mạch (Course Meta)
          CourseHeroMetaSection(course: course, totalLessons: totalLessons),

          // 4. Nếu sinh viên đã đăng ký: Hiển thị thanh tiến độ học tập chuẩn ApSkil 'Kelas Berlangsung'
          if (course.isEnrolled) ...[
            const SizedBox(height: 12),
            CourseHeroEnrolledProgress(
              completedCount: completedCount,
              effectiveTotal: effectiveTotal,
              progressFraction: progressFraction,
              progressPercent: progressPercent,
            ),
          ],

          // 5. ApSkil Signature Tip Banner
          const SizedBox(height: 12),
          const CourseHeroTipBanner(),
        ],
      ),
    );
  }
}
