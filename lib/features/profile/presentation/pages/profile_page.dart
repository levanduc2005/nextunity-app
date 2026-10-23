import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_car/app/router/app_routes.dart';
import 'package:rental_car/core/providers/core_providers.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/core/widgets/widgets.dart';
import 'package:rental_car/features/auth/presentation/providers/auth_controller.dart';
import 'package:rental_car/features/profile/presentation/providers/profile_providers.dart';
import 'package:rental_car/features/profile/presentation/widgets/common/profile_top_circle_button.dart';
import 'package:rental_car/features/profile/presentation/widgets/overview/profile_header_card.dart';
import 'package:rental_car/features/profile/presentation/widgets/overview/profile_learning_metrics.dart';
import 'package:rental_car/features/profile/presentation/widgets/overview/profile_menu_list.dart';
import 'package:rental_car/features/profile/presentation/widgets/overview/profile_version_footer.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  Future<void> _logout(BuildContext context, WidgetRef ref) async {
    final confirmed = await showConfirmDialog(
      context,
      title: 'Đăng xuất tài khoản',
      message: 'Bạn có chắc chắn muốn đăng xuất khỏi ứng dụng NextUnity?',
      confirmLabel: 'Đăng xuất',
      cancelLabel: 'Hủy',
      isDestructive: true,
    );
    if (!confirmed) return;
    await ref.read(authControllerProvider.notifier).logout();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // 1. TOP BAR CÓ NÚT QUAY LẠI
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ProfileTopCircleButton(
                    icon: Icons.arrow_back_ios_new_rounded,
                    tooltip: 'Quay lại',
                    onTap: () {
                      if (context.canPop()) {
                        context.pop();
                      } else {
                        context.go(AppRoute.home.path);
                      }
                    },
                  ),
                  const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Hồ Sơ Cá Nhân',
                        style: TextStyle(
                          fontSize: 16.5,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                          letterSpacing: -0.3,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 36),
                ],
              ),
            ),

            // 2. SCROLLABLE PROFILE CONTENT
            Expanded(
              child: RefreshIndicator(
                color: AppColors.primary,
                backgroundColor: Colors.white,
                onRefresh: () => ref
                    .read(profileControllerProvider.notifier)
                    .refreshProfile(),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(16, 6, 16, 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // 1. DIGITAL STUDENT ID CARD
                      ProfileHeaderCard(user: user),
                      const SizedBox(height: 12),

                      // 2. 3 CHỈ SỐ HỌC TẬP CHUẨN APSKIL
                      const ProfileLearningMetrics(),
                      const SizedBox(height: 16),

                      // 3. GROUPED SETTINGS & SUPPORT MENU
                      ProfileMenuList(
                        user: user,
                        onLogout: () => _logout(context, ref),
                      ),
                      const SizedBox(height: 20),

                      // 4. APP VERSION & SIGNATURE
                      const ProfileVersionFooter(),
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
