import 'package:flutter/material.dart';
import 'package:rental_car/core/widgets/widgets.dart';

/// Trạng thái rỗng của Bảng tin cộng đồng khi không có bài viết
class CommunityFeedEmptyState extends StatelessWidget {
  const CommunityFeedEmptyState({super.key, required this.selectedTag});

  final String selectedTag;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 24),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.forum_outlined, size: 48, color: Colors.grey.shade400),
          const Gap(12),
          Text(
            selectedTag != 'Tất cả'
                ? 'Chưa có bài viết nào với thẻ $selectedTag'
                : 'Chưa có bài viết nào trong cộng đồng',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          ),
          const Gap(8),
          const Text(
            'Hãy là người đầu tiên đặt câu hỏi hoặc chia sẻ tài liệu!',
            style: TextStyle(fontSize: 12, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
