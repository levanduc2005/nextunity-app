import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/core/widgets/widgets.dart';

/// Modal Bottom Sheet lọc bài viết theo hashtag môn học FPTU
class CommunityFilterModal {
  static const List<String> kDefaultTags = [
    'PRN211',
    'SWP391',
    'PRO192',
    'PE',
    'EXE201',
    'PRM392',
    'FER202',
  ];

  static void show({
    required BuildContext context,
    required String selectedTag,
    List<String> tags = const [],
    required ValueChanged<String> onTagSelected,
  }) {
    final rawTags = tags.isNotEmpty ? tags : kDefaultTags;
    final availableTags = [
      'Tất cả',
      ...rawTags.map((t) => t.startsWith('#') ? t : '#$t'),
    ];

    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const Gap(16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Lọc bài viết theo môn học',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  if (selectedTag != 'Tất cả')
                    TextButton(
                      onPressed: () {
                        onTagSelected('Tất cả');
                        Navigator.pop(ctx);
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(50, 30),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Text(
                        'Đặt lại',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                ],
              ),
              const Gap(4),
              const Text(
                'Chọn hashtag môn học từ hệ thống để xem các bài thảo luận liên quan',
                style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
              ),
              const Gap(16),
              Wrap(
                spacing: 8,
                runSpacing: 10,
                children: availableTags.map((tag) {
                  final isSelected = tag == selectedTag;
                  return InkWell(
                    onTap: () {
                      onTagSelected(tag);
                      Navigator.pop(ctx);
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.surfaceSubtle,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.border,
                        ),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: AppColors.primary.withAlpha(50),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ]
                            : null,
                      ),
                      child: Text(
                        tag,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: isSelected
                              ? FontWeight.w700
                              : FontWeight.w600,
                          color: isSelected
                              ? Colors.white
                              : AppColors.textLabel,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const Gap(8),
            ],
          ),
        ),
      ),
    );
  }
}
