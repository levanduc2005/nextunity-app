import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_car/app/router/app_routes.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/features/auth/domain/entities/user_entity.dart';
import 'package:rental_car/features/profile/presentation/widgets/overview/profile_card_academic_info.dart';
import 'package:rental_car/features/profile/presentation/widgets/overview/profile_card_header_bar.dart';
import 'package:rental_car/features/profile/presentation/widgets/overview/profile_card_identity_row.dart';
import 'package:rental_car/features/profile/presentation/widgets/overview/profile_subscription_manage_modal.dart';

/// Thẻ Sinh Viên Số (Digital Student ID Pass) hiện đại, sang trọng
class ProfileHeaderCard extends StatelessWidget {
  const ProfileHeaderCard({super.key, required this.user});

  final UserEntity? user;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: AppColors.textPrimary.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
          BoxShadow(
            color: AppColors.textDark.withValues(alpha: 0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. TOP HEADER THẺ: LOGO / TÊN TRƯỜNG & PLUS BADGE
            ProfileCardHeaderBar(
              user: user,
              onManageSubscription: () =>
                  showProfileSubscriptionManageModal(context, user),
            ),

            const SizedBox(height: 12),
            Container(height: 1, color: AppColors.surfaceSubtle),
            const SizedBox(height: 14),

            // 2. HERO ROW: AVATAR & THÔNG TIN CÁ NHÂN
            ProfileCardIdentityRow(user: user),

            const SizedBox(height: 14),

            // 3. THÔNG TIN HỌC TẬP (NIÊN KHÓA & CHUYÊN NGÀNH)
            ProfileCardAcademicInfo(user: user),

            const SizedBox(height: 12),

            // 4. ACTION BUTTON: HỒ SƠ
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => context.push(AppRoute.editProfile.path),
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 9,
                    horizontal: 12,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.25),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.badge_outlined, size: 16, color: Colors.white),
                      SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          'Hồ sơ',
                          style: TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 11,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
