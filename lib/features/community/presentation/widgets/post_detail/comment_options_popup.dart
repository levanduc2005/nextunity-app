import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rental_car/features/community/domain/entities/reaction_type.dart';
import 'package:rental_car/features/community/presentation/widgets/post_detail/comment_actions_menu.dart';
import 'package:rental_car/features/community/presentation/widgets/post_detail/comment_preview_card.dart';
import 'package:rental_car/features/community/presentation/widgets/post_detail/comment_reaction_capsule_bar.dart';

/// Popup nổi xuất hiện khi nhấn giữ (hold) vào một bình luận:
/// - Phía trên: Thanh chọn cảm xúc
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
                CommentReactionCapsuleBar(
                  width: cardWidth,
                  height: reactionBarHeight,
                  currentReaction: currentReaction,
                  onReactionSelected: onReactionSelected,
                  onReactionCleared: onReactionCleared,
                ),

                const SizedBox(height: 10),

                // 2. Ở giữa: Đoạn comment (Comment Preview Card)
                CommentPreviewCard(
                  width: cardWidth,
                  authorName: authorName,
                  formattedTime: formattedTime,
                  authorAvatar: authorAvatar,
                  commentContent: commentContent,
                ),

                const SizedBox(height: 10),

                // 3. Phía dưới: Menu các tùy chọn (Options Card)
                CommentActionsMenu(
                  width: optionsCardWidth,
                  commentContent: commentContent,
                  onReply: onReply,
                  onReport: onReport,
                  canDelete: canDelete,
                  onDelete: onDelete,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
