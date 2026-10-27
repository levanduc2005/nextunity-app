import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/core/widgets/widgets.dart';
import 'package:rental_car/features/auth/presentation/providers/auth_controller.dart';
import 'package:rental_car/features/community/domain/entities/comment_entity.dart';
import 'package:rental_car/features/community/domain/entities/reaction_type.dart';
import 'package:rental_car/features/community/presentation/providers/community_providers.dart';
import 'package:rental_car/features/community/presentation/widgets/post_detail/post_detail_app_bar.dart';
import 'package:rental_car/features/community/presentation/widgets/post_detail/post_detail_comment_input_bar.dart';
import 'package:rental_car/features/community/presentation/widgets/post_detail/post_detail_comments_section.dart';
import 'package:rental_car/features/community/presentation/widgets/post_detail/post_detail_content_card.dart';
import 'package:rental_car/features/community/presentation/widgets/post_detail/post_detail_empty_state.dart';

/// Màn hình Chi tiết bài viết & Bình luận (Tích hợp API Backend thật 100%)
class PostDetailPage extends ConsumerStatefulWidget {
  const PostDetailPage({required this.postId, super.key});

  final String postId;

  @override
  ConsumerState<PostDetailPage> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends ConsumerState<PostDetailPage> {
  final TextEditingController _commentController = TextEditingController();
  final FocusNode _commentFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(postDetailControllerProvider.notifier).init(widget.postId);
    });
  }

  @override
  void dispose() {
    _commentController.dispose();
    _commentFocusNode.dispose();
    super.dispose();
  }

  Future<void> _handleSendComment() async {
    final text = _commentController.text.trim();
    if (text.isEmpty) return;

    final success = await ref
        .read(postDetailControllerProvider.notifier)
        .sendComment(widget.postId, text);

    if (!mounted) return;
    if (success) {
      _commentController.clear();
    } else {
      context.showErrorSnackBar('Gửi bình luận thất bại. Vui lòng thử lại!');
    }
  }

  void _onReplyTarget(CommentEntity target) {
    ref.read(postDetailControllerProvider.notifier).setReplyTarget(target);
    _commentFocusNode.requestFocus();
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
        .deletePost(widget.postId);
    if (!mounted) return;

    if (success) {
      context.showSnackBar('Đã xóa bài viết thành công');
      context.pop();
    } else {
      context.showSnackBar('Không thể xóa bài viết, vui lòng thử lại sau.');
    }
  }

  Future<void> _confirmDeleteComment(
    CommentEntity comment, {
    String? parentId,
  }) async {
    final confirmed = await showConfirmDialog(
      context,
      title: 'Xóa bình luận',
      message: 'Bạn có chắc chắn muốn xóa bình luận này không?',
      confirmLabel: 'Xóa',
      cancelLabel: 'Hủy',
      isDestructive: true,
    );

    if (!confirmed || !mounted) return;

    final success = await ref
        .read(postDetailControllerProvider.notifier)
        .deleteComment(comment, parentId: parentId, postId: widget.postId);

    if (!mounted) return;
    if (success) {
      context.showSnackBar('Đã xóa bình luận');
    } else {
      context.showErrorSnackBar('Xóa bình luận thất bại');
    }
  }

  @override
  Widget build(BuildContext context) {
    final detailState = ref.watch(postDetailControllerProvider);
    final detailController = ref.read(postDetailControllerProvider.notifier);
    final communityState = ref.watch(communityControllerProvider);
    final communityCtrl = ref.read(communityControllerProvider.notifier);
    final user = ref.watch(authControllerProvider).user;
    final currentUserName = user?.fullName ?? user?.displayName ?? 'Sinh viên';

    final post = detailState.post;
    final isPostLiked =
        post != null && communityState.likedPostIds.contains(post.id);

    final isAuthor =
        user != null &&
        ((post?.authorId != null &&
                user.id != null &&
                post!.authorId!.toLowerCase() == user.id!.toLowerCase()) ||
            (post?.authorName != null &&
                user.fullName != null &&
                post!.authorName!.trim().toLowerCase() ==
                    user.fullName!.trim().toLowerCase()) ||
            post?.authorName == currentUserName);
    final isAdmin = user != null && user.role.toUpperCase() == 'ADMIN';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PostDetailAppBar(
        post: post,
        canDelete: isAuthor || isAdmin,
        onDeletePost: _confirmDeletePost,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: detailState.isLoadingPost && post == null
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    )
                  : post == null
                  ? PostDetailEmptyState(
                      onRetry: () => detailController.init(widget.postId),
                    )
                  : ListView(
                      padding: const EdgeInsets.only(bottom: 24),
                      children: [
                        PostDetailContentCard(
                          post: post,
                          isLiked: isPostLiked,
                          isAuthorPlus:
                              user != null &&
                              user.isPlus &&
                              (user.id == post.authorId ||
                                  (post.authorName != null &&
                                      user.fullName?.trim().toLowerCase() ==
                                          post.authorName!
                                              .trim()
                                              .toLowerCase())),
                          currentReaction: communityState.getPostReaction(
                            post.id,
                          ),
                          totalCommentsCount: detailState.totalCommentsCount,
                          onReactionSelected: (r) => communityCtrl.reactToPost(
                            post.id,
                            reactionType: r,
                          ),
                          onReactionCleared: () => communityCtrl.reactToPost(
                            post.id,
                            reactionType:
                                communityState.getPostReaction(post.id) ??
                                ReactionType.like,
                          ),
                          onLikePressed: () =>
                              communityCtrl.toggleLike(post.id),
                          onCommentPressed: () =>
                              _commentFocusNode.requestFocus(),
                          onSharePressed: () => context.showSuccessSnackBar(
                            'Đã sao chép liên kết bài viết!',
                          ),
                        ),
                        Container(height: 8, color: const Color(0xFFF1F5F9)),
                        PostDetailCommentsSection(
                          comments: detailState.comments,
                          isLoading: detailState.isLoadingComments,
                          totalCommentsCount: detailState.totalCommentsCount,
                          currentUserId: user?.id,
                          currentUserName: currentUserName,
                          currentUserRole: user?.role,
                          postAuthorId: post.authorId,
                          postAuthorName: post.authorName,
                          onReplyComment: _onReplyTarget,
                          onToggleReaction: (cId, reaction) => detailController
                              .toggleCommentReaction(cId, reaction),
                          onDeleteComment: (comment, {parentId}) =>
                              _confirmDeleteComment(
                                comment,
                                parentId: parentId,
                              ),
                        ),
                      ],
                    ),
            ),
            PostDetailCommentInputBar(
              commentController: _commentController,
              commentFocusNode: _commentFocusNode,
              currentUserName: currentUserName,
              currentUserAvatarUrl: user?.avatarUrl,
              replyTarget: detailState.replyTarget,
              onCancelReply: detailController.cancelReply,
              onSend: _handleSendComment,
              isPlus: user?.isPlus == true,
            ),
          ],
        ),
      ),
    );
  }
}
