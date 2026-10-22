import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/core/widgets/widgets.dart';
import 'package:rental_car/features/community/domain/entities/comment_entity.dart';
import 'package:rental_car/features/community/domain/entities/reaction_type.dart';
import 'package:rental_car/features/community/presentation/widgets/common/post_reaction_button.dart';
import 'package:rental_car/features/community/presentation/widgets/common/reaction_counter_badge.dart';
import 'package:rental_car/features/community/presentation/widgets/post_detail/comment_options_popup.dart';

/// Widget hiển thị 1 bình luận dạng bong bóng chat Facebook (hỗ trợ reply con lồng nhau)
/// - Giờ hiển thị cạnh tên người dùng
/// - Nhấn giữ (hold) để mở thanh cảm xúc ở trên và các tùy chọn (sao chép, trả lời, báo cáo, xóa) ở dưới
/// - Hiển thị icon cảm xúc hiện tại gọn gàng bên cạnh nút 'Trả lời'
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAvatar(comment.authorAvatar, comment.initials),
              const Gap.h(8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Builder(
                      builder: (bubbleContext) => GestureDetector(
                        onLongPress: () => _showCommentOptions(bubbleContext),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF0F2F5),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Header: Tên người dùng + Giờ bên cạnh
                              Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  Text(
                                    comment.authorName,
                                    style: const TextStyle(
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF0F172A),
                                    ),
                                  ),
                                  const Gap.h(6),
                                  Text(
                                    comment.formattedTime,
                                    style: const TextStyle(
                                      fontSize: 11,
                                      color: Color(0xFF94A3B8),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  if (comment.authorBadge != null) ...[
                                    const Gap.h(6),
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
                                        comment.authorBadge!,
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
                              const Gap(2),
                              // Nội dung bình luận
                              Text(
                                comment.content,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF1E293B),
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Sub-actions dưới bong bóng: Icon Like (chạm/hold) + Trả lời + Đếm cảm xúc
                    Padding(
                      padding: const EdgeInsets.only(left: 6, top: 4),
                      child: Row(
                        children: [
                          PostReactionButton(
                            isCompact: true,
                            showLabel: false,
                            currentReaction: comment.currentUserReaction,
                            onReactionSelected: (reaction) =>
                                onToggleReaction(comment.id, reaction),
                            onReactionCleared: () => onToggleReaction(
                              comment.id,
                              comment.currentUserReaction ?? ReactionType.like,
                            ),
                          ),
                          const Gap.h(6),
                          InkWell(
                            onTap: onReply,
                            borderRadius: BorderRadius.circular(4),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              child: Text(
                                'Trả lời',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF64748B),
                                ),
                              ),
                            ),
                          ),
                          if (comment.reactionCount > 0) ...[
                            const Gap.h(6),
                            ReactionCounterBadge(
                              topReactions: comment.topReactions,
                              totalCount: comment.reactionCount,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // 2. Bình luận con (Nested Replies)
          if (comment.replies.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 36, top: 8),
              child: Column(
                children: comment.replies.map((reply) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildAvatar(
                          reply.authorAvatar,
                          reply.initials,
                          radius: 14,
                        ),
                        const Gap.h(8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Builder(
                                builder: (replyBubbleContext) => GestureDetector(
                                  onLongPress: () => _showReplyOptions(
                                    replyBubbleContext,
                                    reply,
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF0F2F5),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Wrap(
                                          crossAxisAlignment:
                                              WrapCrossAlignment.center,
                                          children: [
                                            Text(
                                              reply.authorName,
                                              style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700,
                                                color: Color(0xFF0F172A),
                                              ),
                                            ),
                                            const Gap.h(6),
                                            Text(
                                              reply.formattedTime,
                                              style: const TextStyle(
                                                fontSize: 10.5,
                                                color: Color(0xFF94A3B8),
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            if (reply.authorBadge != null) ...[
                                              const Gap.h(6),
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 5,
                                                      vertical: 1,
                                                    ),
                                                decoration: BoxDecoration(
                                                  color: const Color(
                                                    0xFFDCFCE7,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                ),
                                                child: Text(
                                                  reply.authorBadge!,
                                                  style: const TextStyle(
                                                    fontSize: 9.5,
                                                    fontWeight: FontWeight.w800,
                                                    color: AppColors.primary,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ],
                                        ),
                                        const Gap(2),
                                        Text(
                                          reply.content,
                                          style: const TextStyle(
                                            fontSize: 12.5,
                                            color: Color(0xFF1E293B),
                                            height: 1.4,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              // Sub-actions dưới bong bóng trả lời: Icon Like + Trả lời + Đếm cảm xúc
                              Padding(
                                padding: const EdgeInsets.only(left: 6, top: 4),
                                child: Row(
                                  children: [
                                    PostReactionButton(
                                      isCompact: true,
                                      showLabel: false,
                                      currentReaction:
                                          reply.currentUserReaction,
                                      onReactionSelected: (reaction) =>
                                          onToggleReaction(reply.id, reaction),
                                      onReactionCleared: () => onToggleReaction(
                                        reply.id,
                                        reply.currentUserReaction ??
                                            ReactionType.like,
                                      ),
                                    ),
                                    const Gap.h(6),
                                    InkWell(
                                      onTap: () => onReplyToChild(reply),
                                      borderRadius: BorderRadius.circular(4),
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 6,
                                          vertical: 2,
                                        ),
                                        child: Text(
                                          'Trả lời',
                                          style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xFF64748B),
                                          ),
                                        ),
                                      ),
                                    ),
                                    if (reply.reactionCount > 0) ...[
                                      const Gap.h(6),
                                      ReactionCounterBadge(
                                        topReactions: reply.topReactions,
                                        totalCount: reply.reactionCount,
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAvatar(String? avatarUrl, String initial, {double radius = 16}) {
    if (avatarUrl != null && avatarUrl.isNotEmpty) {
      return CircleAvatar(
        radius: radius,
        backgroundColor: const Color(0xFF3D5AFE),
        backgroundImage: NetworkImage(avatarUrl),
        onBackgroundImageError: (_, _) {},
      );
    }

    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [Color(0xFF3D5AFE), Color(0xFF60A5FA)],
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        initial.toUpperCase(),
        style: TextStyle(
          color: Colors.white,
          fontSize: radius * 0.75,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
