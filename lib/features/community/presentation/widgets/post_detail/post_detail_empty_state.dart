import 'package:flutter/material.dart';
import 'package:rental_car/core/widgets/widgets.dart';

/// Trạng thái lỗi không tìm thấy bài viết hoặc bài viết đã bị xóa
class PostDetailEmptyState extends StatelessWidget {
  const PostDetailEmptyState({super.key, required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline_rounded, size: 48, color: Colors.grey),
          const Gap(12),
          const Text(
            'Không tìm thấy bài viết hoặc bài viết đã bị xóa.',
            style: TextStyle(color: Colors.grey),
          ),
          const Gap(12),
          ElevatedButton(onPressed: onRetry, child: const Text('Thử lại')),
        ],
      ),
    );
  }
}
