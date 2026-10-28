import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/features/course/presentation/widgets/courses_tab/course_filter_dropdown_field.dart';
import 'package:rental_car/features/course/presentation/widgets/courses_tab/course_filter_modal_header.dart';

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
          CourseFilterModalHeader(
            onReset: _reset,
            onClose: () => Navigator.pop(context),
          ),
          const Divider(height: 1, thickness: 1, color: AppColors.surfaceSubtle),

          // Content Dropdowns
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Dropdown 1: Category
                CourseFilterDropdownField(
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
                CourseFilterDropdownField(
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

          const Divider(height: 1, thickness: 1, color: AppColors.surfaceSubtle),

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
}
