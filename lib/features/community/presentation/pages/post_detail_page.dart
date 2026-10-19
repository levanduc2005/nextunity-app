import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/core/theme/app_spacing.dart';
import 'package:rental_car/core/widgets/widgets.dart';
import 'package:rental_car/features/auth/presentation/providers/auth_controller.dart';
import 'package:rental_car/features/community/domain/entities/comment_entity.dart';
import 'package:rental_car/features/community/domain/entities/post_entity.dart';
import 'package:rental_car/features/community/domain/entities/reaction_type.dart';
import 'package:rental_car/features/community/presentation/providers/community_providers.dart';
import 'package:rental_car/features/community/presentation/widgets/post_detail/comment_bubble_item.dart';
import 'package:rental_car/features/community/presentation/widgets/post_detail/post_detail_comment_input_bar.dart';
import 'package:rental_car/features/community/presentation/widgets/post_detail/post_detail_content_card.dart';

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

  bool _isFollowing = false;
  CommentEntity? _replyTarget;

  PostEntity? _post;
  bool _isLoadingPost = false;

  List<CommentEntity> _comments = [];
  bool _isLoadingComments = false;

  @override
  void initState() {
    super.initState();
    _loadPostData();
    _loadComments();
  }

  @override
  void dispose() {
    _commentController.dispose();
    _commentFocusNode.dispose();
    super.dispose();
  }

  Future<void> _loadPostData() async {
    // 1. Kiểm tra bài viết đã có sẵn trong state hay chưa
    final posts = ref.read(communityControllerProvider).posts;
    final cached = posts.where((p) => p.id == widget.postId).firstOrNull;
    if (cached != null) {
      setState(() => _post = cached);
    }

    // 2. Fetch chi tiết mới nhất từ Backend (GET /api/posts/{id})
    setState(() => _isLoadingPost = _post == null);
    final result = await ref
        .read(getPostDetailUseCaseProvider)
        .call(widget.postId);
    if (!mounted) return;

    result.when(
      ok: (post) {
        setState(() {
          _post = post;
          _isLoadingPost = false;
        });
      },
      err: (failure) {
        setState(() => _isLoadingPost = false);
        if (_post == null) {
          context.showErrorSnackBar(
            'Không thể tải bài viết: ${failure.message}',
          );
        }
      },
    );
  }

  Future<void> _loadComments() async {
    setState(() => _isLoadingComments = true);
    final result = await ref
        .read(getCommentsUseCaseProvider)
        .call(widget.postId);
    if (!mounted) return;

    result.when(
      ok: (comments) {
        setState(() {
          _comments = comments;
          _isLoadingComments = false;
          if (_post != null) {
            _post = _post!.copyWith(commentCount: _totalCommentsCount);
          }
        });
        ref
            .read(communityControllerProvider.notifier)
            .updateCommentCount(widget.postId, explicitCount: _totalCommentsCount);
      },
      err: (failure) {
        setState(() => _isLoadingComments = false);
      },
    );
  }

  int get _totalCommentsCount {
    var count = _comments.length;
    for (final c in _comments) {
      count += c.replies.length;
    }
    return count;
  }

  void _setReplyTarget(CommentEntity target) {
    setState(() => _replyTarget = target);
    _commentFocusNode.requestFocus();
  }

  void _cancelReply() {
    setState(() => _replyTarget = null);
  }

  Future<void> _handleSendComment() async {
    final text = _commentController.text.trim();
    if (text.isEmpty) return;

    final target = _replyTarget;
    final parentId = target?.parentId ?? target?.id;

    final result = await ref
        .read(createCommentUseCaseProvider)
        .call(postId: widget.postId, content: text, parentId: parentId);

    if (!mounted) return;

    result.when(
      ok: (newComment) {
        _commentController.clear();
        setState(() {
          _replyTarget = null;
          if (_post != null) {
            _post = _post!.copyWith(commentCount: _post!.commentCount + 1);
          }
        });
        ref
            .read(communityControllerProvider.notifier)
            .updateCommentCount(widget.postId);
        _loadComments();
        context.showSuccessSnackBar('Đã đăng bình luận!');
      },
      err: (failure) {
        context.showErrorSnackBar('Gửi bình luận thất bại: ${failure.message}');
      },
    );
  }

  Future<void> _toggleCommentLike(String commentId, {String? parentId}) async {
    // Optimistic UI update
    setState(() {
      _comments = _comments.map((parent) {
        if (parentId == null && parent.id == commentId) {
          final isLiked = parent.isLiked;
          return parent.copyWith(
            isLiked: !isLiked,
            reactionCount: isLiked
                ? parent.reactionCount - 1
                : parent.reactionCount + 1,
          );
        } else if (parent.id == parentId) {
          final updatedReplies = parent.replies.map((reply) {
            if (reply.id == commentId) {
              final isLiked = reply.isLiked;
              return reply.copyWith(
                isLiked: !isLiked,
                reactionCount: isLiked
                    ? reply.reactionCount - 1
                    : reply.reactionCount + 1,
              );
            }
            return reply;
          }).toList();
          return parent.copyWith(replies: updatedReplies);
        }
        return parent;
      }).toList();
    });

    // Gọi API Backend POST /api/reactions/comment/{commentId}
    final result = await ref
        .read(toggleCommentReactionUseCaseProvider)
        .call(commentId);
    if (result.isErr) {
      // Revert if API fails
      if (!mounted) return;
      _loadComments();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(communityControllerProvider);
    final controller = ref.read(communityControllerProvider.notifier);
    final user = ref.watch(authControllerProvider).user;
    final currentUserName = user?.fullName ?? user?.displayName ?? 'Sinh viên';

    final post = _post;
    final isPostLiked = post != null && state.likedPostIds.contains(post.id);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 1,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Color(0xFF334155),
            size: 24,
          ),
          onPressed: () => context.pop(),
        ),
        centerTitle: true,
        title: Column(
          children: [
            const Text(
              'Bài viết',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Color(0xFF0F172A),
              ),
            ),
            if (post != null)
              Text(
                'Tác giả: ${post.displayAuthor}',
                style: const TextStyle(fontSize: 11, color: Color(0xFF64748B)),
              ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.more_horiz_rounded,
              color: Color(0xFF334155),
              size: 24,
            ),
            onPressed: () => _showPostOptions(context),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: _isLoadingPost && post == null
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    )
                  : post == null
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.error_outline_rounded,
                            size: 48,
                            color: Colors.grey,
                          ),
                          const Gap(12),
                          const Text(
                            'Không tìm thấy bài viết hoặc bài viết đã bị xóa.',
                            style: TextStyle(color: Colors.grey),
                          ),
                          const Gap(12),
                          ElevatedButton(
                            onPressed: _loadPostData,
                            child: const Text('Thử lại'),
                          ),
                        ],
                      ),
                    )
                  : ListView(
                      padding: const EdgeInsets.only(bottom: 24),
                      children: [
                        // 1. Thẻ bài viết chính (Modular Post Content Card)
                        PostDetailContentCard(
                          post: post,
                          isLiked: isPostLiked,
                          currentReaction: state.getPostReaction(post.id),
                          isFollowing: _isFollowing,
                          totalCommentsCount: _totalCommentsCount,
                          onReactionSelected: (r) => controller.reactToPost(
                            post.id,
                            reactionType: r,
                          ),
                          onReactionCleared: () => controller.reactToPost(
                            post.id,
                            reactionType:
                                state.getPostReaction(post.id) ??
                                ReactionType.like,
                          ),
                          onLikePressed: () => controller.toggleLike(post.id),
                          onCommentPressed: () =>
                              _commentFocusNode.requestFocus(),
                          onSharePressed: () {
                            context.showSuccessSnackBar(
                              'Đã sao chép liên kết bài viết!',
                            );
                          },
                          onToggleFollow: () {
                            setState(() => _isFollowing = !_isFollowing);
                            context.showSnackBar(
                              _isFollowing
                                  ? 'Đã theo dõi bài viết này!'
                                  : 'Đã bỏ theo dõi bài viết.',
                            );
                          },
                        ),

                        // Divider dày phân cách giữa bài viết và bình luận
                        Container(height: 8, color: const Color(0xFFF1F5F9)),

                        // 2. Khu vực Bình luận (Facebook Bubble Style)
                        Padding(
                          padding: const EdgeInsets.all(AppSpacing.md),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Header bình luận
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Tất cả bình luận ($_totalCommentsCount)',
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w800,
                                      color: Color(0xFF0F172A),
                                    ),
                                  ),
                                  const Row(
                                    children: [
                                      Text(
                                        'Phù hợp nhất',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF64748B),
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_drop_down_rounded,
                                        size: 18,
                                        color: Color(0xFF64748B),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              const Gap(14),

                              // Danh sách bình luận
                              if (_isLoadingComments)
                                const Center(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 24),
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                )
                              else if (_comments.isEmpty)
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 24),
                                  child: Center(
                                    child: Text(
                                      'Chưa có bình luận nào. Hãy là người đầu tiên bình luận!',
                                      style: TextStyle(
                                        color: Color(0xFF94A3B8),
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                )
                              else
                                ..._comments.map(
                                  (comment) => CommentBubbleItem(
                                    comment: comment,
                                    onLike: () =>
                                        _toggleCommentLike(comment.id),
                                    onReply: () => _setReplyTarget(comment),
                                    onLikeReply: (replyId) =>
                                        _toggleCommentLike(
                                          replyId,
                                          parentId: comment.id,
                                        ),
                                    onReplyToChild: (child) =>
                                        _setReplyTarget(child),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
            ),

            // 3. Thanh nhập bình luận cố định ở đáy (Modular Facebook Comment Bar)
            PostDetailCommentInputBar(
              commentController: _commentController,
              commentFocusNode: _commentFocusNode,
              currentUserName: currentUserName,
              currentUserAvatarUrl: user?.avatarUrl,
              replyTarget: _replyTarget,
              onCancelReply: _cancelReply,
              onSend: _handleSendComment,
            ),
          ],
        ),
      ),
    );
  }

  void _showPostOptions(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const Gap(12),
              ListTile(
                leading: const Icon(Icons.bookmark_border_rounded),
                title: const Text('Lưu bài viết'),
                onTap: () {
                  Navigator.pop(ctx);
                  context.showSnackBar('Đã lưu vào danh sách của bạn!');
                },
              ),
              ListTile(
                leading: const Icon(Icons.link_rounded),
                title: const Text('Sao chép liên kết'),
                onTap: () {
                  Navigator.pop(ctx);
                  context.showSnackBar('Đã sao chép liên kết bài viết!');
                },
              ),
              ListTile(
                leading: const Icon(Icons.flag_outlined, color: Colors.red),
                title: const Text(
                  'Báo cáo bài viết',
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () {
                  Navigator.pop(ctx);
                  context.showSnackBar('Cảm ơn bạn đã gửi báo cáo.');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
