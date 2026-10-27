import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_car/core/widgets/widgets.dart';
import 'package:rental_car/features/community/domain/entities/post_entity.dart';
import 'package:rental_car/features/community/presentation/widgets/common/post_options_bottom_sheet.dart';

/// AppBar chuẩn mạng xã hội cho màn hình Chi tiết bài viết
class PostDetailAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PostDetailAppBar({
    super.key,
    required this.post,
    required this.canDelete,
    required this.onDeletePost,
  });

  final PostEntity? post;
  final bool canDelete;
  final VoidCallback onDeletePost;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
              'Tác giả: ${post!.displayAuthor}',
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
          onPressed: () {
            PostOptionsBottomSheet.show(
              context,
              canDelete: canDelete,
              onCopyLink: () =>
                  context.showSnackBar('Đã sao chép liên kết bài viết!'),
              onDelete: canDelete ? onDeletePost : null,
            );
          },
        ),
      ],
    );
  }
}
