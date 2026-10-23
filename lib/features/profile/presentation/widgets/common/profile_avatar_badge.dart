import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_car/core/widgets/widgets.dart';
import 'package:rental_car/features/profile/presentation/providers/profile_providers.dart';
import 'package:rental_car/features/profile/presentation/widgets/common/image_picker_bottom_sheet.dart';

class ProfileAvatarBadge extends ConsumerWidget {
  const ProfileAvatarBadge({
    super.key,
    this.avatarUrl,
    this.displayName,
    this.radius = 42,
    this.isPlus = false,
  });

  final String? avatarUrl;
  final String? displayName;
  final double radius;
  final bool isPlus;

  Future<void> _pickAndChangeAvatar(BuildContext context, WidgetRef ref) async {
    final filePath = await ImagePickerBottomSheet.show(context);
    if (filePath == null || filePath.isEmpty) return;

    final success = await ref
        .read(profileControllerProvider.notifier)
        .changeAvatar(filePath);

    if (context.mounted) {
      if (success) {
        context.showSnackBar(
          'Đã cập nhật ảnh đại diện thành công!',
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
    final state = ref.watch(profileControllerProvider);
    final isUploading = state.isUploadingAvatar;

    return AppAvatar(
      name: displayName ?? 'U',
      imageUrl: avatarUrl,
      radius: radius,
      isPlus: isPlus,
      isUploading: isUploading,
      showCameraBadge: !isPlus,
      onTap: isUploading ? null : () => _pickAndChangeAvatar(context, ref),
      onCameraTap: isUploading
          ? null
          : () => _pickAndChangeAvatar(context, ref),
    );
  }
}
