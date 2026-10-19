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
    this.onAttachFile,
  });

  final TextEditingController commentController;
  final FocusNode commentFocusNode;
  final String currentUserName;
  final String? currentUserAvatarUrl;
  final CommentEntity? replyTarget;
  final VoidCallback onCancelReply;
  final VoidCallback onSend;
  final VoidCallback? onAttachFile;

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
              color: const Color(0xFFEFF6FF),
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
                _buildAvatar(
                  currentUserAvatarUrl,
                  currentUserName.isNotEmpty ? currentUserName[0] : 'U',
                ),
                const Gap.h(8),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F2F5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Expanded(
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
                        IconButton(
                          icon: const Icon(
                            Icons.attach_file_rounded,
                            size: 18,
                            color: Color(0xFF64748B),
                          ),
                          onPressed:
                              onAttachFile ??
                              () {
                                context.showInfoSnackBar(
                                  'Đính kèm ảnh vào bình luận.',
                                );
                              },
                          visualDensity: VisualDensity.compact,
                        ),
                      ],
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
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
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
