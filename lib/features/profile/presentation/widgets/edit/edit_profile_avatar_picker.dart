import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_car/core/widgets/widgets.dart';
import 'package:rental_car/features/auth/domain/entities/user_entity.dart';
import 'package:rental_car/features/profile/presentation/providers/profile_providers.dart';
import 'package:rental_car/features/profile/presentation/widgets/common/profile_common.dart';

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

    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            // Vòng Gradient Avatar cao cấp
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF2563EB),
                    Color(0xFF60A5FA),
                    Color(0xFF38BDF8),
                  ],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF2563EB).withValues(alpha: 0.28),
                    blurRadius: 14,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Container(
                width: 88,
                height: 88,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFEFF6FF),
                  border: Border.all(color: Colors.white, width: 2.5),
                ),
                child: ClipOval(
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      if (avatarUrl != null && avatarUrl.isNotEmpty)
                        Image.network(
                          avatarUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (_, _, _) =>
                              _AvatarInitial(name: displayName),
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return const Center(
                              child: SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                            );
                          },
                        )
                      else
                        _AvatarInitial(name: displayName),

                      if (isUploading)
                        Container(
                          color: Colors.black.withValues(alpha: 0.5),
                          child: const Center(
                            child: SizedBox(
                              width: 26,
                              height: 26,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2.5,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),

            // Nút Camera nhỏ ở góc avatar
            Positioned(
              bottom: 2,
              right: 2,
              child: GestureDetector(
                onTap: isUploading ? null : () => _pickAvatar(context, ref),
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [Color(0xFF2563EB), Color(0xFF1D4ED8)],
                    ),
                    border: Border.all(color: Colors.white, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.photo_camera_rounded,
                    size: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: isUploading ? null : () => _pickAvatar(context, ref),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.edit_outlined, size: 13, color: Color(0xFF2563EB)),
              SizedBox(width: 4),
              Text(
                'Chạm để đổi ảnh đại diện',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2563EB),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _AvatarInitial extends StatelessWidget {
  const _AvatarInitial({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    final initial = name.trim().isNotEmpty ? name.trim()[0].toUpperCase() : 'U';
    return Container(
      color: const Color(0xFFDBEAFE),
      child: Center(
        child: Text(
          initial,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w800,
            color: Color(0xFF1E40AF),
          ),
        ),
      ),
    );
  }
}
