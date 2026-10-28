import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';

/// Ô chọn Dropdown tùy biến có nhãn tiêu đề và icon cho bộ lọc khóa học
class CourseFilterDropdownField extends StatelessWidget {
  const CourseFilterDropdownField({
    super.key,
    required this.label,
    required this.prefixIcon,
    required this.value,
    required this.defaultLabel,
    required this.options,
    required this.onChanged,
  });

  final String label;
  final IconData prefixIcon;
  final String? value;
  final String defaultLabel;
  final Map<String, String> options;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    final validValue = options.containsKey(value) ? value : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w800,
            color: AppColors.textMuted,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 8),
        InputDecorator(
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 4,
            ),
            filled: true,
            fillColor: AppColors.surfaceLight,
            prefixIcon: Icon(
              prefixIcon,
              size: 20,
              color: validValue != null
                  ? AppColors.primary
                  : AppColors.textMuted,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: validValue != null
                    ? AppColors.primary.withValues(alpha: 0.5)
                    : AppColors.border,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(
                color: AppColors.primary,
                width: 1.5,
              ),
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String?>(
              value: validValue,
              isExpanded: true,
              menuMaxHeight: 320,
              dropdownColor: Colors.white,
              borderRadius: BorderRadius.circular(16),
              icon: const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: AppColors.textSecondary,
              ),
              style: const TextStyle(
                fontSize: 13.5,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
              items: [
                DropdownMenuItem<String?>(
                  child: Text(
                    defaultLabel,
                    style: const TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
                ...options.entries.map((entry) {
                  final isSelected = entry.key == validValue;
                  return DropdownMenuItem<String?>(
                    value: entry.key,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            entry.value,
                            style: TextStyle(
                              fontSize: 13.5,
                              fontWeight: isSelected
                                  ? FontWeight.w700
                                  : FontWeight.w600,
                              color: isSelected
                                  ? AppColors.primary
                                  : AppColors.textPrimary,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (isSelected)
                          const Icon(
                            Icons.check_rounded,
                            size: 18,
                            color: AppColors.primary,
                          ),
                      ],
                    ),
                  );
                }),
              ],
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
