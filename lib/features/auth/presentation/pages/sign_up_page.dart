import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_car/app/router/app_routes.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/core/widgets/widgets.dart';
import 'package:rental_car/features/auth/presentation/providers/auth_controller.dart';
import 'package:rental_car/features/auth/presentation/widgets/common/auth_app_logo_badge.dart';
import 'package:rental_car/features/auth/presentation/widgets/common/auth_background_waves.dart';
import 'package:rental_car/features/auth/presentation/widgets/common/auth_or_divider.dart';
import 'package:rental_car/features/auth/presentation/widgets/common/auth_terms_text.dart';
import 'package:rental_car/features/auth/presentation/widgets/common/social_auth_button.dart';
import 'package:rental_car/features/auth/presentation/widgets/signup/sign_up_bottom_prompt.dart';
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
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Background decorative soft fluid waves phong cách NextUnity
          const AuthBackgroundWaves(),

          // Nút quay lại góc trên trái
          Positioned(
            top: 6,
            left: 6,
            child: SafeArea(
              child: IconButton(
                onPressed: _handleBack,
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 20,
                  color: AppColors.textPrimary,
                ),
                tooltip: 'Quay lại',
              ),
            ),
          ),

          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // 1. Biểu tượng Logo & Lời chào gọn gàng
                      const AuthAppLogoBadge(size: 46),
                      const SizedBox(height: 8),

                      const Text(
                        'Tạo tài khoản mới',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                          letterSpacing: -0.4,
                        ),
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        'Bắt đầu trải nghiệm học tập cùng NextUnity',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // 2. Thẻ Card Đăng ký màu trắng
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 14,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppColors.border),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.textPrimary.withValues(
                                alpha: 0.04,
                              ),
                              blurRadius: 18,
                              offset: const Offset(0, 6),
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
                            const SizedBox(height: 10),

                            // Phân cách Hoặc
                            const AuthOrDivider(
                              text: 'Hoặc đăng ký với',
                              padding: EdgeInsets.zero,
                            ),
                            const SizedBox(height: 10),

                            // Nút đăng ký với Google
                            SocialAuthButton(
                              icon: const GoogleBrandIcon(size: 20),
                              label: 'Đăng ký với Google',
                              height: 42,
                              onTap: _handleGoogleSignIn,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),

                      // 3. Chuyển sang trang Đăng nhập (Sign In)
                      const SignUpBottomPrompt(),
                      const SizedBox(height: 6),

                      // 4. Điều khoản & Chính sách bảo mật
                      const AuthTermsText(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
