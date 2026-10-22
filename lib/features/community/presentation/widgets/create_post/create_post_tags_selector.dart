import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/core/widgets/widgets.dart';

/// Phần hiển thị và chọn các thẻ hashtag môn học
class CreatePostTagsSelector extends StatelessWidget {
  const CreatePostTagsSelector({
    super.key,
    required this.selectedTags,
    this.suggestedTags = const [],
    required this.onAddTag,
    required this.onRemoveTag,
    required this.onOpenAddDialog,
  });

  final List<String> selectedTags;
  final List<String> suggestedTags;
  final ValueChanged<String> onAddTag;
  final ValueChanged<String> onRemoveTag;
  final VoidCallback onOpenAddDialog;

  static const List<String> kDefaultTags = [
    'PRN211',
    'SWP391',
    'PRO192',
    'PE',
    'EXE201',
    'PRM392',
    'FER202',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'THẺ MÔN HỌC GỢI Ý:',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: Color(0xFF94A3B8),
            letterSpacing: 0.5,
          ),
        ),
        const Gap(8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            // Các tag đã chọn
            ...selectedTags.map(
              (tag) => Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primaryContainer,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.primary.withAlpha(50)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '#$tag',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                    const Gap.h(4),
                    InkWell(
                      onTap: () => onRemoveTag(tag),
                      child: const Icon(
                        Icons.close_rounded,
                        size: 14,
                        color: Color(0xFFEF4444),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Các tag gợi ý phổ biến
            ...(suggestedTags.isNotEmpty ? suggestedTags : kDefaultTags)
                .where((t) => !selectedTags.contains(t))
                .map(
                  (t) => InkWell(
                    onTap: () => onAddTag(t),
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '#$t',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF475569),
                        ),
                      ),
                    ),
                  ),
                ),

            // Nút Thêm thẻ tự do
            InkWell(
              onTap: onOpenAddDialog,
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.add_rounded, size: 14, color: Color(0xFF475569)),
                    Gap.h(2),
                    Text(
                      'Thêm thẻ',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF475569),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
