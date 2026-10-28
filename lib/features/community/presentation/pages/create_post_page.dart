import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/core/theme/app_spacing.dart';
import 'package:rental_car/core/widgets/widgets.dart';
import 'package:rental_car/features/auth/presentation/providers/auth_controller.dart';
import 'package:rental_car/features/community/presentation/providers/community_providers.dart';
import 'package:rental_car/features/community/presentation/widgets/create_post/add_tag_dialog.dart';
import 'package:rental_car/features/community/presentation/widgets/create_post/create_post_header_info.dart';
import 'package:rental_car/features/community/presentation/widgets/create_post/create_post_tags_selector.dart';
import 'package:rental_car/features/community/presentation/widgets/create_post/create_post_text_inputs.dart';

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

  void _showAddTagDialog() {
    AddTagDialog.show(
      context,
      onTagAdded: (newTag) {
        if (!_tags.contains(newTag)) {
          setState(() => _tags.add(newTag));
        }
      },
    );
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
            color: AppColors.textLabel,
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
            color: AppColors.textPrimary,
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
            // 1. Header tác giả
            CreatePostHeaderInfo(
              userName: userName,
              avatarUrl: user?.avatarUrl,
              isPlus: user?.isPlus == true,
            ),
            const Gap(AppSpacing.md),

            // 2. Ô nhập Tiêu đề & Nội dung
            CreatePostTextInputs(
              titleController: _titleController,
              contentController: _contentController,
              displayName: displayName,
              onContentChanged: (_) => setState(() {}),
            ),
            const Gap(16),

            // 3. Thẻ môn học gợi ý và thêm mới
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
}
