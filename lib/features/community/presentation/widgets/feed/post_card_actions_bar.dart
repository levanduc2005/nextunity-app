import 'package:flutter/material.dart';
import 'package:rental_car/core/widgets/widgets.dart';
import 'package:rental_car/features/community/domain/entities/reaction_type.dart';
import 'package:rental_car/features/community/presentation/widgets/common/post_reaction_button.dart';

/// Thanh nút hành động tương tác: Thích / Thả cảm xúc, Bình luận, Chia sẻ
class PostCardActionsBar extends StatelessWidget {
  const PostCardActionsBar({
    super.key,
    required this.currentReaction,
    required this.isLiked,
    this.onReactionSelected,
    this.onReactionCleared,
    this.onLikePressed,
    required this.onCommentPressed,
    required this.onSharePressed,
  });

  final ReactionType? currentReaction;
  final bool isLiked;
  final ValueChanged<ReactionType>? onReactionSelected;
  final VoidCallback? onReactionCleared;
  final VoidCallback? onLikePressed;
  final VoidCallback onCommentPressed;
  final VoidCallback onSharePressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      child: Row(
        children: [
          // Bày tỏ cảm xúc bài viết
          Expanded(
            child: PostReactionButton(
              currentReaction:
                  currentReaction ?? (isLiked ? ReactionType.like : null),
              onReactionSelected: (reaction) {
                if (onReactionSelected != null) {
                  onReactionSelected!(reaction);
                } else {
                  onLikePressed?.call();
                }
              },
              onReactionCleared: () {
                if (onReactionCleared != null) {
                  onReactionCleared!();
                } else {
                  onLikePressed?.call();
                }
              },
            ),
          ),

          // Bình luận
          Expanded(
            child: _FeedActionButton(
              icon: Icons.chat_bubble_outline_rounded,
              label: 'Bình luận',
              onTap: onCommentPressed,
            ),
          ),

          // Chia sẻ
          Expanded(
            child: _FeedActionButton(
              icon: Icons.share_outlined,
              label: 'Chia sẻ',
              onTap: onSharePressed,
            ),
          ),
        ],
      ),
    );
  }
}

class _FeedActionButton extends StatelessWidget {
  const _FeedActionButton({
    required this.icon,
    required this.label,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 18, color: const Color(0xFF64748B)),
            const Gap.h(6),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: Color(0xFF475569),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
