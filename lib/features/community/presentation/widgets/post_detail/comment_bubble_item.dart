import 'package:flutter/material.dart';
import 'package:rental_car/core/widgets/widgets.dart';
import 'package:rental_car/features/community/domain/entities/comment_entity.dart';
import 'package:rental_car/features/community/domain/entities/reaction_type.dart';
import 'package:rental_car/features/community/presentation/widgets/post_detail/comment_nested_replies_list.dart';
import 'package:rental_car/features/community/presentation/widgets/post_detail/comment_options_popup.dart';
import 'package:rental_car/features/community/presentation/widgets/post_detail/single_comment_bubble.dart';

/// Widget hiển thị 1 bình luận dạng bong bóng chat Facebook (hỗ trợ reply con lồng nhau)
class CommentBubbleItem extends StatelessWidget {
  const CommentBubbleItem({
    super.key,
    required this.comment,
    required this.onReply,
    required this.onReplyToChild,
    required this.onToggleReaction,
    this.canDelete = false,
    this.onDelete,
    this.canDeleteReply,
    this.onDeleteReply,
  });

  final CommentEntity comment;
  final VoidCallback onReply;
  final void Function(CommentEntity child) onReplyToChild;
  final void Function(String commentId, ReactionType reaction) onToggleReaction;
  final bool canDelete;
  final VoidCallback? onDelete;
  final bool Function(CommentEntity reply)? canDeleteReply;
  final void Function(CommentEntity reply)? onDeleteReply;

  void _showCommentOptions(BuildContext bubbleContext) {
    final renderBox = bubbleContext.findRenderObject() as RenderBox?;
    final offset =
        renderBox?.localToGlobal(Offset.zero) ?? const Offset(16, 200);
    final size = renderBox?.size ?? const Size(200, 60);
    final bubbleRect = offset & size;

    CommentOptionsPopup.show(
      bubbleContext,
      bubbleRect: bubbleRect,
      commentContent: comment.content,
      authorName: comment.authorName,
      formattedTime: comment.formattedTime,
      authorAvatar: comment.authorAvatar,
      authorInitials: comment.initials,
      authorBadge: comment.authorBadge,
      currentReaction: comment.currentUserReaction,
      onReactionSelected: (reaction) => onToggleReaction(comment.id, reaction),
      onReactionCleared: () => onToggleReaction(
        comment.id,
        comment.currentUserReaction ?? ReactionType.like,
      ),
      onReply: onReply,
      canDelete: canDelete,
      onDelete: onDelete,
      onReport: () =>
          bubbleContext.showSnackBar('Cảm ơn bạn đã gửi báo cáo bình luận.'),
    );
  }

  void _showReplyOptions(BuildContext replyBubbleContext, CommentEntity reply) {
    final renderBox = replyBubbleContext.findRenderObject() as RenderBox?;
    final offset =
        renderBox?.localToGlobal(Offset.zero) ?? const Offset(16, 200);
    final size = renderBox?.size ?? const Size(200, 60);
    final bubbleRect = offset & size;

    CommentOptionsPopup.show(
      replyBubbleContext,
      bubbleRect: bubbleRect,
      commentContent: reply.content,
      authorName: reply.authorName,
      formattedTime: reply.formattedTime,
      authorAvatar: reply.authorAvatar,
      authorInitials: reply.initials,
      authorBadge: reply.authorBadge,
      currentReaction: reply.currentUserReaction,
      onReactionSelected: (reaction) => onToggleReaction(reply.id, reaction),
      onReactionCleared: () => onToggleReaction(
        reply.id,
        reply.currentUserReaction ?? ReactionType.like,
      ),
      onReply: () => onReplyToChild(reply),
      canDelete: canDeleteReply?.call(reply) ?? false,
      onDelete: onDeleteReply != null ? () => onDeleteReply!(reply) : null,
      onReport: () => replyBubbleContext.showSnackBar(
        'Cảm ơn bạn đã gửi báo cáo bình luận.',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Bình luận cha
          Builder(
            builder: (bubbleContext) => SingleCommentBubble(
              comment: comment,
              onLongPress: () => _showCommentOptions(bubbleContext),
              onReply: onReply,
              onReactionSelected: (reaction) =>
                  onToggleReaction(comment.id, reaction),
              onReactionCleared: () => onToggleReaction(
                comment.id,
                comment.currentUserReaction ?? ReactionType.like,
              ),
            ),
          ),

          // 2. Bình luận con (Nested Replies)
          CommentNestedRepliesList(
            replies: comment.replies,
            onLongPressReply: _showReplyOptions,
            onReplyToChild: onReplyToChild,
            onToggleReaction: onToggleReaction,
          ),
        ],
      ),
    );
  }
}
