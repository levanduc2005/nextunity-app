import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_car/core/theme/app_spacing.dart';
import 'package:rental_car/core/widgets/widgets.dart';
import 'package:rental_car/features/auth/domain/entities/user_entity.dart';
import 'package:rental_car/features/auth/presentation/providers/auth_controller.dart';
import 'package:rental_car/features/community/domain/entities/post_entity.dart';
import 'package:rental_car/features/community/domain/entities/reaction_type.dart';
import 'package:rental_car/features/community/presentation/providers/community_providers.dart';
import 'package:rental_car/features/community/presentation/widgets/common/post_options_bottom_sheet.dart';
import 'package:rental_car/features/community/presentation/widgets/feed/post_card_actions_bar.dart';
import 'package:rental_car/features/community/presentation/widgets/feed/post_card_content_body.dart';
import 'package:rental_car/features/community/presentation/widgets/feed/post_card_engagement_stats.dart';
import 'package:rental_car/features/community/presentation/widgets/feed/post_card_header.dart';

/// Card bài viết chuẩn mạng xã hội (Facebook / Threads style) cho NextUnity Community
class CommunityPostCard extends ConsumerStatefulWidget {
  const CommunityPostCard({
    super.key,
    required this.post,
    this.isLiked = false,
    this.currentReaction,
    this.onLikePressed,
    this.onReactionSelected,
    this.onReactionCleared,
    this.onSharePressed,
    this.onDeletePressed,
  });

  final PostEntity post;
  final bool isLiked;
  final ReactionType? currentReaction;
  final VoidCallback? onLikePressed;
  final ValueChanged<ReactionType>? onReactionSelected;
  final VoidCallback? onReactionCleared;
  final VoidCallback? onSharePressed;
  final VoidCallback? onDeletePressed;

  @override
  ConsumerState<CommunityPostCard> createState() => _CommunityPostCardState();
}

class _CommunityPostCardState extends ConsumerState<CommunityPostCard> {
  @override
  Widget build(BuildContext context) {
    final post = widget.post;
    final currentUser = ref.watch(authControllerProvider).user;
    final isAuthorCurrentUser =
        currentUser != null &&
        (currentUser.id == post.authorId ||
            (post.authorName != null &&
                currentUser.fullName?.trim().toLowerCase() ==
                    post.authorName!.trim().toLowerCase()));
    final isAuthorPlus = isAuthorCurrentUser && currentUser.isPlus;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Phần nội dung bài viết bấm vào để xem chi tiết
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(AppRadius.md),
              ),
              onTap: () => context.push('/community/posts/${post.id}'),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Post Header: Avatar, Author, Tag, Time, Options
                  PostCardHeader(
                    post: post,
                    isAuthorPlus: isAuthorPlus,
                    onOptionsPressed: () => _showPostOptions(context),
                  ),

                  // 2. Post Title & Body Text
                  PostCardContentBody(
                    title: post.title,
                    content: post.content,
                    onSeeMore: () =>
                        context.push('/community/posts/${post.id}'),
                  ),

                  const Gap(10),

                  // 3. Engagement Stats Summary Row
                  PostCardEngagementStats(post: post),
                ],
              ),
            ),
          ),

          const Gap(6),
          const Divider(height: 1, thickness: 1, color: Color(0xFFF1F5F9)),

          // 4. Action Buttons Bar (Thích - Bình luận - Chia sẻ)
          PostCardActionsBar(
            currentReaction: widget.currentReaction,
            isLiked: widget.isLiked,
            onReactionSelected: widget.onReactionSelected,
            onReactionCleared: widget.onReactionCleared,
            onLikePressed: widget.onLikePressed,
            onCommentPressed: () => context.push('/community/posts/${post.id}'),
            onSharePressed:
                widget.onSharePressed ??
                () {
                  context.showSuccessSnackBar('Đã sao chép liên kết bài viết!');
                },
          ),
        ],
      ),
    );
  }

  bool _checkCanDelete(UserEntity? user) {
    if (user == null) return false;
    if (user.role.toUpperCase() == 'ADMIN') return true;
    if (widget.post.authorId != null && user.id != null) {
      if (widget.post.authorId!.toLowerCase() == user.id!.toLowerCase()) {
        return true;
      }
    }
    if (widget.post.authorName != null && user.fullName != null) {
      if (widget.post.authorName!.trim().toLowerCase() ==
          user.fullName!.trim().toLowerCase()) {
        return true;
      }
    }
    return false;
  }

  void _showPostOptions(BuildContext context) {
    final user = ref.read(authControllerProvider).user;
    final canDelete = _checkCanDelete(user);

    PostOptionsBottomSheet.show(
      context,
      canDelete: canDelete,
      onCopyLink: () => context.showSnackBar('Đã sao chép liên kết bài viết!'),
      onDelete: canDelete ? _confirmDeletePost : null,
    );
  }

  Future<void> _confirmDeletePost() async {
    final confirmed = await showConfirmDialog(
      context,
      title: 'Xóa bài viết',
      message:
          'Bạn có chắc chắn muốn xóa bài viết này không? Hành động này không thể hoàn tác.',
      confirmLabel: 'Xóa',
      cancelLabel: 'Hủy',
      isDestructive: true,
    );

    if (!confirmed || !mounted) return;

    final success = await ref
        .read(communityControllerProvider.notifier)
        .deletePost(widget.post.id);

    if (!mounted) return;
    if (success) {
      context.showSnackBar('Đã xóa bài viết thành công');
      widget.onDeletePressed?.call();
    } else {
      context.showSnackBar('Không thể xóa bài viết, vui lòng thử lại sau.');
    }
  }
}
