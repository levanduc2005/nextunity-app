import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_car/app/router/app_routes.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/core/widgets/widgets.dart';
import 'package:rental_car/features/auth/presentation/providers/auth_controller.dart';
import 'package:rental_car/features/auth/presentation/widgets/common/auth_common.dart';
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
      if (error != null) {
        context.showErrorSnackBar(error);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);

    return Scaffold(
      backgroundColor: AppColors.pastelBackground,
      body: Stack(
        children: [
          // 1. Sóng hữu cơ nền mềm mại đồng nhất với SignUp
          const AuthBackgroundWaves(),

          // 2. Nội dung chính co giãn vừa khít 100% màn hình, tự động cuộn khi mở bàn phím
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 8,
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight - 16,
                      maxWidth: 420,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Header thương hiệu NextUnity
                          const NextUnityHeader(
                            logoHeight: 52,
                            titleFontSize: 20,
                            gap: 6,
                          ),

                          // Card form đăng nhập chính với Sticky Note bên mép trái
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              AuthCard(
                                padding: const EdgeInsets.all(10),
                                innerPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 16,
                                ),
                                borderColor: const Color(
                                  0xFF60A5FA,
                                ).withValues(alpha: 0.8),
                                dashStrokeWidth: 2.0,
                                dashRadius: 16,
                                child: LoginForm(
                                  onSignIn: _handleSignIn,
                                  isLoading: authState.isLoading,
                                ),
                              ),
                              // Sticky Note ghim bên cạnh trái gần đường viền nét đứt
                              const Positioned(
                                left: -16,
                                top: 6,
                                child: StickyNoteBadge(),
                              ),
                            ],
                          ),

                          // Divider "Or"
                          const AuthOrDivider(
                            padding: EdgeInsets.symmetric(vertical: 4),
                          ),

                          // Nút đăng nhập Google
                          SocialAuthButton(
                            icon: const GmailBrandIcon(),
                            label: 'Continue With Gmail',
                            onTap: _handleGoogleSignIn,
                          ),

                          // Nút chuyển sang Sign Up dạng text link tinh tế
                          _buildBottomSignUpButton(context),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSignUpButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Don't have an account? ",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF64748B),
            ),
          ),
          GestureDetector(
            onTap: () => context.goNamed(AppRoute.signUp.name),
            child: const Text(
              'Sign Up',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Color(0xFF0284C7),
                decoration: TextDecoration.underline,
                decorationColor: Color(0xFF0284C7),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
