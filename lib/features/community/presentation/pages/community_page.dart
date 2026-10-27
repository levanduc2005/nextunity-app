import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_car/core/providers/core_providers.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/core/theme/app_spacing.dart';
import 'package:rental_car/core/widgets/widgets.dart';
import 'package:rental_car/features/community/domain/entities/reaction_type.dart';
import 'package:rental_car/features/community/presentation/providers/community_providers.dart';
import 'package:rental_car/features/community/presentation/widgets/feed/community_active_filter_banner.dart';
import 'package:rental_car/features/community/presentation/widgets/feed/community_feed_empty_state.dart';
import 'package:rental_car/features/community/presentation/widgets/feed/community_post_card.dart';
import 'package:rental_car/features/community/presentation/widgets/feed/community_search_bar.dart';
import 'package:rental_car/features/community/presentation/widgets/feed/quick_create_post_card.dart';

/// Màn hình Bảng tin Cộng đồng (Community Feed) chuẩn mạng xã hội sinh viên FPTU
class CommunityPage extends ConsumerStatefulWidget {
  const CommunityPage({super.key});

  @override
  ConsumerState<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends ConsumerState<CommunityPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(communityControllerProvider);
    final controller = ref.read(communityControllerProvider.notifier);
    final user = ref.watch(currentUserProvider);
    final filteredPosts = state.filteredPosts;

    return Scaffold(
      backgroundColor: AppColors.pastelBackground,
      body: SafeArea(
        child: Column(
          children: [
            // Unified Top Header & Search Bar
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 6),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  MainTabHeader(
                    displayName: user?.displayName,
                    avatarUrl: user?.avatarUrl,
                    isPlus: user?.isPlus == true,
                    padding: EdgeInsets.zero,
                  ),
                  const SizedBox(height: 10),
                  // Search & Filter Bar
                  CommunitySearchBar(
                    searchController: _searchController,
                    onSearchChanged: (val) {
                      controller.setSearchQuery(val);
                      setState(() {});
                    },
                    onSearchCleared: () {
                      _searchController.clear();
                      controller.setSearchQuery('');
                      setState(() {});
                    },
                    selectedTag: state.selectedTag,
                    tags: state.tags,
                    onTagSelected: controller.selectTag,
                  ),
                ],
              ),
            ),

            // Feed Content
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => controller.loadPosts(),
                color: AppColors.primary,
                child: state.isLoading && state.posts.isEmpty
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                        ),
                      )
                    : ListView(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        children: [
                          // Hộp Tạo bài viết nhanh
                          const QuickCreatePostCard(),
                          const Gap(AppSpacing.sm),

                          // Thanh thông báo khi đang lọc theo môn học
                          CommunityActiveFilterBanner(
                            selectedTag: state.selectedTag,
                            onClearFilter: () => controller.selectTag('Tất cả'),
                          ),

                          // Danh sách bài viết hoặc trạng thái rỗng
                          if (filteredPosts.isEmpty)
                            CommunityFeedEmptyState(
                              selectedTag: state.selectedTag,
                            )
                          else
                            ...filteredPosts.map((post) {
                              final currentReaction = state.getPostReaction(
                                post.id,
                              );
                              final isLiked = currentReaction != null;
                              return Padding(
                                padding: const EdgeInsets.only(
                                  bottom: AppSpacing.md,
                                ),
                                child: CommunityPostCard(
                                  post: post,
                                  isLiked: isLiked,
                                  currentReaction: currentReaction,
                                  onReactionSelected: (reaction) =>
                                      controller.reactToPost(
                                        post.id,
                                        reactionType: reaction,
                                      ),
                                  onReactionCleared: () =>
                                      controller.reactToPost(
                                        post.id,
                                        reactionType:
                                            currentReaction ??
                                            ReactionType.like,
                                      ),
                                  onLikePressed: () =>
                                      controller.toggleLike(post.id),
                                ),
                              );
                            }),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
