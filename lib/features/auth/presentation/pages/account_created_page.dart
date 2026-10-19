import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_car/app/router/app_routes.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/features/auth/presentation/widgets/common/auth_common.dart';
import 'package:rental_car/features/auth/presentation/widgets/decorations/scalloped_badge.dart';

/// Màn hình thông báo tài khoản đã tạo thành công (Account Created / Verified Success).
class AccountCreatedPage extends StatelessWidget {
  const AccountCreatedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pastelBackground,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: AuthStationeryStage(
                showPushPin: false,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 10),
                    // Huy hiệu 12 cánh lượn sóng màu xanh lá với dấu Tick trắng
                    const GreenScallopedBadge(size: 112),
                    const SizedBox(height: 24),

                    // Tiêu đề
                    const Text(
                      'Account Created',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF111827),
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Đoạn mô tả
                    const Text(
                      'Your account has been successfully created.\nYou can now explore courses and start learning',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13.5,
                        height: 1.5,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Nút hành động đến trang Login
                    AuthGradientButton(
                      text: 'Sign In Now',
                      height: 50,
                      borderRadius: 14,
                      gradientColors: const [
                        Color(0xFF3D71B8),
                        Color(0xFF6C97CD),
                      ],
                      shadowColor: const Color(0xFF3A6EB7),
                      onPressed: () => context.goNamed(AppRoute.login.name),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
