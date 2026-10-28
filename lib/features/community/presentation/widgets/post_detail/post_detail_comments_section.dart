import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/core/theme/app_spacing.dart';
import 'package:rental_car/core/widgets/widgets.dart';
import 'package:rental_car/features/community/domain/entities/comment_entity.dart';
import 'package:rental_car/features/community/domain/entities/reaction_type.dart';
import 'package:rental_car/features/community/presentation/widgets/post_detail/comment_bubble_item.dart';

/// Phần hiển thị danh sách tất cả bình luận trong trang chi tiết bài viết
class PostDetailCommentsSection extends StatelessWidget {
  const PostDetailCommentsSection({
    super.key,
    required this.comments,
    required this.isLoading,
    required this.totalCommentsCount,
    this.currentUserId,
    this.currentUserName,
    this.currentUserRole,
    this.postAuthorId,
    this.postAuthorName,
    required this.onReplyComment,
    required this.onToggleReaction,
    required this.onDeleteComment,
  });

  final List<CommentEntity> comments;
  final bool isLoading;
  final int totalCommentsCount;
  final String? currentUserId;
  final String? currentUserName;
  final String? currentUserRole;
  final String? postAuthorId;
  final String? postAuthorName;

  final ValueChanged<CommentEntity> onReplyComment;
  final void Function(String commentId, ReactionType reaction) onToggleReaction;
  final void Function(CommentEntity comment, {String? parentId})
  onDeleteComment;

  bool _canDeleteComment(String? authorId, String? authorName) {
    if (currentUserRole?.toUpperCase() == 'ADMIN') return true;
    if (currentUserId != null && authorId != null) {
      if (currentUserId!.toLowerCase() == authorId.toLowerCase()) return true;
    }
    if (currentUserName != null && authorName != null) {
      if (currentUserName!.trim().toLowerCase() ==
          authorName.trim().toLowerCase()) {
        return true;
      }
    }
    if (currentUserId != null && postAuthorId != null) {
      if (currentUserId!.toLowerCase() == postAuthorId!.toLowerCase()) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header bình luận
          Text(
            'Tất cả bình luận ($totalCommentsCount)',
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          const Gap(14),

          // Trạng thái Loading / Empty / List
          if (isLoading)
            const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.primary,
                ),
              ),
            )
          else if (comments.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: Center(
                child: Text(
                  'Chưa có bình luận nào. Hãy là người đầu tiên bình luận!',
                  style: TextStyle(color: AppColors.textMuted, fontSize: 13),
                ),
              ),
            )
          else
            ...comments.map(
              (comment) => CommentBubbleItem(
                comment: comment,
                canDelete: _canDeleteComment(
                  comment.authorId,
                  comment.authorName,
                ),
                onDelete: () => onDeleteComment(comment),
                canDeleteReply: (reply) =>
                    _canDeleteComment(reply.authorId, reply.authorName),
                onDeleteReply: (reply) =>
                    onDeleteComment(reply, parentId: comment.id),
                onToggleReaction: onToggleReaction,
                onReply: () => onReplyComment(comment),
                onReplyToChild: (child) => onReplyComment(child),
              ),
            ),
        ],
      ),
    );
  }
}
