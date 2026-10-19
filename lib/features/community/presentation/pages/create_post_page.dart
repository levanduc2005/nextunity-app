import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/core/theme/app_spacing.dart';
import 'package:rental_car/core/widgets/widgets.dart';
import 'package:rental_car/features/auth/presentation/providers/auth_controller.dart';
import 'package:rental_car/features/community/presentation/providers/community_providers.dart';
import 'package:rental_car/features/community/presentation/widgets/create_post/community_models.dart';
import 'package:rental_car/features/community/presentation/widgets/create_post/create_post_attachment_card.dart';
import 'package:rental_car/features/community/presentation/widgets/create_post/create_post_bottom_bar.dart';
import 'package:rental_car/features/community/presentation/widgets/create_post/create_post_header_info.dart';
import 'package:rental_car/features/community/presentation/widgets/create_post/create_post_tags_selector.dart';

/// Màn hình Tạo bài viết thảo luận (Chuẩn phong cách Facebook Modal)
class CreatePostPage extends ConsumerStatefulWidget {
  const CreatePostPage({super.key});

  @override
  ConsumerState<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends ConsumerState<CreatePostPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  String _privacy = 'Công khai';
  final List<String> _tags = ['SWP391'];
  String? _attachedFileName;
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
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(AppSpacing.md),
                children: [
                  CreatePostHeaderInfo(
                    userName: userName,
                    avatarUrl: user?.avatarUrl,
                    privacy: _privacy,
                    onPickPrivacy: () {
                      showPrivacyPickerModal(
                        context: context,
                        currentPrivacy: _privacy,
                        onSelect: (p) => setState(() => _privacy = p),
                      );
                    },
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
                          '$displayName ơi, bạn đang cần hỏi đáp môn học gì thế? Chia sẻ câu hỏi, tài liệu hoặc kinh nghiệm đồ án...',
                      hintStyle: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF94A3B8),
                        height: 1.4,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),

                  // 4. File đính kèm Preview (nếu có)
                  if (_attachedFileName != null) ...[
                    const Gap(12),
                    CreatePostAttachmentCard(
                      fileName: _attachedFileName!,
                      onRemove: () => setState(() => _attachedFileName = null),
                    ),
                  ],

                  const Gap(16),

                  // 5. Thẻ môn học gợi ý nhanh
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

            // 6. Thanh công cụ ở đáy màn hình
            CreatePostBottomBar(
              onAddPhoto: () {
                setState(
                  () => _attachedFileName = 'Screenshot_Jira_Sprint.png',
                );
                context.showInfoSnackBar('Đã thêm ảnh minh họa bài viết.');
              },
              onAddFile: () {
                setState(
                  () =>
                      _attachedFileName = 'Tai_Lieu_On_Thi_SWP391_Sprint2.pdf',
                );
                context.showInfoSnackBar('Đã đính kèm tệp PDF.');
              },
              onAddTag: _showAddTagDialog,
              onAddPoll: () {
                context.showInfoSnackBar('Tính năng bình chọn sẽ có mặt sớm!');
              },
              onAddFeeling: () {
                context.showInfoSnackBar('Đang cập nhật biểu tượng cảm xúc.');
              },
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
        title: const Text('Thêm thẻ môn học'),
        content: TextField(
          controller: tagCtrl,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Nhập mã môn (ví dụ: MAS291, PRO192)...',
            prefixText: '#',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () {
              final newTag = tagCtrl.text.trim().replaceAll('#', '');
              if (newTag.isNotEmpty && !_tags.contains(newTag)) {
                setState(() => _tags.add(newTag));
              }
              Navigator.pop(ctx);
            },
            child: const Text('Thêm'),
          ),
        ],
      ),
    );
  }
}
