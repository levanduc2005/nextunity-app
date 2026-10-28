import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';

/// Hộp thoại nhập và thêm thẻ tag môn học mới cho bài viết
class AddTagDialog extends StatefulWidget {
  const AddTagDialog({super.key, required this.onTagAdded});

  final ValueChanged<String> onTagAdded;

  static Future<void> show(
    BuildContext context, {
    required ValueChanged<String> onTagAdded,
  }) {
    return showDialog<void>(
      context: context,
      builder: (_) => AddTagDialog(onTagAdded: onTagAdded),
    );
  }

  @override
  State<AddTagDialog> createState() => _AddTagDialogState();
}

class _AddTagDialogState extends State<AddTagDialog> {
  final TextEditingController _tagCtrl = TextEditingController();

  @override
  void dispose() {
    _tagCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      titlePadding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      actionsPadding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primaryContainer,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.primaryBorder),
            ),
            child: const Icon(
              Icons.tag_rounded,
              color: AppColors.primary,
              size: 20,
            ),
          ),
          const SizedBox(width: 10),
          const Text(
            'Thêm thẻ môn học',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 16,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
      content: TextField(
        controller: _tagCtrl,
        autofocus: true,
        style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600),
        decoration: InputDecoration(
          hintText: 'Nhập mã môn (ví dụ: MAS291, PRO192)...',
          hintStyle: const TextStyle(fontSize: 12.5, color: AppColors.textMuted),
          prefixText: '# ',
          prefixStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: AppColors.primary,
          ),
          filled: true,
          fillColor: AppColors.surfaceLight,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 12,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: AppColors.border),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: AppColors.border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
          ),
        ),
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 42,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.border),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'Hủy',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: SizedBox(
                height: 42,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    final newTag = _tagCtrl.text.trim().replaceAll('#', '');
                    if (newTag.isNotEmpty) {
                      widget.onTagAdded(newTag);
                    }
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Thêm thẻ',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
