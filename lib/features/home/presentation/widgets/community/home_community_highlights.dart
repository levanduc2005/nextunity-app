import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_car/app/router/app_routes.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/features/community/domain/entities/post_entity.dart';
import 'package:rental_car/features/home/presentation/widgets/community/home_community_empty_card.dart';
import 'package:rental_car/features/home/presentation/widgets/community/home_community_post_card.dart';

/// Khối "Thảo luận nổi bật từ Cộng đồng" hiển thị ở cuối Trang Chủ
class HomeCommunityHighlights extends StatelessWidget {
  const HomeCommunityHighlights({
    super.key,
    required this.posts,
    this.isLoading = false,
  });

  final List<PostEntity> posts;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // 1. Tiêu đề khối + Nút "Xem tất cả"
        Row(
          children: [
            const Expanded(
              child: Text(
                'Thảo luận nổi bật',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                  letterSpacing: -0.3,
                ),
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => context.go(AppRoute.community.path),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Xem tất cả',
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(width: 3),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 11,
                    color: AppColors.primary,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // 2. Nội dung danh sách / Trạng thái tải / Trạng thái trống
        if (isLoading && posts.isEmpty)
          const SizedBox(
            height: 100,
            child: Center(
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                color: AppColors.primary,
              ),
            ),
          )
        else if (posts.isEmpty)
          HomeCommunityEmptyCard(
            onCreatePost: () => context.push(AppRoute.createPost.path),
          )
        else
          Column(
            children: [
              for (int i = 0; i < posts.length; i++) ...[
                if (i > 0) const SizedBox(height: 10),
                HomeCommunityPostCard(
                  post: posts[i],
                  onTap: () {
                    context.push('/community/posts/${posts[i].id}');
                  },
                ),
              ],
            ],
          ),
      ],
    );
  }
}

