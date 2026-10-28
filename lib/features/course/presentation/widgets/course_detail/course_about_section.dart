import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/features/course/domain/entities/course_entity.dart';

/// Mục Giới thiệu môn học chuẩn phong cách ApSkil
/// - Hiển thị mô tả thực tế của môn học
/// - Thông số môn học thực tế từ NextUnity (Mã môn, Chuyên ngành, Cấp độ, Số chương & Bài học)
/// - Thông tin Giảng viên / Người biên soạn thực tế nếu có (không mock)
class CourseAboutSection extends StatelessWidget {
  const CourseAboutSection({super.key, required this.course});

  final CourseEntity course;

  @override
  Widget build(BuildContext context) {
    final hasCustomDescription =
        course.description != null && course.description!.trim().isNotEmpty;
    final description = hasCustomDescription
        ? course.description!
        : 'Môn học ${course.code.isNotEmpty ? course.code : "FPT"} thuộc chương trình đào tạo Đại học FPT, cung cấp hệ thống bài giảng và tài liệu học tập bám sát giáo trình chuyên ngành.';

    final hasCreator =
        course.creatorName != null && course.creatorName!.trim().isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Tiêu đề mục "Giới thiệu môn học" & Nội dung mô tả
        const Text(
          'Giới thiệu môn học',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w900,
            color: AppColors.textPrimary,
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 8),

        Text(
          description,
          style: const TextStyle(
            fontSize: 13,
            height: 1.6,
            color: AppColors.textSecondaryDark,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 16),

        // 2. Thẻ tóm tắt thông số môn học thực tế chuẩn ApSkil
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.surfaceLight,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            children: [
              _buildInfoRow(
                icon: Icons.code_rounded,
                label: 'Mã môn học',
                value: course.code.isNotEmpty ? course.code : 'Chưa cập nhật',
              ),
              const Divider(
                height: 16,
                thickness: 0.8,
                color: AppColors.border,
              ),
              _buildInfoRow(
                icon: Icons.category_outlined,
                label: 'Chuyên ngành',
                value: course.categoryName ?? course.category ?? 'Đại học FPT',
              ),
              const Divider(
                height: 16,
                thickness: 0.8,
                color: AppColors.border,
              ),
              _buildInfoRow(
                icon: Icons.signal_cellular_alt_rounded,
                label: 'Cấp độ',
                value:
                    course.difficultyName ??
                    (course.difficulty == 'ADVANCED'
                        ? 'Nâng cao'
                        : (course.difficulty == 'INTERMEDIATE'
                              ? 'Trung cấp'
                              : 'Cơ bản')),
              ),
              const Divider(
                height: 16,
                thickness: 0.8,
                color: AppColors.border,
              ),
              _buildInfoRow(
                icon: Icons.auto_stories_outlined,
                label: 'Cấu trúc',
                value:
                    '${course.totalModules} chương • ${course.totalLessons} bài học',
              ),
            ],
          ),
        ),

        // 3. Thẻ Giảng viên / Người biên soạn nếu có
        if (hasCreator) ...[
          const SizedBox(height: 20),
          const Text(
            'Giảng viên phụ trách',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 10),

          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.border),
              boxShadow: [
                BoxShadow(
                  color: AppColors.textPrimary.withValues(alpha: 0.03),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryContainer,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      course.creatorName!
                          .trim()
                          .split(' ')
                          .last
                          .substring(0, 1),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              course.creatorName!,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                color: AppColors.textPrimary,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Icon(
                            Icons.verified_rounded,
                            size: 14,
                            color: AppColors.primary,
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        'Người biên soạn • Giảng viên Đại học FPT',
                        style: TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textSecondary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.textSecondary),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: AppColors.textSecondary,
          ),
        ),
        const Spacer(),
        Flexible(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
            textAlign: TextAlign.end,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
