import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/features/course/domain/entities/lesson_entity.dart';

/// Lưới 2x2 Bento Grid thông số bài thi trắc nghiệm ApSkil
class LessonAssessmentSpecGrid extends StatelessWidget {
  const LessonAssessmentSpecGrid({super.key, required this.lesson});

  final LessonEntity lesson;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildBentoSpecCard(
                icon: Icons.assignment_outlined,
                iconBg: const Color(0xFFEFF6FF),
                iconColor: AppColors.primary,
                label: 'Hình thức thi',
                value: 'Trắc nghiệm',
                subText: '1 hoặc nhiều đáp án',
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _buildBentoSpecCard(
                icon: Icons.timer_outlined,
                iconBg: const Color(0xFFFEF3C7),
                iconColor: const Color(0xFFD97706),
                label: 'Thời lượng',
                value: '${lesson.estimatedMinutes} phút',
                subText: 'Ước tính hoàn thành',
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: _buildBentoSpecCard(
                icon: Icons.verified_outlined,
                iconBg: const Color(0xFFECFDF5),
                iconColor: const Color(0xFF059669),
                label: 'Chuẩn đầu ra',
                value: '80% Đạt',
                subText: '8.0/10 điểm trở lên',
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _buildBentoSpecCard(
                icon: Icons.replay_rounded,
                iconBg: const Color(0xFFF3E8FF),
                iconColor: const Color(0xFF9333EA),
                label: 'Số lần làm lại',
                value: 'Không giới hạn',
                subText: 'Tự do luyện tập',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBentoSpecCard({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String label,
    required String value,
    required String subText,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(child: Icon(icon, size: 15, color: iconColor)),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF64748B),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: Color(0xFF0F172A),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            subText,
            style: const TextStyle(
              fontSize: 10,
              color: Color(0xFF94A3B8),
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
