import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';

class CoursesActiveFiltersBar extends StatelessWidget {
  const CoursesActiveFiltersBar({
    super.key,
    required this.categories,
    required this.difficulties,
    this.selectedCategory,
    this.selectedDifficulty,
    required this.onClearCategory,
    required this.onClearDifficulty,
    required this.onResetAll,
  });

  final Map<String, String> categories;
  final Map<String, String> difficulties;
  final String? selectedCategory;
  final String? selectedDifficulty;
  final VoidCallback onClearCategory;
  final VoidCallback onClearDifficulty;
  final VoidCallback onResetAll;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          const Text(
            'Đang lọc: ',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: Color(0xFF64748B),
            ),
          ),
          if (selectedCategory != null) ...[
            _ActiveFilterChip(
              label: categories[selectedCategory] ?? selectedCategory!,
              onDelete: onClearCategory,
            ),
            const SizedBox(width: 6),
          ],
          if (selectedDifficulty != null) ...[
            _ActiveFilterChip(
              label: difficulties[selectedDifficulty] ?? selectedDifficulty!,
              onDelete: onClearDifficulty,
            ),
            const SizedBox(width: 6),
          ],
          InkWell(
            onTap: onResetAll,
            borderRadius: BorderRadius.circular(8),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              child: Text(
                'Xóa tất cả',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFFEF4444),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActiveFilterChip extends StatelessWidget {
  const _ActiveFilterChip({required this.label, required this.onDelete});

  final String label;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 4, 6, 4),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.25)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: 4),
          InkWell(
            onTap: onDelete,
            borderRadius: BorderRadius.circular(10),
            child: const Padding(
              padding: EdgeInsets.all(2),
              child: Icon(
                Icons.close_rounded,
                size: 13,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
