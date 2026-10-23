import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/core/widgets/widgets.dart';
import 'package:rental_car/features/community/domain/entities/reaction_type.dart';
import 'package:rental_car/features/community/presentation/widgets/common/post_reaction_button.dart';

/// Popup nổi xuất hiện khi nhấn giữ (hold) vào một bình luận:
/// - Phía trên: Thanh chọn cảm xúc (👍 ❤️ 😆 😮 😢 😡)
/// - Ở giữa: Đoạn comment xem trước nổi bật trên nền mờ
/// - Phía dưới: Menu các tùy chọn (Sao chép, Trả lời, Báo cáo, Xóa)
class CommentOptionsPopup extends StatelessWidget {
  const CommentOptionsPopup({
    super.key,
    required this.commentContent,
    required this.authorName,
    required this.formattedTime,
    this.authorAvatar,
    this.authorInitials = '',
    this.authorBadge,
    this.currentReaction,
    required this.onReactionSelected,
    required this.onReactionCleared,
    required this.onReply,
    required this.canDelete,
    this.onDelete,
    required this.onReport,
    required this.bubbleRect,
  });

  final String commentContent;
  final String authorName;
  final String formattedTime;
  final String? authorAvatar;
  final String authorInitials;
  final String? authorBadge;
  final ReactionType? currentReaction;
  final ValueChanged<ReactionType> onReactionSelected;
  final VoidCallback onReactionCleared;
  final VoidCallback onReply;
  final bool canDelete;
  final VoidCallback? onDelete;
  final VoidCallback onReport;
  final Rect bubbleRect;

