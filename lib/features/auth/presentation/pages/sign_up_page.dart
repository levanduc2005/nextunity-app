import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_car/app/router/app_routes.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/core/widgets/widgets.dart';
import 'package:rental_car/features/auth/presentation/providers/auth_controller.dart';
import 'package:rental_car/features/auth/presentation/widgets/common/auth_or_divider.dart';
import 'package:rental_car/features/auth/presentation/widgets/common/auth_terms_text.dart';
import 'package:rental_car/features/auth/presentation/widgets/common/social_auth_button.dart';
import 'package:rental_car/features/auth/presentation/widgets/signup/sign_up_form.dart';

/// Trang Đăng Ký (SignUpPage) chuẩn phong cách ApSkil E-Learning.
class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  Future<void> _handleSignUp(
    String fullName,
    String email,
    String password,
  ) async {
    final success = await ref
        .read(authControllerProvider.notifier)
        .register(fullName: fullName, email: email, password: password);

    if (!mounted) return;

    if (success) {
      context.showSuccessSnackBar(
        'Đăng ký thành công! Vui lòng kiểm tra email lấy mã OTP.',
      );
      context.pushNamed(AppRoute.verifyEmail.name, extra: email);
    } else {
      final error = ref.read(authControllerProvider).errorMessage;
      context.showErrorSnackBar(
        error ?? 'Đăng ký không thành công. Vui lòng thử lại.',
      );
    }
  }

  Future<void> _handleGoogleSignIn() async {
    final success = await ref
        .read(authControllerProvider.notifier)
        .signInWithGoogle();

    if (!mounted) return;

    if (success) {
      context.goNamed(AppRoute.home.name);
    } else {
      final error = ref.read(authControllerProvider).errorMessage;
      if (error != null &&
          error.isNotEmpty &&
          !error.toLowerCase().contains('hủy') &&
          !error.toLowerCase().contains('cancel')) {
        context.showErrorSnackBar(error);
      }
    }
  }

  void _handleBack() {
    if (context.canPop()) {
      context.pop();
    } else {
      context.goNamed(AppRoute.login.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Stack(
        children: [
          // Hiệu ứng ánh sáng nền phong cách ApSkil
          Positioned(
            top: -80,
            right: -80,
            child: Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withValues(alpha: 0.05),
              ),
            ),
          ),
          Positioned(
            bottom: -60,
            left: -60,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withValues(alpha: 0.03),
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                // Top App Bar với nút quay lại
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: _handleBack,
                        icon: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 20,
                          color: Color(0xFF0F172A),
                        ),
                        tooltip: 'Quay lại',
                      ),
                    ],
                  ),
                ),

                // Nội dung chính có thể cuộn
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 420),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // 1. Biểu tượng Logo & Lời chào ApSkil
                            Center(
                              child: Container(
                                width: 68,
                                height: 68,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF0FDF4),
                                  borderRadius: BorderRadius.circular(22),
                                  border: Border.all(
                                    color: const Color(0xFFDCFCE7),
                                    width: 1.5,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFF2E7D32).withValues(alpha: 0.10),
                                      blurRadius: 18,
                                      offset: const Offset(0, 6),
                                    ),
                                  ],
                                ),
                                padding: const EdgeInsets.all(12),
                                child: Center(
                                  child: Image.asset(
                                    'public/app_logo.png',
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 18),

                            const Text(
                              'Tạo tài khoản mới',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFF0F172A),
                                letterSpacing: -0.5,
                              ),
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              'Bắt đầu trải nghiệm học tập cùng cộng đồng FPT',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 13.5,
                                color: Color(0xFF64748B),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 24),

                            // 2. Thẻ Card Đăng ký màu trắng chuẩn ApSkil
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 22,
                                vertical: 24,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(24),
                                border: Border.all(color: const Color(0xFFE2E8F0)),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF0F172A).withValues(alpha: 0.04),
                                    blurRadius: 24,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SignUpForm(
                                    onSignUp: _handleSignUp,
                                    isLoading: authState.isLoading,
                                  ),
                                  const SizedBox(height: 18),

                                  // Phân cách Hoặc
                                  const AuthOrDivider(
                                    text: 'Hoặc đăng ký với',
                                    padding: EdgeInsets.symmetric(vertical: 2),
                                  ),
                                  const SizedBox(height: 16),

                                  // Nút đăng ký với Google
                                  SocialAuthButton(
                                    icon: const GmailBrandIcon(),
                                    label: 'Đăng ký với Google',
                                    onTap: _handleGoogleSignIn,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 22),

                            // 3. Chuyển sang trang Đăng nhập (Sign In)
                            _buildBottomSignInButton(context),
                            const SizedBox(height: 16),

                            // 4. Điều khoản & Chính sách bảo mật
                            const AuthTermsText(),
                            const SizedBox(height: 12),
                          ],
                        ),
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

  Widget _buildBottomSignInButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Đã có tài khoản? ',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF64748B),
          ),
        ),
        GestureDetector(
          onTap: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.goNamed(AppRoute.login.name);
            }
          },
          child: const Text(
            'Đăng nhập ngay',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }
}
