import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/features/auth/domain/entities/user_entity.dart';
import 'package:rental_car/features/profile/presentation/widgets/common/profile_avatar_badge.dart';

/// Hàng danh tính: Avatar với huy hiệu PLUS, tên hiển thị, MSSV và email
class ProfileCardIdentityRow extends StatelessWidget {
  const ProfileCardIdentityRow({super.key, required this.user});

  final UserEntity? user;

  @override
  Widget build(BuildContext context) {
    final displayName = user?.displayName ?? 'Sinh viên NextUnity';
    final isPlus = user?.isPlus == true;
    final email = user?.email ?? '';
    final studentId = user?.studentId?.trim().isNotEmpty == true
        ? user!.studentId!
        : 'Chưa cập nhật';

    return Row(
      children: [
        ProfileAvatarBadge(
          avatarUrl: user?.avatarUrl,
          displayName: displayName,
          radius: 34,
          isPlus: isPlus,
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                displayName,
                style: const TextStyle(
                  fontSize: 17.5,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                  letterSpacing: -0.4,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.surfaceSubtle,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: AppColors.border),
                ),
                child: Text(
                  'MSSV: $studentId',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textSecondaryDark,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (email.isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(
                  email,
                  style: const TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