  static Future<void> show(
    BuildContext context, {
    required Rect bubbleRect,
    required String commentContent,
    required String authorName,
    required String formattedTime,
    String? authorAvatar,
    String authorInitials = '',
    String? authorBadge,
    ReactionType? currentReaction,
    required ValueChanged<ReactionType> onReactionSelected,
    required VoidCallback onReactionCleared,
    required VoidCallback onReply,
    required bool canDelete,
    VoidCallback? onDelete,
    required VoidCallback onReport,
  }) {
    HapticFeedback.mediumImpact();

    return showGeneralDialog<void>(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'DismissCommentPopup',
      barrierColor: Colors.black.withAlpha(80),
      pageBuilder: (dialogContext, animation, secondaryAnimation) {
        return CommentOptionsPopup(
          bubbleRect: bubbleRect,
          commentContent: commentContent,
          authorName: authorName,
          formattedTime: formattedTime,
          authorAvatar: authorAvatar,
          authorInitials: authorInitials,
          authorBadge: authorBadge,
          currentReaction: currentReaction,
          onReactionSelected: onReactionSelected,
          onReactionCleared: onReactionCleared,
          onReply: onReply,
          canDelete: canDelete,
          onDelete: onDelete,
          onReport: onReport,
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutBack,
          reverseCurve: Curves.easeIn,
        );

        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: Tween<double>(
              begin: 0.88,
              end: 1.0,
            ).animate(curvedAnimation),
            child: child,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;

    const double cardWidth = 296.0;
    const double reactionBarHeight = 52.0;
    const double optionsCardWidth = 220.0;
    final double optionsHeight = (canDelete && onDelete != null)
        ? 176.0
        : 132.0;

    // Ước lượng chiều cao tổng để tính toán toạ độ hiển thị cân đối
    final double totalEstimatedHeight =
        reactionBarHeight + 10.0 + 85.0 + 10.0 + optionsHeight;

    // Căn toạ độ top sao cho đoạn comment ở giữa tương ứng với vị trí bình luận
    double top = bubbleRect.center.dy - (reactionBarHeight + 10.0 + 40.0);

    // Giữ popup luôn nằm an toàn trong màn hình
    final minTop = padding.top + 16.0;
    final maxTop =
        screenSize.height - padding.bottom - totalEstimatedHeight - 16.0;
    top = top.clamp(minTop, maxTop > minTop ? maxTop : minTop);

    // Căn toạ độ left theo lề trái của bình luận hoặc lề an toàn
    double left = bubbleRect.left;
    const double margin = 16.0;
    final double maxLeft = screenSize.width - cardWidth - margin;
    left = left.clamp(margin, maxLeft > margin ? maxLeft : margin);

    return Stack(
      children: [
        // Lớp bắt tap ra ngoài để đóng popup
        Positioned.fill(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => Navigator.of(context).pop(),
            child: const SizedBox.expand(),
          ),
        ),

        // Cụm 3 phần: [1. Cảm xúc] -> [2. Đoạn comment] -> [3. Các options]
        Positioned(
          left: left,
          top: top,
          child: Material(
            color: Colors.transparent,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Phía trên: Thanh cảm xúc (Reactions Capsule)
                Container(
                  width: cardWidth,
                  height: reactionBarHeight,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(50),
                        blurRadius: 18,
                        offset: const Offset(0, 6),
                      ),
                    ],
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: ReactionType.values.map((reaction) {
                      final isSelected = currentReaction == reaction;
                      return InkWell(
                        onTap: () {
                          HapticFeedback.lightImpact();
                          Navigator.of(context).pop();
                          if (isSelected) {
                            onReactionCleared();
                          } else {
                            onReactionSelected(reaction);
                          }
                        },
                        borderRadius: BorderRadius.circular(20),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          width: 40,
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? reaction.color.withAlpha(35)
                                : Colors.transparent,
                            shape: BoxShape.circle,
                            border: isSelected
                                ? Border.all(color: reaction.color, width: 1.5)
                                : null,
                          ),
                          child: Text(
                            reaction.emoji,
                            style: const TextStyle(fontSize: 22),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),

                const SizedBox(height: 10),

                // 2. Ở giữa: Đoạn comment (Comment Preview Card)
                Container(
                  width: cardWidth,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(45),
                        blurRadius: 18,
                        offset: const Offset(0, 6),
                      ),
                    ],
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppAvatar(
                        name: authorName,
                        imageUrl: authorAvatar,
                        radius: 15,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Header: Tên người dùng + Giờ bên cạnh
                            Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Text(
                                  authorName,
                                  style: const TextStyle(
                                    fontSize: 12.5,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF0F172A),
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  formattedTime,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Color(0xFF94A3B8),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                if (authorBadge != null) ...[
                                  const SizedBox(width: 6),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 5,
                                      vertical: 1,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFE2E8F0),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      authorBadge!,
                                      style: const TextStyle(
                                        fontSize: 9.5,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xFF475569),
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                            const SizedBox(height: 4),
                            // Nội dung bình luận
                            Text(
                              commentContent,
                              maxLines: 6,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 13,
                                color: Color(0xFF1E293B),
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                // 3. Phía dưới: Menu các tùy chọn (Options Card)
                Container(
                  width: optionsCardWidth,
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
                            Clipboard.setData(
                              ClipboardData(text: commentContent),
                            );
                            Navigator.of(context).pop();
                            context.showSnackBar(
                              'Đã sao chép nội dung bình luận',
                            );
                          },
                        ),
                        const Divider(
                          height: 1,
                          thickness: 1,
                          color: Color(0xFFF1F5F9),
                        ),
                        _PopupOptionRow(
                          icon: Icons.reply_rounded,
                          title: 'Trả lời',
                          onTap: () {
                            Navigator.of(context).pop();
                            onReply();
                          },
                        ),
                        const Divider(
                          height: 1,
                          thickness: 1,
                          color: Color(0xFFF1F5F9),
                        ),
                        _PopupOptionRow(
                          icon: Icons.flag_outlined,
                          title: 'Báo cáo',
                          onTap: () {
                            Navigator.of(context).pop();
                            onReport();
                          },
                        ),
                        if (canDelete && onDelete != null) ...[
                          const Divider(
                            height: 1,
                            thickness: 1,
                            color: Color(0xFFF1F5F9),
                          ),
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
                ),
              ],
            ),
          ),
        ),
      ],
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
