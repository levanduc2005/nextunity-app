import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/core/theme/app_spacing.dart';
import 'package:rental_car/core/widgets/widgets.dart';
import 'package:rental_car/features/community/domain/entities/reaction_type.dart';
import 'package:rental_car/features/community/presentation/providers/community_providers.dart';
import 'package:rental_car/features/community/presentation/widgets/community_filter_chips.dart';
import 'package:rental_car/features/community/presentation/widgets/community_post_card.dart';
import 'package:rental_car/features/community/presentation/widgets/quick_create_post_card.dart';

/// Màn hình Bảng tin Cộng đồng (Community Feed) chuẩn mạng xã hội sinh viên FPTU
class CommunityPage extends ConsumerStatefulWidget {
  const CommunityPage({super.key});

  @override
  ConsumerState<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends ConsumerState<CommunityPage> {
  bool _isSearchActive = false;
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
    final filteredPosts = state.filteredPosts;

    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F5), // Nền xám nhẹ chuẩn FB
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0.5,
        titleSpacing: AppSpacing.md,
        title: _isSearchActive
            ? TextField(
                controller: _searchController,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Tìm kiếm bài viết, hashtag (#SWP391)...',
                  hintStyle: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF94A3B8),
                  ),
                  border: InputBorder.none,
                  prefixIcon: const Icon(
                    Icons.search_rounded,
                    color: AppColors.primary,
                    size: 20,
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.close_rounded, size: 18),
                    onPressed: () {
                      _searchController.clear();
                      controller.setSearchQuery('');
                      setState(() => _isSearchActive = false);
                    },
                  ),
                ),
                style: const TextStyle(fontSize: 14),
                onChanged: (val) => controller.setSearchQuery(val),
              )
            : Row(
                children: [
                  const Text(
                    'Cộng đồng',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primary,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const Gap.h(8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEEF2FF),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'FPTU',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
        actions: [
          // Nút Lọc theo hashtag môn học
          _buildFilterButton(context, state, controller),

          if (!_isSearchActive)
            IconButton(
              icon: const Icon(
                Icons.search_rounded,
                color: Color(0xFF334155),
                size: 22,
              ),
              onPressed: () => setState(() => _isSearchActive = true),
            ),
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.notifications_outlined,
                  color: Color(0xFF334155),
                  size: 22,
                ),
                onPressed: () {
                  context.showSnackBar('Chưa có thông báo mới nào.');
                },
              ),
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFFEF4444),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          const Gap.h(4),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => controller.loadPosts(),
        color: AppColors.primary,
        child: state.isLoading && state.posts.isEmpty
            ? const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
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
                        borderRadius: BorderRadius.circular(AppRadius.sm),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
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
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                  else
                    ...filteredPosts.map((post) {
                      final currentReaction = state.getPostReaction(post.id);
                      final isLiked = currentReaction != null;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.md),
                        child: CommunityPostCard(
                          post: post,
                          isLiked: isLiked,
                          currentReaction: currentReaction,
                          onReactionSelected: (reaction) => controller
                              .reactToPost(post.id, reactionType: reaction),
                          onReactionCleared: () => controller.reactToPost(
                            post.id,
                            reactionType: currentReaction ?? ReactionType.like,
                          ),
                          onLikePressed: () => controller.toggleLike(post.id),
                        ),
                      );
                    }),
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
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 4),
        child: InkWell(
          onTap: () => CommunityFilterModal.show(
            context: context,
            selectedTag: state.selectedTag,
            tags: state.tags,
            onTagSelected: controller.selectTag,
          ),
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
            decoration: BoxDecoration(
              color: AppColors.primary.withAlpha(20),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.primary),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.filter_alt_rounded,
                  size: 14,
                  color: AppColors.primary,
                ),
                const Gap.h(3),
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
        ),
      );
    }

    return IconButton(
      icon: const Icon(Icons.tune_rounded, color: Color(0xFF334155), size: 22),
      tooltip: 'Lọc theo môn học',
      onPressed: () => CommunityFilterModal.show(
        context: context,
        selectedTag: state.selectedTag,
        tags: state.tags,
        onTagSelected: controller.selectTag,
      ),
    );
  }
}
