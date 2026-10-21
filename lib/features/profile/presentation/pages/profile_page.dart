import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_car/core/providers/core_providers.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/core/widgets/widgets.dart';
import 'package:rental_car/features/auth/presentation/providers/auth_controller.dart';
import 'package:rental_car/features/profile/presentation/providers/profile_providers.dart';
import 'package:rental_car/features/profile/presentation/widgets/decorations/origami_decor_painter.dart';
import 'package:rental_car/features/profile/presentation/widgets/overview/profile_header_card.dart';
import 'package:rental_car/features/profile/presentation/widgets/overview/profile_menu_list.dart';
import 'package:rental_car/features/profile/presentation/widgets/overview/profile_top_bar.dart';
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
      backgroundColor: AppColors.pastelBackground,
      body: Stack(
        children: [
          // Background Origami Decor góc trên bên trái & bên phải
          const Positioned(
            top: 40,
            left: -15,
            child: Opacity(
              opacity: 0.35,
              child: CustomPaint(
                size: Size(90, 90),
                painter: OrigamiDecorPainter(),
              ),
            ),
          ),
          Positioned(
            top: 110,
            right: -20,
            child: Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFBFDBFE).withValues(alpha: 0.35),
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                // 1. TOP APP BAR: NextUnity Brand & Top Actions
                ProfileTopBar(streak: user?.streak),

                // 2. SCROLLABLE PROFILE CONTENT
                Expanded(
                  child: RefreshIndicator(
                    color: const Color(0xFF2563EB),
                    backgroundColor: Colors.white,
                    onRefresh: () => ref
                        .read(profileControllerProvider.notifier)
                        .refreshProfile(),
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(16, 2, 16, 28),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // MAIN STATIONERY PROFILE CARD
                          ProfileHeaderCard(user: user),
                          const SizedBox(height: 12),

                          // PROFILE MENU ITEMS LIST
                          ProfileMenuList(
                            user: user,
                            onLogout: () => _logout(context, ref),
                          ),
                          const SizedBox(height: 16),

                          // APP VERSION SIGNATURE
                          const ProfileVersionFooter(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
