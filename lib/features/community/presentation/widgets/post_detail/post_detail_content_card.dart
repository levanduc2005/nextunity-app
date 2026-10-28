import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/core/theme/app_spacing.dart';
import 'package:rental_car/core/widgets/widgets.dart';
import 'package:rental_car/features/community/domain/entities/post_entity.dart';
import 'package:rental_car/features/community/domain/entities/reaction_type.dart';
import 'package:rental_car/features/community/presentation/widgets/common/post_reaction_button.dart';
import 'package:rental_car/features/community/presentation/widgets/common/reaction_counter_badge.dart';

/// Thẻ hiển thị toàn bộ nội dung bài viết trong trang chi tiết
class PostDetailContentCard extends StatelessWidget {
  const PostDetailContentCard({
    super.key,
    required this.post,
    required this.isLiked,
    this.currentReaction,
    required this.totalCommentsCount,
    required this.onLikePressed,
    this.onReactionSelected,
    this.onReactionCleared,
    required this.onCommentPressed,
    required this.onSharePressed,
    this.isAuthorPlus = false,
  });

  final PostEntity post;
  final bool isLiked;
  final ReactionType? currentReaction;
  final int totalCommentsCount;
  final VoidCallback onLikePressed;
  final ValueChanged<ReactionType>? onReactionSelected;
  final VoidCallback? onReactionCleared;
  final VoidCallback onCommentPressed;
  final VoidCallback onSharePressed;
  final bool isAuthorPlus;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Avatar, Name, Tag, Time
          Row(
            children: [
              AppAvatar(
                name: post.displayAuthor,
                imageUrl: post.authorAvatar,
                radius: 19,
                isPlus: isAuthorPlus,
              ),
              const Gap.h(10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            post.displayAuthor,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const Gap.h(6),
                        Text(
                          post.primaryTag,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                    const Gap(2),
                    Row(
                      children: [
                        Text(
                          post.formattedTime,
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const Text(
                          ' • ',
                          style: TextStyle(
                            fontSize: 11,
                            color: AppColors.textMuted,
                          ),
                        ),
                        const Icon(
                          Icons.public_rounded,
                          size: 12,
                          color: AppColors.textMuted,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          const Gap(12),

          // Tiêu đề bài viết
          if (post.title.trim().isNotEmpty) ...[
            Text(
              post.title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
                height: 1.35,
              ),
            ),
            const Gap(8),
          ],

          // Toàn bộ nội dung bài viết
          Text(
            post.content,
            style: const TextStyle(
              fontSize: 14.5,
              color: AppColors.textLabel,
              height: 1.5,
            ),
          ),

          const Gap(12),

          // Thống kê tương tác
          Row(
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
                '$totalCommentsCount bình luận',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),

          const Gap(8),
          const Divider(height: 1, thickness: 1, color: AppColors.surfaceSubtle),

          // 3 Nút tương tác chuẩn FB
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                Expanded(
                  child: PostReactionButton(
                    currentReaction:
                        currentReaction ?? (isLiked ? ReactionType.like : null),
                    onReactionSelected: (reaction) {
                      if (onReactionSelected != null) {
                        onReactionSelected!(reaction);
                      } else {
                        onLikePressed();
                      }
                    },
                    onReactionCleared: () {
                      if (onReactionCleared != null) {
                        onReactionCleared!();
                      } else {
                        onLikePressed();
                      }
                    },
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: onCommentPressed,
                    borderRadius: BorderRadius.circular(8),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.chat_bubble_outline_rounded,
                            size: 18,
                            color: AppColors.textSecondary,
                          ),
                          Gap.h(6),
                          Text(
                            'Bình luận',
                            style: TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textSecondaryDark,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: onSharePressed,
                    borderRadius: BorderRadius.circular(8),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.share_outlined,
                            size: 18,
                            color: AppColors.textSecondary,
                          ),
                          Gap.h(6),
                          Text(
                            'Chia sẻ',
                            style: TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textSecondaryDark,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
