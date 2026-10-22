import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_car/core/providers/core_providers.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/core/theme/app_spacing.dart';
import 'package:rental_car/core/widgets/widgets.dart';
import 'package:rental_car/features/community/domain/entities/reaction_type.dart';
import 'package:rental_car/features/community/presentation/providers/community_providers.dart';
import 'package:rental_car/features/community/presentation/widgets/feed/community_filter_chips.dart';
import 'package:rental_car/features/community/presentation/widgets/feed/community_post_card.dart';
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
                    padding: EdgeInsets.zero,
                  ),
                  const SizedBox(height: 10),
                  // Search & Filter Bar
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 40,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: const Color(0xFFE2E8F0)),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(
                                  0xFF1E3A8A,
                                ).withValues(alpha: 0.04),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.search_rounded,
                                color: Color(0xFF94A3B8),
                                size: 19,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: TextField(
                                  controller: _searchController,
                                  decoration: const InputDecoration(
                                    hintText:
                                        'Tìm bài viết, hashtag (#SWP391)...',
                                    hintStyle: TextStyle(
                                      fontSize: 12.5,
                                      color: Color(0xFF94A3B8),
                                    ),
                                    border: InputBorder.none,
                                    isDense: true,
                                    contentPadding: EdgeInsets.zero,
                                  ),
                                  style: const TextStyle(fontSize: 13),
                                  onChanged: (val) {
                                    controller.setSearchQuery(val);
                                    setState(() {});
                                  },
                                ),
                              ),
                              if (_searchController.text.isNotEmpty)
                                GestureDetector(
                                  onTap: () {
                                    _searchController.clear();
                                    controller.setSearchQuery('');
                                    setState(() {});
                                  },
                                  child: const Icon(
                                    Icons.close_rounded,
                                    size: 16,
                                    color: Color(0xFF94A3B8),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      _buildFilterButton(context, state, controller),
                    ],
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
                          if (state.selectedTag != 'Tất cả') ...[
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(
                                  AppRadius.sm,
                                ),
                                border: Border.all(
                                  color: const Color(0xFFE2E8F0),
                                ),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.filter_alt_rounded,
                                    size: 16,
                                    color: AppColors.primary,
                                  ),
                                  const Gap.h(6),
                                  const Text(
                                    'Đang lọc theo: ',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Color(0xFF64748B),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.primary.withAlpha(20),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      state.selectedTag,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  InkWell(
                                    onTap: () => controller.selectTag('Tất cả'),
                                    borderRadius: BorderRadius.circular(12),
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 6,
                                        vertical: 2,
                                      ),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Xóa lọc',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFFEF4444),
                                            ),
                                          ),
                                          Gap.h(2),
                                          Icon(
                                            Icons.close_rounded,
                                            size: 14,
                                            color: Color(0xFFEF4444),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Gap(AppSpacing.sm),
                          ],

                          // Danh sách bài viết
                          if (filteredPosts.isEmpty)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 48,
                                horizontal: 24,
                              ),
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.forum_outlined,
                                    size: 48,
                                    color: Colors.grey.shade400,
                                  ),
                                  const Gap(12),
                                  Text(
                                    state.selectedTag != 'Tất cả'
                                        ? 'Chưa có bài viết nào với thẻ ${state.selectedTag}'
                                        : 'Chưa có bài viết nào trong cộng đồng',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey.shade600,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const Gap(8),
                                  const Text(
                                    'Hãy là người đầu tiên đặt câu hỏi hoặc chia sẻ tài liệu!',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
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

  Widget _buildFilterButton(
    BuildContext context,
    CommunityState state,
    CommunityController controller,
  ) {
    final isFiltered = state.selectedTag != 'Tất cả';

    if (isFiltered) {
      return InkWell(
        onTap: () => CommunityFilterModal.show(
          context: context,
          selectedTag: state.selectedTag,
          tags: state.tags,
          onTagSelected: controller.selectTag,
        ),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: AppColors.primary.withAlpha(20),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.primary),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.filter_alt_rounded,
                size: 15,
                color: AppColors.primary,
              ),
              const Gap.h(4),
              Text(
                state.selectedTag,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return InkWell(
      onTap: () => CommunityFilterModal.show(
        context: context,
        selectedTag: state.selectedTag,
        tags: state.tags,
        onTagSelected: controller.selectTag,
      ),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF1E3A8A).withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: const Icon(
          Icons.tune_rounded,
          color: Color(0xFF475569),
          size: 20,
        ),
      ),
    );
  }
}
