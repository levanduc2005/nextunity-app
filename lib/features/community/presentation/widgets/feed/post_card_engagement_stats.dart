import 'package:flutter/material.dart';
import 'package:rental_car/features/community/domain/entities/post_entity.dart';
import 'package:rental_car/features/community/presentation/widgets/common/reaction_counter_badge.dart';

/// Hàng tóm tắt số lượt cảm xúc và số bình luận của bài viết
class PostCardEngagementStats extends StatelessWidget {
  const PostCardEngagementStats({super.key, required this.post});

  final PostEntity post;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (post.reactionCount > 0)
            ReactionCounterBadge(
              topReactions: post.topReactions,
              totalCount: post.reactionCount,
            )
          else
            const SizedBox.shrink(),
          Text(
            '${post.commentCount} bình luận',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }
}
