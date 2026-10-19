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
    required this.isFollowing,
    required this.totalCommentsCount,
    required this.onLikePressed,
    this.onReactionSelected,
    this.onReactionCleared,
    required this.onCommentPressed,
    required this.onSharePressed,
    required this.onToggleFollow,
  });

  final PostEntity post;
  final bool isLiked;
  final ReactionType? currentReaction;
  final bool isFollowing;
  final int totalCommentsCount;
  final VoidCallback onLikePressed;
  final ValueChanged<ReactionType>? onReactionSelected;
  final VoidCallback? onReactionCleared;
  final VoidCallback onCommentPressed;
  final VoidCallback onSharePressed;
  final VoidCallback onToggleFollow;

  @override
  Widget build(BuildContext context) {
    final hasAttachment =
        post.content.contains('.zip') ||
        post.content.contains('.pdf') ||
        post.title.contains('SWP391');

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Avatar, Name, Tag, Time, Follow
          Row(
            children: [
              _buildAvatar(post.authorAvatar, post.initials),
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
                              color: Color(0xFF0F172A),
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
                            color: Color(0xFF64748B),
                          ),
                        ),
                        const Text(
                          ' • ',
                          style: TextStyle(
                            fontSize: 11,
                            color: Color(0xFF94A3B8),
                          ),
                        ),
                        const Icon(
                          Icons.public_rounded,
                          size: 12,
                          color: Color(0xFF94A3B8),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: onToggleFollow,
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: isFollowing
                        ? const Color(0xFFF1F5F9)
                        : const Color(0xFFEEF2FF),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isFollowing ? Icons.check_rounded : Icons.add_rounded,
                        size: 14,
                        color: isFollowing
                            ? const Color(0xFF64748B)
                            : AppColors.primary,
                      ),
                      const Gap.h(2),
                      Text(
                        isFollowing ? 'Đang theo dõi' : 'Theo dõi',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: isFollowing
                              ? const Color(0xFF64748B)
                              : AppColors.primary,
                        ),
                      ),
                    ],
                  ),
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
                color: Color(0xFF0F172A),
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
              color: Color(0xFF334155),
              height: 1.5,
            ),
          ),

          // Card tệp đính kèm
          if (hasAttachment) ...[
            const Gap(12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEEF2FF),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.folder_zip_rounded,
                      color: AppColors.primary,
                      size: 24,
                    ),
                  ),
                  const Gap.h(10),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Template_SRS_DB_SWP391_FPTU.zip',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF0F172A),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Gap(2),
                        Text(
                          '4.8 MB • 3 tài liệu đính kèm',
                          style: TextStyle(
                            fontSize: 11,
                            color: Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.download_rounded,
                      color: Color(0xFF64748B),
                    ),
                    onPressed: () {
                      context.showInfoSnackBar('Đang tải tệp đính kèm...');
                    },
                  ),
                ],
              ),
            ),
          ],

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
                '$totalCommentsCount bình luận • 5 lượt chia sẻ',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF64748B),
                ),
              ),
            ],
          ),

          const Gap(8),
          const Divider(height: 1, thickness: 1, color: Color(0xFFF1F5F9)),

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
                            color: Color(0xFF64748B),
                          ),
                          Gap.h(6),
                          Text(
                            'Bình luận',
                            style: TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF475569),
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
                            color: Color(0xFF64748B),
                          ),
                          Gap.h(6),
                          Text(
                            'Chia sẻ',
                            style: TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF475569),
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

  Widget _buildAvatar(String? avatarUrl, String initial) {
    if (avatarUrl != null && avatarUrl.isNotEmpty) {
      return CircleAvatar(
        radius: 19,
        backgroundColor: const Color(0xFF3D5AFE),
        backgroundImage: NetworkImage(avatarUrl),
        onBackgroundImageError: (_, _) {},
        child: Text(
          initial.toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      );
    }

    return Container(
      width: 38,
      height: 38,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [Color(0xFF3D5AFE), Color(0xFF60A5FA)],
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        initial.toUpperCase(),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
