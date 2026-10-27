import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_car/app/router/app_routes.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/core/widgets/widgets.dart';
import 'package:rental_car/features/auth/presentation/providers/auth_controller.dart';
import 'package:rental_car/features/auth/presentation/widgets/change_password/password_criteria_box.dart';
import 'package:rental_car/features/auth/presentation/widgets/common/auth_app_logo_badge.dart';
import 'package:rental_car/features/auth/presentation/widgets/common/auth_background_waves.dart';
import 'package:rental_car/features/auth/presentation/widgets/common/auth_card.dart';
import 'package:rental_car/features/auth/presentation/widgets/common/auth_floating_back_button.dart';
import 'package:rental_car/features/auth/presentation/widgets/common/auth_gradient_button.dart';
import 'package:rental_car/features/auth/presentation/widgets/forgot_password/reset_password_form_fields.dart';

/// Màn hình đặt lại mật khẩu cho luồng Quên mật khẩu (Reset Password via OTP).
class ResetPasswordPage extends ConsumerStatefulWidget {
  final String? email;

  const ResetPasswordPage({super.key, this.email});

  @override
  ConsumerState<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends ConsumerState<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(() => setState(() {}));
    _confirmPasswordController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  bool get _hasMin8Chars => _passwordController.text.length >= 8;
  bool get _hasUpperAndLower {
    final text = _passwordController.text;
    return text.contains(RegExp(r'[A-Z]')) && text.contains(RegExp(r'[a-z]'));
  }

  bool get _hasNumber => _passwordController.text.contains(RegExp(r'[0-9]'));
  bool get _isPasswordValid => _hasMin8Chars && _hasUpperAndLower && _hasNumber;

  void _handleBack() {
    if (context.canPop()) {
      context.pop();
    } else {
      context.goNamed(AppRoute.login.name);
    }
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    if (!_isPasswordValid) {
      context.showErrorSnackBar(
        'Mật khẩu chưa đáp ứng đủ các tiêu chuẩn bảo mật',
      );
      return;
    }

    final email =
        widget.email ?? ref.read(authControllerProvider).emailForOtp ?? '';

    if (email.isEmpty) {
      context.showErrorSnackBar(
        'Không tìm thấy thông tin email. Vui lòng thử lại.',
      );
      return;
    }

    final success = await ref
        .read(authControllerProvider.notifier)
        .resetPassword(email: email, newPassword: _passwordController.text);

    if (!mounted) return;

    if (success) {
      context.showSuccessSnackBar(
        'Mật khẩu đã được cập nhật thành công! Vui lòng đăng nhập lại.',
      );
      context.goNamed(AppRoute.login.name);
    } else {
      final error = ref.read(authControllerProvider).errorMessage;
      context.showErrorSnackBar(error ?? 'Không thể đặt lại mật khẩu lúc này');
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // 1. Background decorative soft fluid waves phong cách NextUnity
          const AuthBackgroundWaves(),

          // 2. Nội dung cuộn chính
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: Column(
                    children: [
                      const AuthAppLogoBadge(),
                      const SizedBox(height: 18),

                      // Khung Card ApSkil
                      AuthCard(
                        innerPadding: const EdgeInsets.symmetric(
                          horizontal: 22,
                          vertical: 24,
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'Tạo mật khẩu mới',
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
                                'Thiết lập mật khẩu an toàn để bảo vệ tài khoản của bạn',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 13.5,
                                  color: Color(0xFF64748B),
                                  height: 1.4,
                                ),
                              ),
                              const SizedBox(height: 22),

                              // Form fields (Password & Confirm Password)
                              ResetPasswordFormFields(
                                passwordController: _passwordController,
                                confirmPasswordController:
                                    _confirmPasswordController,
                                obscurePassword: _obscurePassword,
                                obscureConfirmPassword: _obscureConfirmPassword,
                                onToggleObscurePassword: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                                onToggleObscureConfirmPassword: () {
                                  setState(() {
                                    _obscureConfirmPassword =
                                        !_obscureConfirmPassword;
                                  });
                                },
                              ),
                              const SizedBox(height: 16),

                              // Hộp tiêu chuẩn bảo mật mật khẩu
                              PasswordCriteriaBox(
                                hasMin8Chars: _hasMin8Chars,
                                hasUpperAndLower: _hasUpperAndLower,
                                hasNumber: _hasNumber,
                              ),
                              const SizedBox(height: 20),

                              // Nút Update
                              AuthGradientButton(
                                text: 'Cập nhật mật khẩu',
                                isLoading: authState.isLoading,
                                height: 50,
                                onPressed: _handleSubmit,
                              ),
                              const SizedBox(height: 14),

                              // Nút quay lại đăng nhập
                              Center(
                                child: TextButton(
                                  onPressed: _handleBack,
                                  child: const Text(
                                    'Quay lại Đăng nhập',
                                    style: TextStyle(
                                      fontSize: 13.5,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // 3. Nút quay lại nổi
          AuthFloatingBackButton(onBack: _handleBack),
        ],
      ),
    );
  }
}
