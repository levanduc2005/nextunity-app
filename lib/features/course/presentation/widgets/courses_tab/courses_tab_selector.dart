import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';

class CoursesTabSelector extends StatelessWidget {
  const CoursesTabSelector({
    super.key,
    required this.activeTab,
    required this.enrolledCount,
    required this.onTabChanged,
  });

  final int activeTab;
  final int enrolledCount;
  final ValueChanged<int> onTabChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFDBEAFE).withValues(alpha: 0.65),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFBFDBFE).withValues(alpha: 0.6),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildSegment(
              title: 'Khóa học của tôi ($enrolledCount)',
              isActive: activeTab == 0,
              onTap: () => onTabChanged(0),
            ),
          ),
          Expanded(
            child: _buildSegment(
              title: 'Khám phá tất cả',
              isActive: activeTab == 1,
              onTap: () => onTabChanged(1),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSegment({
    required String title,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: const Color(0xFF1E3A8A).withValues(alpha: 0.08),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isActive ? FontWeight.w800 : FontWeight.w600,
              color: isActive ? AppColors.primary : const Color(0xFF64748B),
            ),
          ),
        ),
      ),
    );
  }
}
