import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';

class CourseFilterModal extends StatefulWidget {
  const CourseFilterModal({
    super.key,
    required this.categories,
    required this.difficulties,
    required this.selectedCategory,
    required this.selectedDifficulty,
    required this.onApply,
  });

  final Map<String, String> categories;
  final Map<String, String> difficulties;
  final String? selectedCategory;
  final String? selectedDifficulty;
  final void Function(String? category, String? difficulty) onApply;

  static Future<void> show({
    required BuildContext context,
    required Map<String, String> categories,
    required Map<String, String> difficulties,
    required String? selectedCategory,
    required String? selectedDifficulty,
    required void Function(String? category, String? difficulty) onApply,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => CourseFilterModal(
        categories: categories,
        difficulties: difficulties,
        selectedCategory: selectedCategory,
        selectedDifficulty: selectedDifficulty,
        onApply: onApply,
      ),
    );
  }

  @override
  State<CourseFilterModal> createState() => _CourseFilterModalState();
}

class _CourseFilterModalState extends State<CourseFilterModal> {
  String? _tempCategory;
  String? _tempDifficulty;

  @override
  void initState() {
    super.initState();
    _tempCategory = widget.selectedCategory;
    _tempDifficulty = widget.selectedDifficulty;
  }

  void _reset() {
    setState(() {
      _tempCategory = null;
      _tempDifficulty = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Padding(
      padding: EdgeInsets.only(bottom: mediaQuery.viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Drag Handle
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 10, bottom: 8),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFCBD5E1),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          // Header Row
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 4, 16, 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Icon(
                      Icons.tune_rounded,
                      size: 20,
                      color: AppColors.primary,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Bộ lọc tìm kiếm',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: _reset,
                      style: TextButton.styleFrom(
                        foregroundColor: const Color(0xFF64748B),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Text(
                        'Đặt lại',
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.close_rounded,
                        size: 20,
                        color: Color(0xFF64748B),
                      ),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(
                        minWidth: 32,
                        minHeight: 32,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const Divider(height: 1, thickness: 1, color: Color(0xFFF1F5F9)),

          // Content Dropdowns
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Dropdown 1: Category
                _buildDropdownField(
                  label: 'DANH MỤC KHÓA HỌC',
                  prefixIcon: Icons.folder_outlined,
                  value: _tempCategory,
                  defaultLabel: 'Tất cả danh mục',
                  options: widget.categories,
                  onChanged: (val) {
                    setState(() => _tempCategory = val);
                  },
                ),

                const SizedBox(height: 16),

                // Dropdown 2: Difficulty
                _buildDropdownField(
                  label: 'ĐỘ KHÓ',
                  prefixIcon: Icons.bar_chart_rounded,
                  value: _tempDifficulty,
                  defaultLabel: 'Tất cả độ khó',
                  options: widget.difficulties,
                  onChanged: (val) {
                    setState(() => _tempDifficulty = val);
                  },
                ),
              ],
            ),
          ),

          const Divider(height: 1, thickness: 1, color: Color(0xFFF1F5F9)),

          // Apply Button Footer
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
            child: SafeArea(
              top: false,
              child: ElevatedButton(
                onPressed: () {
                  widget.onApply(_tempCategory, _tempDifficulty);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 2,
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check_rounded, size: 18),
                    SizedBox(width: 6),
                    Text(
                      'Áp dụng bộ lọc',
                      style: TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownField({
    required String label,
    required IconData prefixIcon,
    required String? value,
    required String defaultLabel,
    required Map<String, String> options,
    required ValueChanged<String?> onChanged,
  }) {
    final validValue = options.containsKey(value) ? value : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w800,
            color: Color(0xFF94A3B8),
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
            fillColor: const Color(0xFFF8FAFC),
            prefixIcon: Icon(
              prefixIcon,
              size: 20,
              color: validValue != null
                  ? AppColors.primary
                  : const Color(0xFF94A3B8),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: validValue != null
                    ? AppColors.primary.withValues(alpha: 0.5)
                    : const Color(0xFFE2E8F0),
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
                color: Color(0xFF64748B),
              ),
              style: const TextStyle(
                fontSize: 13.5,
                fontWeight: FontWeight.w600,
                color: Color(0xFF0F172A),
              ),
              items: [
                DropdownMenuItem<String?>(
                  child: Text(
                    defaultLabel,
                    style: const TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF64748B),
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
                                  : const Color(0xFF0F172A),
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
