import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_car/app/router/app_routes.dart';
import 'package:rental_car/core/theme/theme.dart';
import 'package:rental_car/core/widgets/widgets.dart';
import 'package:rental_car/features/auth/presentation/providers/auth_controller.dart';
import 'package:rental_car/features/auth/presentation/widgets/common/auth_common.dart';
import 'package:rental_car/features/auth/presentation/widgets/signup/sign_up_form.dart';

/// Trang Đăng Ký (SignUpPage) chuyển thể chính xác từ bản thiết kế HTML / Tailwind.
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
          // Background decorative soft fluid waves
          const AuthBackgroundWaves(),

          // Main responsive content co giãn vừa khít 100% màn hình, tự động cuộn khi mở bàn phím
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
                      maxWidth: 440,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Header: Logo Graphic & Brand Title
                          const NextUnityHeader(
                            logoHeight: 48,
                            titleFontSize: 20,
                            gap: 6,
                          ),

                          // Main Card with Stitched Border & Sticky Note
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              AuthCard(
                                padding: const EdgeInsets.all(10),
                                innerPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 14,
                                ),
                                dashStrokeWidth: 2.0,
                                dashRadius: 16,
                                child: SignUpForm(
                                  onSignUp: _handleSignUp,
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

                          // Section Divider "Or"
                          const AuthOrDivider(
                            padding: EdgeInsets.symmetric(vertical: 2),
                          ),

                          // Social Logins Section
                          SocialAuthButton(
                            icon: const GmailBrandIcon(),
                            label: 'Continue With Gmail',
                            onTap: _handleGoogleSignIn,
                          ),

                          // Alternative Sign In Action dạng text link
                          _buildAlternativeSignInAction(context),
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

  Widget _buildAlternativeSignInAction(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Already have an account? ',
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
              'Sign In',
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
