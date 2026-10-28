import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/core/widgets/widgets.dart';
import 'package:rental_car/features/community/domain/entities/post_entity.dart';

/// Header bài viết: Avatar, tên tác giả, tag danh mục, trường học, thời gian và nút tùy chọn
class PostCardHeader extends StatelessWidget {
  const PostCardHeader({
    super.key,
    required this.post,
    required this.isAuthorPlus,
    required this.onOptionsPressed,
  });

  final PostEntity post;
  final bool isAuthorPlus;
  final VoidCallback onOptionsPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 14, 10, 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 1.5,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withAlpha(20),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        post.primaryTag,
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(2),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        post.authorUniversity ?? 'FPT University',
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.textSecondary,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Text(
                      ' • ',
                      style: TextStyle(fontSize: 11, color: AppColors.textMuted),
                    ),
                    Text(
                      post.formattedTime,
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const Gap.h(3),
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
          IconButton(
            icon: const Icon(
              Icons.more_horiz_rounded,
              color: AppColors.textMuted,
              size: 20,
            ),
            onPressed: onOptionsPressed,
            visualDensity: VisualDensity.compact,
            splashRadius: 18,
          ),
        ],
      ),
    );
  }
}
