import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';

/// Thanh công cụ "Thêm vào bài viết" ở đáy màn hình
class CreatePostBottomBar extends StatelessWidget {
  const CreatePostBottomBar({
    super.key,
    required this.onAddPhoto,
    required this.onAddFile,
    required this.onAddTag,
    required this.onAddPoll,
    required this.onAddFeeling,
  });

  final VoidCallback onAddPhoto;
  final VoidCallback onAddFile;
  final VoidCallback onAddTag;
  final VoidCallback onAddPoll;
  final VoidCallback onAddFeeling;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: const [
            BoxShadow(
              color: Color(0x06000000),
              blurRadius: 4,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Thêm vào bài viết',
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w700,
                color: Color(0xFF334155),
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.photo_library_rounded,
                    color: Color(0xFF10B981),
                    size: 22,
                  ),
                  onPressed: onAddPhoto,
                  tooltip: 'Ảnh/Video',
                ),
                IconButton(
                  icon: const Icon(
                    Icons.description_rounded,
                    color: Color(0xFFEF4444),
                    size: 22,
                  ),
                  onPressed: onAddFile,
                  tooltip: 'Đính kèm tệp',
                ),
                IconButton(
                  icon: const Icon(
                    Icons.tag_rounded,
                    color: AppColors.primary,
                    size: 22,
                  ),
                  onPressed: onAddTag,
                  tooltip: 'Gắn thẻ môn học',
                ),
                IconButton(
                  icon: const Icon(
                    Icons.poll_rounded,
                    color: Color(0xFFF59E0B),
                    size: 22,
                  ),
                  onPressed: onAddPoll,
                  tooltip: 'Thăm dò ý kiến',
                ),
                IconButton(
                  icon: const Icon(
                    Icons.sentiment_satisfied_rounded,
                    color: Color(0xFFFBBF24),
                    size: 22,
                  ),
                  onPressed: onAddFeeling,
                  tooltip: 'Cảm xúc',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
