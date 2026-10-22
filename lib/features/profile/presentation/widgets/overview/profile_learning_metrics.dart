import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/features/course/presentation/providers/course_providers.dart';

/// Thẻ 3 chỉ số học tập chuẩn phong cách ApSkil E-Learning
/// (Khóa học đang học, Đã hoàn thành, Chứng chỉ đạt được)
class ProfileLearningMetrics extends ConsumerWidget {
  const ProfileLearningMetrics({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coursesState = ref.watch(coursesControllerProvider);
    final enrollments = coursesState.myEnrollments;

    final ongoingCount = enrollments.where((e) => !e.isCompleted).length;
    final completedCount = enrollments.where((e) => e.isCompleted).length;
    final certCount = completedCount;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0F172A).withValues(alpha: 0.04),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildMetricItem(
              icon: Icons.play_circle_filled_rounded,
              iconColor: AppColors.primary,
              iconBgColor: AppColors.primaryContainer,
              count: ongoingCount.toString(),
              label: 'Đang học',
            ),
          ),
          Container(
            height: 36,
            width: 1,
            color: const Color(0xFFF1F5F9),
          ),
          Expanded(
            child: _buildMetricItem(
              icon: Icons.task_alt_rounded,
              iconColor: const Color(0xFF059669),
              iconBgColor: const Color(0xFFD1FAE5),
              count: completedCount.toString(),
              label: 'Hoàn thành',
            ),
          ),
          Container(
            height: 36,
            width: 1,
            color: const Color(0xFFF1F5F9),
          ),
          Expanded(
            child: _buildMetricItem(
              icon: Icons.workspace_premium_rounded,
              iconColor: const Color(0xFFD97706),
              iconBgColor: const Color(0xFFFEF3C7),
              count: certCount.toString(),
              label: 'Chứng chỉ',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricItem({
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String count,
    required String label,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: iconBgColor,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Icon(icon, size: 18, color: iconColor),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          count,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w900,
            color: Color(0xFF0F172A),
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: Color(0xFF64748B),
          ),
        ),
      ],
    );
  }
}
