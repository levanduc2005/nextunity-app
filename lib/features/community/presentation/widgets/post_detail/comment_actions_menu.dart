import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/core/widgets/widgets.dart';

/// Menu các tùy chọn thao tác với bình luận (Sao chép, Trả lời, Báo cáo, Xóa)
class CommentActionsMenu extends StatelessWidget {
  const CommentActionsMenu({
    super.key,
    required this.width,
    required this.commentContent,
    required this.onReply,
    required this.onReport,
    required this.canDelete,
    this.onDelete,
  });

  final double width;
  final String commentContent;
  final VoidCallback onReply;
  final VoidCallback onReport;
  final bool canDelete;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(40),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
        border: Border.all(color: AppColors.border),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _PopupOptionRow(
              icon: Icons.copy_rounded,
              title: 'Sao chép',
              onTap: () {
                Clipboard.setData(ClipboardData(text: commentContent));
                Navigator.of(context).pop();
                context.showSnackBar('Đã sao chép nội dung bình luận');
              },
            ),
            const Divider(height: 1, thickness: 1, color: AppColors.surfaceSubtle),
            _PopupOptionRow(
              icon: Icons.reply_rounded,
              title: 'Trả lời',
              onTap: () {
                Navigator.of(context).pop();
                onReply();
              },
            ),
            const Divider(height: 1, thickness: 1, color: AppColors.surfaceSubtle),
            _PopupOptionRow(
              icon: Icons.flag_outlined,
              title: 'Báo cáo',
              onTap: () {
                Navigator.of(context).pop();
                onReport();
              },
            ),
            if (canDelete && onDelete != null) ...[
              const Divider(height: 1, thickness: 1, color: AppColors.surfaceSubtle),
              _PopupOptionRow(
                icon: Icons.delete_outline_rounded,
                title: 'Xóa bình luận',
                isDestructive: true,
                onTap: () {
                  Navigator.of(context).pop();
                  onDelete!();
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _PopupOptionRow extends StatelessWidget {
  const _PopupOptionRow({
    required this.icon,
    required this.title,
    required this.onTap,
    this.isDestructive = false,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    final color = isDestructive ? AppColors.error : AppColors.textPrimary;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
        child: Row(
          children: [
            Icon(icon, size: 18, color: color),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
