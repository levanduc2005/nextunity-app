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
            color: AppColors.textPrimary,
          ),
          decoration: const InputDecoration(
            hintText: 'Tiêu đề bài viết (tùy chọn)...',
            hintStyle: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: AppColors.textMuted,
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.surfaceSubtle),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.surfaceSubtle),
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
            color: AppColors.textDark,
          ),
          decoration: InputDecoration(
            hintText:
                '$displayName ơi, bạn đang cần hỏi đáp môn học gì thế? Chia sẻ câu hỏi hoặc kinh nghiệm môn học...',
            hintStyle: const TextStyle(
              fontSize: 14,
              color: AppColors.textMuted,
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
