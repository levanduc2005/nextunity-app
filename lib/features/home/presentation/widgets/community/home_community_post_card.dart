import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/core/utils/date_time_formatter.dart';
import 'package:rental_car/core/widgets/app_avatar.dart';
import 'package:rental_car/features/community/domain/entities/post_entity.dart';

/// Thẻ bài viết thảo luận rút gọn hiển thị trên màn hình Trang Chủ
class HomeCommunityPostCard extends StatelessWidget {
  const HomeCommunityPostCard({
    super.key,
    required this.post,
    required this.onTap,
  });

  final PostEntity post;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final authorName = post.authorName?.trim().isNotEmpty == true
        ? post.authorName!.trim()
        : 'Sinh viên FPT';
    final timeStr = DateTimeFormatter.formatRelativeTime(post.createdAt);
    final firstTag = post.tags.isNotEmpty ? post.tags.first : null;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
            color: Color(0x06000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Tác giả & Tag môn học
                Row(
                  children: [
                    AppAvatar(
                      name: authorName,
                      imageUrl: post.authorAvatar,
                      radius: 14,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            authorName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          Text(
                            timeStr,
                            style: const TextStyle(
                              fontSize: 10.5,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (firstTag != null) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primaryContainer,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          firstTag.startsWith('#') ? firstTag : '#$firstTag',
                          style: const TextStyle(
                            fontSize: 10.5,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 10),

                // 2. Tiêu đề bài viết
                Text(
                  post.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                    letterSpacing: -0.2,
                  ),
                ),
                const SizedBox(height: 4),

                // 3. Nội dung tóm tắt
                Text(
                  post.content,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 10),

                // 4. Lượt thích & bình luận
                Row(
                  children: [
                    Icon(
                      post.currentUserReaction != null
                          ? Icons.favorite_rounded
                          : Icons.favorite_border_rounded,
                      size: 15,
                      color: post.currentUserReaction != null
                          ? AppColors.error
                          : AppColors.textMuted,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${post.reactionCount}',
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(width: 14),
                    const Icon(
                      Icons.chat_bubble_outline_rounded,
                      size: 14,
                      color: AppColors.textMuted,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${post.commentCount}',
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

