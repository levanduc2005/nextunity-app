import 'package:flutter/material.dart';
import 'package:rental_car/core/widgets/widgets.dart';

/// Thẻ hiển thị tệp đính kèm khi soạn bài viết
class CreatePostAttachmentCard extends StatelessWidget {
  const CreatePostAttachmentCard({
    super.key,
    required this.fileName,
    required this.onRemove,
  });

  final String fileName;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final isPdf = fileName.endsWith('.pdf');

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: isPdf ? const Color(0xFFFEE2E2) : const Color(0xFFEEF2FF),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              isPdf ? Icons.picture_as_pdf_rounded : Icons.folder_zip_rounded,
              color: isPdf ? const Color(0xFFDC2626) : const Color(0xFF3D5AFE),
              size: 20,
            ),
          ),
          const Gap.h(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fileName,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0F172A),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const Text(
                  '2.1 MB • Sẵn sàng tải lên',
                  style: TextStyle(fontSize: 11, color: Color(0xFF64748B)),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.close_rounded,
              size: 18,
              color: Color(0xFF64748B),
            ),
            onPressed: onRemove,
          ),
        ],
      ),
    );
  }
}
