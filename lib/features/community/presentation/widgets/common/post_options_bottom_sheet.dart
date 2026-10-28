import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/core/theme/app_spacing.dart';
import 'package:rental_car/core/theme/app_text_styles.dart';

/// Bottom sheet tùy chọn cho bài viết (3 chấm), đồng bộ theo theme NextUnity
class PostOptionsBottomSheet extends StatelessWidget {
  const PostOptionsBottomSheet({
    super.key,
    required this.canDelete,
    required this.onCopyLink,
    this.onDelete,
  });

  final bool canDelete;
  final VoidCallback onCopyLink;
  final VoidCallback? onDelete;

  static Future<void> show(
    BuildContext context, {
    required bool canDelete,
    required VoidCallback onCopyLink,
    VoidCallback? onDelete,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
      ),
      builder: (ctx) => PostOptionsBottomSheet(
        canDelete: canDelete,
        onCopyLink: () {
          Navigator.pop(ctx);
          onCopyLink();
        },
        onDelete: onDelete != null
            ? () {
                Navigator.pop(ctx);
                onDelete();
              }
            : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                ),
              ),
            ),
            const Text(
              'Tùy chọn bài viết',
              style: AppTextStyles.heading3,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xs),
            const Text(
              'Quản lý và tương tác với bài viết',
              style: AppTextStyles.caption,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.md),
            _OptionTile(
              icon: Icons.link_rounded,
              iconColor: AppColors.textPrimary,
              iconBgColor: AppColors.surfaceSubtle,
              title: 'Sao chép liên kết',
              subtitle: 'Sao chép đường dẫn bài viết để chia sẻ',
              onTap: onCopyLink,
            ),
            if (canDelete && onDelete != null)
              _OptionTile(
                icon: Icons.delete_outline_rounded,
                iconColor: AppColors.textPrimary,
                iconBgColor: AppColors.surfaceSubtle,
                title: 'Xóa bài viết',
                subtitle: 'Gỡ bài viết này khỏi cộng đồng',
                isDestructive: true,
                onTap: onDelete!,
              ),
          ],
        ),
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  const _OptionTile({
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.isDestructive = false,
  });

  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(AppRadius.md),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppRadius.md),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm + 2,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(
                color: isDestructive
                    ? AppColors.error.withValues(alpha: 0.3)
                    : AppColors.border,
              ),
              color: isDestructive
                  ? AppColors.error.withValues(alpha: 0.04)
                  : AppColors.surface,
            ),
            child: Row(
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: iconBgColor,
                    borderRadius: BorderRadius.circular(AppRadius.sm + 2),
                  ),
                  child: Icon(icon, color: iconColor, size: 20),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isDestructive
                              ? AppColors.error
                              : AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 11.5,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  size: 20,
                  color: isDestructive
                      ? AppColors.error.withValues(alpha: 0.6)
                      : AppColors.textMuted,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
