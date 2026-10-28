import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/core/theme/app_spacing.dart';
import 'package:rental_car/core/widgets/widgets.dart';

/// Thanh thông báo khi người dùng đang áp dụng bộ lọc bài viết theo môn học
class CommunityActiveFilterBanner extends StatelessWidget {
  const CommunityActiveFilterBanner({
    super.key,
    required this.selectedTag,
    required this.onClearFilter,
  });

  final String selectedTag;
  final VoidCallback onClearFilter;

  @override
  Widget build(BuildContext context) {
    if (selectedTag == 'Tất cả') return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppRadius.sm),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.filter_alt_rounded,
              size: 16,
              color: AppColors.primary,
            ),
            const Gap.h(6),
            const Text(
              'Đang lọc theo: ',
              style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.primary.withAlpha(20),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                selectedTag,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: onClearFilter,
              borderRadius: BorderRadius.circular(12),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                child: Row(
                  children: [
                    Text(
                      'Xóa lọc',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.error,
                      ),
                    ),
                    Gap.h(2),
                    Icon(
                      Icons.close_rounded,
                      size: 14,
                      color: AppColors.error,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
