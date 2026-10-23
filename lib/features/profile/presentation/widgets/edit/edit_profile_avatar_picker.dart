import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/core/widgets/widgets.dart';
import 'package:rental_car/features/auth/domain/entities/user_entity.dart';
import 'package:rental_car/features/profile/presentation/providers/profile_providers.dart';
import 'package:rental_car/features/profile/presentation/widgets/common/image_picker_bottom_sheet.dart';

class EditProfileAvatarPicker extends ConsumerWidget {
  const EditProfileAvatarPicker({super.key, required this.user});

  final UserEntity? user;

  Future<void> _pickAvatar(BuildContext context, WidgetRef ref) async {
    final filePath = await ImagePickerBottomSheet.show(context);
    if (filePath == null || filePath.isEmpty) return;

    final success = await ref
        .read(profileControllerProvider.notifier)
        .changeAvatar(filePath);

    if (context.mounted) {
      if (success) {
        context.showSnackBar(
          'Đã cập nhật ảnh đại diện mới thành công!',
          type: SnackType.success,
        );
      } else {
        final error =
            ref.read(profileControllerProvider).errorMessage ??
            'Tải ảnh lên thất bại. Vui lòng thử lại!';
        context.showSnackBar(error, type: SnackType.error);
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileControllerProvider);
    final isUploading = profileState.isUploadingAvatar;
    final avatarUrl = user?.avatarUrl;
    final displayName = user?.displayName ?? 'User';
    final isPlus = user?.isPlus == true;

    return Column(
      children: [
        AppAvatar(
          name: displayName,
          imageUrl: avatarUrl,
          radius: 44,
          isPlus: isPlus,
          isUploading: isUploading,
          showCameraBadge: !isPlus,
          onTap: isUploading ? null : () => _pickAvatar(context, ref),
          onCameraTap: isUploading ? null : () => _pickAvatar(context, ref),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: isUploading ? null : () => _pickAvatar(context, ref),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.edit_outlined, size: 13, color: AppColors.iconPrimary),
              SizedBox(width: 4),
              Text(
                'Chạm để đổi ảnh đại diện',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
