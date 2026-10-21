import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_car/core/utils/app_logger.dart';
import 'package:rental_car/features/community/domain/entities/comment_entity.dart';
import 'package:rental_car/features/community/domain/entities/post_entity.dart';
import 'package:rental_car/features/community/domain/entities/reaction_type.dart';
import 'package:rental_car/features/community/presentation/providers/community_providers.dart';

class PostDetailState {
  const PostDetailState({
    this.post,
    this.isLoadingPost = false,
    this.comments = const [],
    this.isLoadingComments = false,
    this.replyTarget,
    this.errorMessage,
  });

  final PostEntity? post;
  final bool isLoadingPost;
  final List<CommentEntity> comments;
  final bool isLoadingComments;
  final CommentEntity? replyTarget;
  final String? errorMessage;

  int get totalCommentsCount {
    var count = comments.length;
    for (final c in comments) {
      count += c.replies.length;
    }
    return count;
  }

  PostDetailState copyWith({
    PostEntity? post,
    bool? isLoadingPost,
    List<CommentEntity>? comments,
    bool? isLoadingComments,
    CommentEntity? replyTarget,
    bool clearReplyTarget = false,
    String? errorMessage,
    bool clearError = false,
  }) {
    return PostDetailState(
      post: post ?? this.post,
      isLoadingPost: isLoadingPost ?? this.isLoadingPost,
      comments: comments ?? this.comments,
      isLoadingComments: isLoadingComments ?? this.isLoadingComments,
      replyTarget: clearReplyTarget ? null : (replyTarget ?? this.replyTarget),
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}

class PostDetailController extends Notifier<PostDetailState> {
  final Set<String> _reactingCommentIds = {};

  @override
  PostDetailState build() {
    return const PostDetailState();
  }

  void init(String postId) {
    // 1. Kiểm tra cache từ feed
    final cached = ref
        .read(communityControllerProvider)
        .posts
        .where((p) => p.id == postId)
        .firstOrNull;

    if (cached != null) {
      state = state.copyWith(post: cached, isLoadingPost: false);
    } else {
      state = state.copyWith(isLoadingPost: true);
    }

    // 2. Fetch data mới nhất từ BE
    loadPost(postId);
    loadComments(postId);
  }

  void reset() {
    state = const PostDetailState();
    _reactingCommentIds.clear();
  }

  Future<void> loadPost(String postId) async {
    final result = await ref.read(getPostDetailUseCaseProvider).call(postId);
    result.when(
      ok: (post) {
        state = state.copyWith(post: post, isLoadingPost: false);
      },
      err: (failure) {
        state = state.copyWith(
          isLoadingPost: false,
          errorMessage: failure.message,
        );
      },
    );
  }

  Future<void> loadComments(String postId, {bool showLoading = true}) async {
    if (showLoading) {
      state = state.copyWith(isLoadingComments: true);
    }
    final result = await ref.read(getCommentsUseCaseProvider).call(postId);

    result.when(
      ok: (comments) {
        final sortedComments = [...comments]
          ..sort((a, b) {
            final aTime = a.createdAt;
            final bTime = b.createdAt;
            if (aTime == null && bTime == null) return 0;
            if (aTime == null) return 1;
            if (bTime == null) return -1;
            return bTime.compareTo(aTime);
          });

        final updatedPost = state.post != null
            ? state.post!.copyWith(
                commentCount: _calculateTotalComments(sortedComments),
              )
            : null;

        state = state.copyWith(
          comments: sortedComments,
          isLoadingComments: false,
          post: updatedPost,
        );

        ref
            .read(communityControllerProvider.notifier)
            .updateCommentCount(
              postId,
              explicitCount: state.totalCommentsCount,
            );
      },
      err: (failure) {
        state = state.copyWith(
          isLoadingComments: false,
          errorMessage: failure.message,
        );
      },
    );
  }

  int _calculateTotalComments(List<CommentEntity> comments) {
    var count = comments.length;
    for (final c in comments) {
      count += c.replies.length;
    }
    return count;
  }

  void setReplyTarget(CommentEntity target) {
    state = state.copyWith(replyTarget: target);
  }

  void cancelReply() {
    state = state.copyWith(clearReplyTarget: true);
  }

  Future<bool> sendComment(String postId, String text) async {
    final target = state.replyTarget;
    final parentId = target?.parentId ?? target?.id;

    final result = await ref
        .read(createCommentUseCaseProvider)
        .call(postId: postId, content: text, parentId: parentId);

    return result.when(
      ok: (newComment) {
        state = state.copyWith(clearReplyTarget: true);
        List<CommentEntity> updatedComments;
        if (parentId == null) {
          updatedComments = [newComment, ...state.comments];
        } else {
          updatedComments = state.comments.map((parent) {
            if (parent.id == parentId) {
              return parent.copyWith(replies: [...parent.replies, newComment]);
            }
            return parent;
          }).toList();
        }
        final updatedPost = state.post?.copyWith(
          commentCount: _calculateTotalComments(updatedComments),
        );
        state = state.copyWith(comments: updatedComments, post: updatedPost);
        // Load lại ngầm trong nền không bật spinner toàn bộ
        loadComments(postId, showLoading: false);
        return true;
      },
      err: (failure) {
        state = state.copyWith(errorMessage: failure.message);
        return false;
      },
    );
  }

  List<CommentEntity> _updateCommentInList(
    List<CommentEntity> list,
    String targetId,
    CommentEntity Function(CommentEntity) update,
  ) {
    return list.map((c) {
      if (c.id == targetId) {
        return update(c);
      }
      if (c.replies.isNotEmpty) {
        return c.copyWith(
          replies: _updateCommentInList(c.replies, targetId, update),
        );
      }
      return c;
    }).toList();
  }

  CommentEntity _toggleReactionOnComment(
    CommentEntity comment,
    ReactionType targetReaction,
  ) {
    final current = comment.currentUserReaction;
    final isSame = current == targetReaction;
    final newReaction = isSame ? null : targetReaction;

    final details = Map<ReactionType, int>.from(comment.reactionDetails);
    int total = comment.reactionCount;

    if (current != null) {
      final cnt = details[current] ?? 1;
      if (cnt <= 1) {
        details.remove(current);
      } else {
        details[current] = cnt - 1;
      }
      total = (total - 1).clamp(0, 999999);
    }

    if (newReaction != null) {
      details[newReaction] = (details[newReaction] ?? 0) + 1;
      total += 1;
    }

    return comment.copyWith(
      currentUserReaction: newReaction,
      isLiked: newReaction != null,
      reactionCount: total,
      reactionDetails: details,
    );
  }

  Future<void> toggleCommentReaction(
    String commentId,
    ReactionType reaction,
  ) async {
    if (_reactingCommentIds.contains(commentId)) return;
    _reactingCommentIds.add(commentId);

    final previousComments = state.comments;

    // 1. Optimistic Update UI ngay tức thì
    state = state.copyWith(
      comments: _updateCommentInList(
        state.comments,
        commentId,
        (c) => _toggleReactionOnComment(c, reaction),
      ),
    );

    try {
      // 2. Gọi API Backend
      final result = await ref
          .read(toggleCommentReactionUseCaseProvider)
          .call(commentId, reactionType: reaction);

      result.when(
        ok: (reactionResult) {
          state = state.copyWith(
            comments: _updateCommentInList(
              state.comments,
              commentId,
              (c) => c.copyWith(
                currentUserReaction: reactionResult.currentUserReaction,
                isLiked: reactionResult.currentUserReaction != null,
                reactionCount: reactionResult.totalReactions,
                reactionDetails: reactionResult.reactionDetails,
              ),
            ),
          );
        },
        err: (failure) {
          AppLogger.instance.e(
            'toggleCommentReaction failed: ${failure.message}',
          );
          state = state.copyWith(
            comments: previousComments,
            errorMessage: failure.message,
          );
        },
      );
    } finally {
      _reactingCommentIds.remove(commentId);
    }
  }

  // Tương thích ngược với các caller cũ nếu có
  Future<void> reactToComment(
    String commentId,
    ReactionType reaction, {
    String? parentId,
  }) => toggleCommentReaction(commentId, reaction);

  Future<void> clearCommentReaction(
    String commentId, {
    String? parentId,
  }) async {
    CommentEntity? target;
    void findComment(List<CommentEntity> list) {
      for (final c in list) {
        if (c.id == commentId) {
          target = c;
          return;
        }
        findComment(c.replies);
        if (target != null) return;
      }
    }

    findComment(state.comments);
    if (target?.currentUserReaction != null) {
      await toggleCommentReaction(commentId, target!.currentUserReaction!);
    }
  }

  Future<void> toggleCommentLike(String commentId, {String? parentId}) =>
      toggleCommentReaction(commentId, ReactionType.like);

  Future<bool> deleteComment(
    CommentEntity comment, {
    String? parentId,
    required String postId,
  }) async {
    final result = await ref
        .read(deleteCommentUseCaseProvider)
        .call(comment.id);

    return result.when(
      ok: (_) {
        List<CommentEntity> updatedComments;
        if (parentId != null) {
          updatedComments = state.comments.map((c) {
            if (c.id == parentId) {
              final updatedReplies = c.replies
                  .where((r) => r.id != comment.id)
                  .toList();
              return c.copyWith(replies: updatedReplies);
            }
            return c;
          }).toList();
        } else {
          updatedComments = state.comments
              .where((c) => c.id != comment.id)
              .toList();
        }

        final updatedPost = state.post?.copyWith(
          commentCount: _calculateTotalComments(updatedComments),
        );

        state = state.copyWith(comments: updatedComments, post: updatedPost);

        ref
            .read(communityControllerProvider.notifier)
            .updateCommentCount(
              postId,
              explicitCount: state.totalCommentsCount,
            );
        return true;
      },
      err: (failure) {
        state = state.copyWith(errorMessage: failure.message);
        return false;
      },
    );
  }
}
