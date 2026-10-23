import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/core/theme/app_spacing.dart';
import 'package:rental_car/core/widgets/widgets.dart';
import 'package:rental_car/features/auth/presentation/providers/auth_controller.dart';
import 'package:rental_car/features/community/presentation/providers/community_providers.dart';
import 'package:rental_car/features/community/presentation/widgets/create_post/create_post_header_info.dart';
import 'package:rental_car/features/community/presentation/widgets/create_post/create_post_tags_selector.dart';

/// Màn hình Tạo bài viết thảo luận môn học
class CreatePostPage extends ConsumerStatefulWidget {
  const CreatePostPage({super.key});

  @override
  ConsumerState<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends ConsumerState<CreatePostPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  final List<String> _tags = ['SWP391'];
  bool _isSubmitting = false;

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  bool get _canSubmit =>
      _contentController.text.trim().isNotEmpty && !_isSubmitting;

  Future<void> _handleSubmit() async {
    final content = _contentController.text.trim();
    if (content.isEmpty) return;

    final title = _titleController.text.trim().isNotEmpty
        ? _titleController.text.trim()
        : (content.length > 50 ? '${content.substring(0, 50)}...' : content);

    setState(() => _isSubmitting = true);

    final success = await ref
        .read(communityControllerProvider.notifier)
        .createPost(title: title, content: content, tags: _tags);

    if (!mounted) return;
    setState(() => _isSubmitting = false);

    if (success) {
      context.showSuccessSnackBar('Đăng bài viết thành công!');
      context.pop();
    } else {
      context.showErrorSnackBar('Không thể đăng bài. Vui lòng thử lại!');
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authControllerProvider).user;
    final userName = user?.fullName ?? user?.displayName ?? 'Sinh viên';
    final displayName = user?.fullName?.split(' ').last ?? 'bạn';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 1,
        leading: IconButton(
          icon: const Icon(
            Icons.close_rounded,
            color: Color(0xFF334155),
            size: 24,
          ),
          onPressed: () => context.pop(),
        ),
        centerTitle: true,
        title: const Text(
          'Tạo bài viết',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Color(0xFF0F172A),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: ElevatedButton(
              onPressed: _canSubmit ? _handleSubmit : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                disabledBackgroundColor: AppColors.primary.withAlpha(80),
                foregroundColor: Colors.white,
                disabledForegroundColor: Colors.white70,
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: _isSubmitting
                  ? const SizedBox(
                      width: 14,
                      height: 14,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text(
                      'Đăng',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            CreatePostHeaderInfo(
              userName: userName,
              avatarUrl: user?.avatarUrl,
              isPlus: user?.isPlus == true,
            ),

            const Gap(AppSpacing.md),

            // 2. Tiêu đề
            TextField(
              controller: _titleController,
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

            // 3. Nội dung
            TextField(
              controller: _contentController,
              minLines: 5,
              maxLines: 12,
              onChanged: (_) => setState(() {}),
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

            const Gap(16),

            // 4. Thẻ môn học gợi ý và thêm mới
            CreatePostTagsSelector(
              selectedTags: _tags,
              suggestedTags: ref.watch(communityControllerProvider).tags,
              onAddTag: (tag) => setState(() => _tags.add(tag)),
              onRemoveTag: (tag) => setState(() => _tags.remove(tag)),
              onOpenAddDialog: _showAddTagDialog,
            ),
          ],
        ),
      ),
    );
  }

  void _showAddTagDialog() {
    final tagCtrl = TextEditingController();
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
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
                color: const Color(0xFFDCFCE7),
                borderRadius: BorderRadius.circular(12),
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
                color: Color(0xFF0F172A),
              ),
            ),
          ],
        ),
        content: TextField(
          controller: tagCtrl,
          autofocus: true,
          style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600),
          decoration: InputDecoration(
            hintText: 'Nhập mã môn (ví dụ: MAS291, PRO192)...',
            hintStyle: const TextStyle(
              fontSize: 12.5,
              color: Color(0xFF94A3B8),
            ),
            prefixText: '# ',
            prefixStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: AppColors.primary,
            ),
            filled: true,
            fillColor: const Color(0xFFF8FAFC),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(
                color: AppColors.primary,
                width: 1.5,
              ),
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
                      side: const BorderSide(color: Color(0xFFE2E8F0)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () => Navigator.pop(ctx),
                    child: const Text(
                      'Hủy',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF64748B),
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
                      final newTag = tagCtrl.text.trim().replaceAll('#', '');
                      if (newTag.isNotEmpty && !_tags.contains(newTag)) {
                        setState(() => _tags.add(newTag));
                      }
                      Navigator.pop(ctx);
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
      ),
    );
  }
}
