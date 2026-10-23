import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_car/app/router/app_routes.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/core/widgets/widgets.dart';
import 'package:rental_car/features/auth/presentation/providers/auth_controller.dart';
import 'package:rental_car/features/auth/presentation/widgets/common/auth_background_waves.dart';
import 'package:rental_car/features/auth/presentation/widgets/common/auth_or_divider.dart';
import 'package:rental_car/features/auth/presentation/widgets/common/auth_terms_text.dart';
import 'package:rental_car/features/auth/presentation/widgets/common/social_auth_button.dart';
import 'package:rental_car/features/auth/presentation/widgets/login/login_form.dart';

/// Màn hình đăng nhập Sign In chuẩn theo thiết kế NextUnity.
class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  Future<void> _handleSignIn(String email, String password) async {
    final success = await ref
        .read(authControllerProvider.notifier)
        .login(email: email, password: password);

    if (!mounted) return;

    if (success) {
      context.goNamed(AppRoute.home.name);
    } else {
      final error = ref.read(authControllerProvider).errorMessage;
      context.showErrorSnackBar(error ?? 'Đăng nhập không thành công');
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

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Background decorative soft fluid waves phong cách NextUnity
          const AuthBackgroundWaves(),

          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // 1. Biểu tượng Logo & Lời chào
                      Center(
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: AppColors.primaryContainer,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: AppColors.primaryBorder,
                              width: 1.2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withValues(
                                  alpha: 0.12,
                                ),
                                blurRadius: 14,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(9),
                          child: Center(
                            child: Image.asset(
                              'public/app_logo.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),

                      const Text(
                        'Chào mừng trở lại',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                          letterSpacing: -0.4,
                        ),
                      ),
                      const SizedBox(height: 3),
                      const Text(
                        'Đăng nhập tài khoản NextUnity để tiếp tục học tập',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12.5,
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // 2. Thẻ Card Đăng nhập màu trắng bo góc
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 16,
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
                              blurRadius: 20,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            LoginForm(
                              onSignIn: _handleSignIn,
                              isLoading: authState.isLoading,
                            ),
                            const SizedBox(height: 12),

                            // Phân cách Hoặc
                            const AuthOrDivider(
                              text: 'Hoặc tiếp tục với',
                              padding: EdgeInsets.zero,
                            ),
                            const SizedBox(height: 12),

                            // Nút đăng nhập Google
                            SocialAuthButton(
                              icon: const GoogleBrandIcon(size: 20),
                              label: 'Tiếp tục với Google',
                              height: 44,
                              onTap: _handleGoogleSignIn,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),

                      // 3. Chuyển sang trang Đăng ký (Sign Up)
                      _buildBottomSignUpButton(context),
                      const SizedBox(height: 8),

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

  Widget _buildBottomSignUpButton(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        const Text(
          'Chưa có tài khoản? ',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: AppColors.textSecondary,
          ),
        ),
        GestureDetector(
          onTap: () => context.goNamed(AppRoute.signUp.name),
          child: const Text(
            'Đăng ký ngay',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }
}
