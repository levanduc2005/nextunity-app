import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/core/widgets/widgets.dart';
import 'package:rental_car/features/profile/presentation/widgets/edit/profile_detail_info_tile.dart';

/// Phần đầu thẻ hồ sơ: Avatar, tên đầy đủ, email và các huy hiệu định danh
class ProfileDetailHeroHeader extends StatelessWidget {
  const ProfileDetailHeroHeader({
    super.key,
    required this.fullName,
    this.avatarUrl,
    required this.email,
    required this.studentId,
    required this.isPlus,
  });

  final String fullName;
  final String? avatarUrl;
  final String email;
  final String studentId;
  final bool isPlus;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          AppAvatar(
            name: fullName,
            imageUrl: avatarUrl,
            radius: 46,
            isPlus: isPlus,
          ),
          const SizedBox(height: 12),

          // Tên người dùng
          Text(
            fullName,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
              letterSpacing: -0.4,
            ),
          ),
          const SizedBox(height: 4),

          // Email
          Text(
            email,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),

          // Badge Hàng (MSSV, Gói thành viên)
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 6,
            runSpacing: 6,
            children: [
              ProfileDetailBadgeChip(
                icon: Icons.tag_rounded,
                label: studentId,
                bgColor: AppColors.primaryContainer,
                textColor: AppColors.primary,
              ),
              ProfileDetailBadgeChip(
                icon: isPlus ? Icons.stars_rounded : Icons.school_rounded,
                label: isPlus ? 'PLUS MEMBER' : 'SINH VIÊN',
                bgColor: isPlus
                    ? AppColors.warningContainer
                    : AppColors.surfaceSubtle,
                textColor: isPlus
                    ? AppColors.warningForeground
                    : AppColors.textSecondaryDark,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
