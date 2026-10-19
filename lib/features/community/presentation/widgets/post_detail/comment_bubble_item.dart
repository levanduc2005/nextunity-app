import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/core/widgets/widgets.dart';
import 'package:rental_car/features/community/domain/entities/comment_entity.dart';

/// Widget hiển thị 1 bình luận dạng bong bóng chat xám Facebook (hỗ trợ cả reply con lồng nhau)
class CommentBubbleItem extends StatelessWidget {
  const CommentBubbleItem({
    super.key,
    required this.comment,
    required this.onLike,
    required this.onReply,
    required this.onLikeReply,
    required this.onReplyToChild,
  });

  final CommentEntity comment;
  final VoidCallback onLike;
  final VoidCallback onReply;
  final void Function(String replyId) onLikeReply;
  final void Function(CommentEntity child) onReplyToChild;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bình luận cha
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAvatar(comment.authorAvatar, comment.initials),
              const Gap.h(8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Bong bóng chat xám chuẩn Facebook
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0F2F5),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                comment.authorName,
                                style: const TextStyle(
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF0F172A),
                                ),
                              ),
                              if (comment.authorBadge != null) ...[
                                const Gap.h(6),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 5,
                                    vertical: 1,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE2E8F0),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    comment.authorBadge!,
                                    style: const TextStyle(
                                      fontSize: 9.5,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF475569),
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                          const Gap(2),
                          Text(
                            comment.content,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Color(0xFF1E293B),
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Sub-actions: Thời gian, Thích, Trả lời
                    Padding(
                      padding: const EdgeInsets.only(left: 8, top: 4),
                      child: Row(
                        children: [
                          Text(
                            comment.formattedTime,
                            style: const TextStyle(
                              fontSize: 11,
                              color: Color(0xFF64748B),
                            ),
                          ),
                          const Gap.h(12),
                          InkWell(
                            onTap: onLike,
                            child: Text(
                              'Thích',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: comment.isLiked
                                    ? AppColors.primary
                                    : const Color(0xFF64748B),
                              ),
                            ),
                          ),
                          const Gap.h(12),
                          InkWell(
                            onTap: onReply,
                            child: const Text(
                              'Trả lời',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF64748B),
                              ),
                            ),
                          ),
                          if (comment.reactionCount > 0) ...[
                            const Gap.h(10),
                            Row(
                              children: [
                                const Text(
                                  '👍',
                                  style: TextStyle(fontSize: 10),
                                ),
                                const Gap.h(2),
                                Text(
                                  '${comment.reactionCount}',
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Color(0xFF64748B),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Bình luận con (Nested Replies)
          if (comment.replies.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(left: 36, top: 8),
              child: Column(
                children: comment.replies.map((reply) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildAvatar(
                          reply.authorAvatar,
                          reply.initials,
                          radius: 14,
                        ),
                        const Gap.h(8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF0F2F5),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          reply.authorName,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                            color: Color(0xFF0F172A),
                                          ),
                                        ),
                                        if (reply.authorBadge != null) ...[
                                          const Gap.h(6),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 5,
                                              vertical: 1,
                                            ),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFDBEAFE),
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            child: Text(
                                              reply.authorBadge!,
                                              style: const TextStyle(
                                                fontSize: 9.5,
                                                fontWeight: FontWeight.w800,
                                                color: AppColors.primary,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                    const Gap(2),
                                    Text(
                                      reply.content,
                                      style: const TextStyle(
                                        fontSize: 12.5,
                                        color: Color(0xFF1E293B),
                                        height: 1.4,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8, top: 4),
                                child: Row(
                                  children: [
                                    Text(
                                      reply.formattedTime,
                                      style: const TextStyle(
                                        fontSize: 11,
                                        color: Color(0xFF64748B),
                                      ),
                                    ),
                                    const Gap.h(12),
                                    InkWell(
                                      onTap: () => onLikeReply(reply.id),
                                      child: Text(
                                        'Thích',
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w700,
                                          color: reply.isLiked
                                              ? AppColors.primary
                                              : const Color(0xFF64748B),
                                        ),
                                      ),
                                    ),
                                    const Gap.h(12),
                                    InkWell(
                                      onTap: () => onReplyToChild(reply),
                                      child: const Text(
                                        'Trả lời',
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xFF64748B),
                                        ),
                                      ),
                                    ),
                                    if (reply.reactionCount > 0) ...[
                                      const Gap.h(10),
                                      Row(
                                        children: [
                                          const Text(
                                            '❤️',
                                            style: TextStyle(fontSize: 10),
                                          ),
                                          const Gap.h(2),
                                          Text(
                                            '${reply.reactionCount}',
                                            style: const TextStyle(
                                              fontSize: 11,
                                              color: Color(0xFF64748B),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAvatar(String? avatarUrl, String initial, {double radius = 16}) {
    if (avatarUrl != null && avatarUrl.isNotEmpty) {
      return CircleAvatar(
        radius: radius,
        backgroundColor: const Color(0xFF3D5AFE),
        backgroundImage: NetworkImage(avatarUrl),
        onBackgroundImageError: (_, _) {},
        child: Text(
          initial.toUpperCase(),
          style: TextStyle(
            color: Colors.white,
            fontSize: radius * 0.75,
            fontWeight: FontWeight.w700,
          ),
        ),
      );
    }

    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [Color(0xFF3D5AFE), Color(0xFF60A5FA)],
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        initial.toUpperCase(),
        style: TextStyle(
          color: Colors.white,
          fontSize: radius * 0.75,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
