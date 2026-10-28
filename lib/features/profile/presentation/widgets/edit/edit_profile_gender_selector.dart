import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';

class GenderOptionItem {
  const GenderOptionItem({
    required this.code,
    required this.label,
    required this.icon,
  });

  final String code;
  final String label;
  final IconData icon;
}

/// Bộ chọn giới tính (Nam / Nữ / Khác) thiết kế dạng thẻ bo tròn
class EditProfileGenderSelector extends StatelessWidget {
  const EditProfileGenderSelector({
    super.key,
    required this.selectedGender,
    required this.onChanged,
    this.options = defaultOptions,
  });

  final String? selectedGender;
  final ValueChanged<String> onChanged;
  final List<GenderOptionItem> options;

  static const List<GenderOptionItem> defaultOptions = [
    GenderOptionItem(code: 'MALE', label: 'Nam', icon: Icons.male_rounded),
    GenderOptionItem(code: 'FEMALE', label: 'Nữ', icon: Icons.female_rounded),
    GenderOptionItem(
      code: 'OTHER',
      label: 'Khác',
      icon: Icons.transgender_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Giới tính',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            for (var i = 0; i < options.length; i++) ...[
              if (i > 0) const SizedBox(width: 8),
              _GenderOption(
                label: options[i].label,
                icon: options[i].icon,
                isSelected: selectedGender?.toUpperCase() == options[i].code,
                onTap: () => onChanged(options[i].code),
              ),
            ],
          ],
        ),
      ],
    );
  }
}

class _GenderOption extends StatelessWidget {
  const _GenderOption({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primaryContainer : AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? AppColors.primary : AppColors.border,
              width: isSelected ? 1.6 : 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 16,
                color: isSelected ? AppColors.primary : AppColors.textSecondary,
              ),
              const SizedBox(width: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                  color: isSelected
                      ? AppColors.primaryForeground
                      : AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
