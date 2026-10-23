import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/core/widgets/widgets.dart';
import 'package:rental_car/features/community/domain/entities/comment_entity.dart';

/// Thanh nhập bình luận cố định ở đáy màn hình theo phong cách Facebook
class PostDetailCommentInputBar extends StatelessWidget {
  const PostDetailCommentInputBar({
    super.key,
    required this.commentController,
    required this.commentFocusNode,
    required this.currentUserName,
    this.currentUserAvatarUrl,
    this.replyTarget,
    required this.onCancelReply,
    required this.onSend,
    this.isPlus = false,
  });

  final TextEditingController commentController;
  final FocusNode commentFocusNode;
  final String currentUserName;
  final String? currentUserAvatarUrl;
  final CommentEntity? replyTarget;
  final VoidCallback onCancelReply;
  final VoidCallback onSend;
  final bool isPlus;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Banner "Đang trả lời @..." (khi nhấn Trả lời)
          if (replyTarget != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              color: AppColors.primaryContainer,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.reply_rounded,
                        size: 14,
                        color: AppColors.primary,
                      ),
                      const Gap.h(4),
                      Text(
                        'Đang trả lời @${replyTarget!.authorName}',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: onCancelReply,
                    child: const Icon(
                      Icons.close_rounded,
                      size: 16,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),

          // Thanh input nhập bình luận
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                AppAvatar(
                  name: currentUserName,
                  imageUrl: currentUserAvatarUrl,
                  radius: 16,
                  isPlus: isPlus,
                ),
                const Gap.h(8),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F2F5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextField(
                      controller: commentController,
                      focusNode: commentFocusNode,
                      style: const TextStyle(fontSize: 13),
                      decoration: InputDecoration(
                        hintText: replyTarget != null
                            ? 'Trả lời @${replyTarget!.authorName}...'
                            : 'Viết bình luận công khai...',
                        hintStyle: const TextStyle(
                          fontSize: 12.5,
                          color: Color(0xFF94A3B8),
                        ),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                      ),
                      onSubmitted: (_) => onSend(),
                    ),
                  ),
                ),
                const Gap.h(8),
                InkWell(
                  onTap: onSend,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.send_rounded,
                      color: Colors.white,
                      size: 17,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
