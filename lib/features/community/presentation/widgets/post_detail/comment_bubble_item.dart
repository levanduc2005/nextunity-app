import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/core/widgets/widgets.dart';
import 'package:rental_car/features/community/domain/entities/comment_entity.dart';
import 'package:rental_car/features/community/domain/entities/reaction_type.dart';
import 'package:rental_car/features/community/presentation/widgets/common/post_reaction_button.dart';
import 'package:rental_car/features/community/presentation/widgets/common/reaction_counter_badge.dart';

/// Widget hiển thị 1 bình luận dạng bong bóng chat xám Facebook (hỗ trợ cả reply con lồng nhau)
class CommentBubbleItem extends StatelessWidget {
  const CommentBubbleItem({
    super.key,
    required this.comment,
    required this.onLike,
    required this.onReply,
    required this.onLikeReply,
    required this.onReplyToChild,
    this.currentReaction,
    this.onReactionSelected,
    this.onReactionCleared,
    this.getReplyReaction,
    this.onReactionSelectedReply,
    this.onReactionClearedReply,
  });

  final CommentEntity comment;
  final VoidCallback onLike;
  final VoidCallback onReply;
  final void Function(String replyId) onLikeReply;
  final void Function(CommentEntity child) onReplyToChild;
  final ReactionType? currentReaction;
  final ValueChanged<ReactionType>? onReactionSelected;
  final VoidCallback? onReactionCleared;
  final ReactionType? Function(String replyId)? getReplyReaction;
  final void Function(String replyId, ReactionType reaction)?
  onReactionSelectedReply;
  final void Function(String replyId)? onReactionClearedReply;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bình luận cha
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAvatar(comment.authorAvatar, comment.initials),
              const Gap.h(8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Bong bóng chat xám chuẩn Facebook
                    Container(
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
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                comment.authorName,
                                style: const TextStyle(
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF0F172A),
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

                    // Sub-actions: Thời gian, Thích, Trả lời
                    Padding(
                      padding: const EdgeInsets.only(left: 8, top: 4),
                      child: Row(
                        children: [
                          Text(
                            comment.formattedTime,
                            style: const TextStyle(
                              fontSize: 11,
                              color: Color(0xFF64748B),
                            ),
                          ),
                          const Gap.h(8),
                          PostReactionButton(
                            isCompact: true,
                            currentReaction:
                                currentReaction ??
                                (comment.currentUserReaction ??
                                    (comment.isLiked
                                        ? ReactionType.like
                                        : null)),
                            onReactionSelected: (reaction) {
                              if (onReactionSelected != null) {
                                onReactionSelected!(reaction);
                              } else {
                                onLike();
                              }
                            },
                            onReactionCleared: () {
                              if (onReactionCleared != null) {
                                onReactionCleared!();
                              } else {
                                onLike();
                              }
                            },
                          ),
                          const Gap.h(12),
                          InkWell(
                            onTap: onReply,
                            child: const Text(
                              'Trả lời',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF64748B),
                              ),
                            ),
                          ),
                          if (comment.reactionCount > 0) ...[
                            const Gap.h(8),
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

          // Bình luận con (Nested Replies)
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
                              Container(
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
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          reply.authorName,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xFF0F172A),
                                          ),
                                        ),
                                        if (reply.authorBadge != null) ...[
                                          const Gap.h(6),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 5,
                                              vertical: 1,
                                            ),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFDBEAFE),
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
                              Padding(
                                padding: const EdgeInsets.only(left: 8, top: 4),
                                child: Row(
                                  children: [
                                    Text(
                                      reply.formattedTime,
                                      style: const TextStyle(
                                        fontSize: 11,
                                        color: Color(0xFF64748B),
                                      ),
                                    ),
                                    const Gap.h(8),
                                    PostReactionButton(
                                      isCompact: true,
                                      currentReaction:
                                          getReplyReaction?.call(reply.id) ??
                                          (reply.currentUserReaction ??
                                              (reply.isLiked
                                                  ? ReactionType.like
                                                  : null)),
                                      onReactionSelected: (reaction) {
                                        if (onReactionSelectedReply != null) {
                                          onReactionSelectedReply!(
                                            reply.id,
                                            reaction,
                                          );
                                        } else {
                                          onLikeReply(reply.id);
                                        }
                                      },
                                      onReactionCleared: () {
                                        if (onReactionClearedReply != null) {
                                          onReactionClearedReply!(reply.id);
                                        } else {
                                          onLikeReply(reply.id);
                                        }
                                      },
                                    ),
                                    const Gap.h(12),
                                    InkWell(
                                      onTap: () => onReplyToChild(reply),
                                      child: const Text(
                                        'Trả lời',
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xFF64748B),
                                        ),
                                      ),
                                    ),
                                    if (reply.reactionCount > 0) ...[
                                      const Gap.h(8),
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
