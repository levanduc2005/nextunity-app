import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/core/theme/app_spacing.dart';
import 'package:rental_car/core/widgets/widgets.dart';
import 'package:rental_car/features/auth/domain/entities/user_entity.dart';
import 'package:rental_car/features/auth/presentation/providers/auth_controller.dart';
import 'package:rental_car/features/community/domain/entities/post_entity.dart';
import 'package:rental_car/features/community/domain/entities/reaction_type.dart';
import 'package:rental_car/features/community/presentation/providers/community_providers.dart';
import 'package:rental_car/features/community/presentation/widgets/common/post_options_bottom_sheet.dart';
import 'package:rental_car/features/community/presentation/widgets/common/post_reaction_button.dart';
import 'package:rental_car/features/community/presentation/widgets/common/reaction_counter_badge.dart';

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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(14, 14, 10, 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildAvatar(post),
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
                                        color: Color(0xFF64748B),
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const Text(
                                    ' • ',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Color(0xFF94A3B8),
                                    ),
                                  ),
                                  Text(
                                    post.formattedTime,
                                    style: const TextStyle(
                                      fontSize: 11,
                                      color: Color(0xFF64748B),
                                    ),
                                  ),
                                  const Gap.h(3),
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
                        IconButton(
                          icon: const Icon(
                            Icons.more_horiz_rounded,
                            color: Color(0xFF94A3B8),
                            size: 20,
                          ),
                          onPressed: () => _showPostOptions(context),
                          visualDensity: VisualDensity.compact,
                          splashRadius: 18,
                        ),
                      ],
                    ),
                  ),

                  // 2. Post Title (Bold 15px)
                  if (post.title.trim().isNotEmpty) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Text(
                        post.title,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF0F172A),
                          height: 1.35,
                        ),
                      ),
                    ),
                    const Gap(6),
                  ],

                  // 3. Post Body Text
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        const textStyle = TextStyle(
                          fontSize: 13.5,
                          color: Color(0xFF334155),
                          height: 1.45,
                        );

                        final textSpan = TextSpan(
                          text: post.content,
                          style: textStyle,
                        );
                        final textPainter = TextPainter(
                          text: textSpan,
                          maxLines: 3,
                          textDirection: Directionality.of(context),
                        )..layout(maxWidth: constraints.maxWidth);

                        final isOverflowing = textPainter.didExceedMaxLines;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              post.content,
                              style: textStyle,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            if (isOverflowing)
                              GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () =>
                                    context.push('/community/posts/${post.id}'),
                                child: const Padding(
                                  padding: EdgeInsets.only(top: 4),
                                  child: Text(
                                    '... Xem thêm',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        );
                      },
                    ),
                  ),

                  const Gap(10),

                  // 5. Engagement Stats Summary Row
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Row(
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
                          '${post.commentCount} bình luận',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const Gap(6),
          const Divider(height: 1, thickness: 1, color: Color(0xFFF1F5F9)),

          // 6. Action Buttons Bar (Thích - Bình luận - Chia sẻ)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            child: Row(
              children: [
                // Bày tỏ cảm xúc bài viết
                Expanded(
                  child: PostReactionButton(
                    currentReaction:
                        widget.currentReaction ??
                        (widget.isLiked ? ReactionType.like : null),
                    onReactionSelected: (reaction) {
                      if (widget.onReactionSelected != null) {
                        widget.onReactionSelected!(reaction);
                      } else {
                        widget.onLikePressed?.call();
                      }
                    },
                    onReactionCleared: () {
                      if (widget.onReactionCleared != null) {
                        widget.onReactionCleared!();
                      } else {
                        widget.onLikePressed?.call();
                      }
                    },
                  ),
                ),

                // Bình luận
                Expanded(
                  child: _ActionButton(
                    icon: Icons.chat_bubble_outline_rounded,
                    label: 'Bình luận',
                    onTap: () => context.push('/community/posts/${post.id}'),
                  ),
                ),

                // Chia sẻ
                Expanded(
                  child: _ActionButton(
                    icon: Icons.share_outlined,
                    label: 'Chia sẻ',
                    onTap:
                        widget.onSharePressed ??
                        () {
                          context.showSuccessSnackBar(
                            'Đã sao chép liên kết bài viết!',
                          );
                        },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar(PostEntity post) {
    if (post.authorAvatar != null && post.authorAvatar!.isNotEmpty) {
      return CircleAvatar(
        radius: 19,
        backgroundColor: const Color(0xFF3D5AFE),
        backgroundImage: NetworkImage(post.authorAvatar!),
        onBackgroundImageError: (_, _) {},
      );
    }

    return Container(
      width: 38,
      height: 38,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [Color(0xFF3D5AFE), Color(0xFF60A5FA)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        post.initials,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 13,
          fontWeight: FontWeight.w700,
        ),
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

class _ActionButton extends StatelessWidget {
  const _ActionButton({required this.icon, required this.label, this.onTap});

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
