import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/core/widgets/widgets.dart';
import 'package:rental_car/features/profile/presentation/providers/profile_providers.dart';
import 'package:rental_car/features/profile/presentation/widgets/common/image_picker_bottom_sheet.dart';

class ProfileAvatarBadge extends ConsumerWidget {
  const ProfileAvatarBadge({
    super.key,
    this.avatarUrl,
    this.displayName,
    this.radius = 42,
  });

  final String? avatarUrl;
  final String? displayName;
  final double radius;

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

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Viền gradient bo tròn cao cấp
        Container(
          padding: const EdgeInsets.all(3.5),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [AppColors.primary, AppColors.accent, AppColors.primaryLight],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.28),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Container(
            width: radius * 2,
            height: radius * 2,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFDCFCE7),
              border: Border.all(color: Colors.white, width: 2.5),
            ),
            child: ClipOval(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  if (avatarUrl != null && avatarUrl!.isNotEmpty)
                    Image.network(
                      avatarUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) =>
                          _FallbackAvatar(name: displayName, radius: radius),
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return const Center(
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        );
                      },
                    )
                  else
                    _FallbackAvatar(name: displayName, radius: radius),

                  // Overlay loading khi đang upload ảnh lên Cloudinary
                  if (isUploading)
                    Container(
                      color: Colors.black.withValues(alpha: 0.5),
                      child: const Center(
                        child: SizedBox(
                          width: 24,
                          height: 24,
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

        // Nút Camera nhỏ ở góc dưới bên phải
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: isUploading
                ? null
                : () => _pickAndChangeAvatar(context, ref),
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [AppColors.primary, Color(0xFF15803D)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                border: Border.all(color: Colors.white, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.18),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(
                Icons.photo_camera_rounded,
                size: 15,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _FallbackAvatar extends StatelessWidget {
  const _FallbackAvatar({this.name, required this.radius});

  final String? name;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final initial = (name != null && name!.trim().isNotEmpty)
        ? name!.trim()[0].toUpperCase()
        : 'U';

    return Container(
      color: const Color(0xFFDCFCE7),
      child: Center(
        child: Text(
          initial,
          style: TextStyle(
            fontSize: radius * 0.75,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF166534),
          ),
        ),
      ),
    );
  }
}
