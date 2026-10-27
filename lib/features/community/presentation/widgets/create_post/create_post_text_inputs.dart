import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/core/widgets/widgets.dart';

/// Cụm trường nhập Tiêu đề và Nội dung bài viết thảo luận
class CreatePostTextInputs extends StatelessWidget {
  const CreatePostTextInputs({
    super.key,
    required this.titleController,
    required this.contentController,
    required this.displayName,
    required this.onContentChanged,
  });

  final TextEditingController titleController;
  final TextEditingController contentController;
  final String displayName;
  final ValueChanged<String> onContentChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // 1. Tiêu đề
        TextField(
          controller: titleController,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Color(0xFF0F172A),
          ),
          decoration: const InputDecoration(
            hintText: 'Tiêu đề bài viết (tùy chọn)...',
            hintStyle: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Color(0xFF94A3B8),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFF1F5F9)),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFF1F5F9)),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.primary),
            ),
            contentPadding: EdgeInsets.only(bottom: 8),
          ),
        ),

        const Gap(8),

        // 2. Nội dung
        TextField(
          controller: contentController,
          minLines: 5,
          maxLines: 12,
          onChanged: onContentChanged,
          style: const TextStyle(
            fontSize: 14.5,
            height: 1.45,
            color: Color(0xFF1E293B),
          ),
          decoration: InputDecoration(
            hintText:
                '$displayName ơi, bạn đang cần hỏi đáp môn học gì thế? Chia sẻ câu hỏi hoặc kinh nghiệm môn học...',
            hintStyle: const TextStyle(
              fontSize: 14,
              color: Color(0xFF94A3B8),
              height: 1.4,
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.zero,
          ),
        ),
      ],
    );
  }
}
