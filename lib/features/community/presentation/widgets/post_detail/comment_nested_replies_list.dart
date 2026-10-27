import 'package:flutter/material.dart';
import 'package:rental_car/features/community/domain/entities/comment_entity.dart';
import 'package:rental_car/features/community/domain/entities/reaction_type.dart';
import 'package:rental_car/features/community/presentation/widgets/post_detail/single_comment_bubble.dart';

/// Danh sách các bình luận con lồng nhau dưới một bình luận chính
class CommentNestedRepliesList extends StatelessWidget {
  const CommentNestedRepliesList({
    super.key,
    required this.replies,
    required this.onLongPressReply,
    required this.onReplyToChild,
    required this.onToggleReaction,
  });

  final List<CommentEntity> replies;
  final void Function(BuildContext context, CommentEntity reply)
  onLongPressReply;
  final void Function(CommentEntity reply) onReplyToChild;
  final void Function(String commentId, ReactionType reaction) onToggleReaction;

  @override
  Widget build(BuildContext context) {
    if (replies.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(left: 36, top: 8),
      child: Column(
        children: replies.map((reply) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Builder(
              builder: (replyContext) => SingleCommentBubble(
                comment: reply,
                isReply: true,
                onLongPress: () => onLongPressReply(replyContext, reply),
                onReply: () => onReplyToChild(reply),
                onReactionSelected: (reaction) =>
                    onToggleReaction(reply.id, reaction),
                onReactionCleared: () => onToggleReaction(
                  reply.id,
                  reply.currentUserReaction ?? ReactionType.like,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
