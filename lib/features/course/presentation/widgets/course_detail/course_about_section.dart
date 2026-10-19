import 'package:flutter/material.dart';
import 'package:rental_car/features/course/domain/entities/course_entity.dart';

class CourseAboutSection extends StatelessWidget {
  const CourseAboutSection({super.key, required this.course});

  final CourseEntity course;

  @override
  Widget build(BuildContext context) {
    final description =
        (course.description != null && course.description!.trim().isNotEmpty)
        ? course.description!
        : 'Khóa học được thiết kế bám sát chương trình giảng dạy của Đại học FPT, cung cấp hệ thống bài học chi tiết, tài liệu slide và bài tập trắc nghiệm giúp sinh viên tự tin nắm vững kiến thức.';

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFF1F5F9)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF3D5AFE).withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          const Row(
            children: [
              Icon(
                Icons.info_outline_rounded,
                size: 18,
                color: Color(0xFF3D5AFE),
              ),
              SizedBox(width: 8),
              Text(
                'Giới thiệu môn học',
                style: TextStyle(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF0F172A),
                  letterSpacing: -0.2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Description Paragraph from DB
          Text(
            description,
            style: const TextStyle(
              fontSize: 13,
              height: 1.55,
              color: Color(0xFF475569),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),

          // Highlights Grid (Coursera Style with real metrics)
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _buildHighlightItem(
                    icon: Icons.category_rounded,
                    label: 'Thể loại',
                    value: course.categoryName ?? 'Môn học',
                    color: const Color(0xFF059669),
                  ),
                ),
                Container(width: 1, height: 36, color: const Color(0xFFE2E8F0)),
                Expanded(
                  child: _buildHighlightItem(
                    icon: Icons.menu_book_rounded,
                    label: 'Nội dung',
                    value: '${course.totalLessons} bài học',
                    color: const Color(0xFF2563EB),
                  ),
                ),
                Container(width: 1, height: 36, color: const Color(0xFFE2E8F0)),
                Expanded(
                  child: _buildHighlightItem(
                    icon: Icons.signal_cellular_alt_rounded,
                    label: 'Trình độ',
                    value: course.difficultyName ?? course.difficulty,
                    color: const Color(0xFFD97706),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHighlightItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Icon(icon, size: 18, color: color),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: Color(0xFF94A3B8),
          ),
        ),
        const SizedBox(height: 1),
        Text(
          value,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w800,
            color: Color(0xFF0F172A),
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
