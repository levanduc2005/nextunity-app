import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';

class CourseCategoryChips extends StatelessWidget {
  const CourseCategoryChips({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onSelectCategory,
  });

  final Map<String, String> categories;
  final String? selectedCategory;
  final ValueChanged<String?> onSelectCategory;

  @override
  Widget build(BuildContext context) {
    // "Tất cả" luôn là chip đầu tiên với code rỗng (tương ứng null)
    final allItems = [
      (code: '', label: 'Tất cả'),
      ...categories.entries.map((e) => (code: e.key, label: e.value)),
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: allItems.map((item) {
          final isAll = item.code.isEmpty;
          final isSelected = isAll
              ? (selectedCategory == null || selectedCategory!.isEmpty)
              : (selectedCategory == item.code);

          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: InkWell(
              onTap: () => onSelectCategory(isAll ? null : item.code),
              borderRadius: BorderRadius.circular(20),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primary
                        : const Color(0xFFE2E8F0),
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.25),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                child: Text(
                  item.label,
                  style: TextStyle(
                    fontSize: 11.5,
                    fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                    color: isSelected ? Colors.white : const Color(0xFF475569),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
