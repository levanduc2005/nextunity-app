import 'package:flutter/material.dart';
import 'package:rental_car/core/widgets/widgets.dart';
import 'package:rental_car/features/community/domain/entities/comment_entity.dart';
import 'package:rental_car/features/community/domain/entities/reaction_type.dart';
import 'package:rental_car/features/community/presentation/widgets/common/post_reaction_button.dart';
import 'package:rental_car/features/community/presentation/widgets/common/reaction_counter_badge.dart';

import 'package:rental_car/core/theme/app_colors.dart';
/// Bong bóng hiển thị nội dung của một bình luận (dùng chung cho bình luận chính và câu trả lời con)
class SingleCommentBubble extends StatelessWidget {
  const SingleCommentBubble({
    super.key,
    required this.comment,
    this.isReply = false,
    required this.onLongPress,
    required this.onReply,
    required this.onReactionSelected,
    required this.onReactionCleared,
  });

  final CommentEntity comment;
  final bool isReply;
  final VoidCallback onLongPress;
  final VoidCallback onReply;
  final ValueChanged<ReactionType> onReactionSelected;
  final VoidCallback onReactionCleared;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppAvatar(
          name: comment.authorName,
          imageUrl: comment.authorAvatar,
          radius: isReply ? 14 : 16,
        ),
        const Gap.h(8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onLongPress: onLongPress,
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
                            style: TextStyle(
                              fontSize: isReply ? 12 : 12.5,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const Gap.h(6),
                          Text(
                            comment.formattedTime,
                            style: TextStyle(
                              fontSize: isReply ? 10.5 : 11,
                              color: AppColors.textMuted,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      const Gap(2),
                      // Nội dung bình luận
                      Text(
                        comment.content,
                        style: TextStyle(
                          fontSize: isReply ? 12.5 : 13,
                          color: AppColors.textDark,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Sub-actions dưới bong bóng: Icon Like + Trả lời + Đếm cảm xúc
              Padding(
                padding: const EdgeInsets.only(left: 6, top: 4),
                child: Row(
                  children: [
                    PostReactionButton(
                      isCompact: true,
                      showLabel: false,
                      currentReaction: comment.currentUserReaction,
                      onReactionSelected: onReactionSelected,
                      onReactionCleared: onReactionCleared,
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
                            color: AppColors.textSecondary,
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
    );
  }
}
