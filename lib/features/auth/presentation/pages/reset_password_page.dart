import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_car/app/router/app_routes.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/core/widgets/widgets.dart';
import 'package:rental_car/features/auth/presentation/providers/auth_controller.dart';
import 'package:rental_car/features/auth/presentation/widgets/change_password/change_password_curved_trail.dart';
import 'package:rental_car/features/auth/presentation/widgets/change_password/password_criteria_box.dart';
import 'package:rental_car/features/auth/presentation/widgets/common/auth_common.dart';

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
      backgroundColor: AppColors.pastelBackground,
      body: Stack(
        children: [
          // 1. Đường vệt bay uốn lượn đứt nét nền
          const Positioned.fill(
            child: CustomPaint(painter: CurvedFlightTrailPainter()),
          ),

          // 2. Header Brand góc trên bên trái
          const SafeArea(
            child: Padding(
              padding: EdgeInsets.only(left: 20, top: 12),
              child: NextunityLogo(height: 38),
            ),
          ),

          // 3. Nội dung cuộn chính
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 24,
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 390),
                  child: AuthStationeryStage(
                    penRight: -18,
                    penBottom: -32,
                    penHeight: 270,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 8),

                          // Icon Ổ khóa xanh bo tròn
                          _buildLockIcon(),
                          const SizedBox(height: 12),

                          // Tiêu đề
                          const Text(
                            'Create Password',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF111827),
                              letterSpacing: -0.4,
                            ),
                          ),
                          const SizedBox(height: 6),

                          // Phụ đề
                          const Text(
                            'Set a strong password to keep\nyour account secure',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xFF9CA3AF),
                              height: 1.35,
                            ),
                          ),
                          const SizedBox(height: 22),

                          // Input 1: Password
                          AuthTextField(
                            controller: _passwordController,
                            hintText: 'Password',
                            obscureText: _obscurePassword,
                            borderColor: const Color(0xFF4B5563),
                            hintColor: const Color(0xFF6B7280),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: const Color(0xFF6B7280),
                                size: 20,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Vui lòng nhập mật khẩu';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 14),

                          // Input 2: Confirm Password
                          AuthTextField(
                            controller: _confirmPasswordController,
                            hintText: 'Confirm Password',
                            obscureText: _obscureConfirmPassword,
                            borderColor: const Color(0xFF4B5563),
                            hintColor: const Color(0xFF6B7280),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureConfirmPassword
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: const Color(0xFF6B7280),
                                size: 20,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureConfirmPassword =
                                      !_obscureConfirmPassword;
                                });
                              },
                            ),
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Vui lòng xác nhận mật khẩu';
                              }
                              if (val != _passwordController.text) {
                                return 'Mật khẩu xác nhận không khớp';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          // Hộp tiêu chuẩn bảo mật mật khẩu
                          PasswordCriteriaBox(
                            hasMin8Chars: _hasMin8Chars,
                            hasUpperAndLower: _hasUpperAndLower,
                            hasNumber: _hasNumber,
                          ),
                          const SizedBox(height: 18),

                          // Nút Continue
                          AuthGradientButton(
                            text: 'Continue',
                            isLoading: authState.isLoading,
                            borderRadius: 12,
                            gradientColors: const [
                              Color(0xFF295B9D),
                              Color(0xFF4882C3),
                              Color(0xFF609AD9),
                            ],
                            shadowColor: const Color(0xFF295B9D),
                            onPressed: _handleSubmit,
                          ),
                          const SizedBox(height: 12),

                          // Nút quay lại đăng nhập
                          TextButton(
                            onPressed: _handleBack,
                            child: const Text(
                              'Back to Login',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF2563EB),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // 3. Nút quay lại góc trên bên trái
          Positioned(
            top: 8,
            left: 12,
            child: SafeArea(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: _handleBack,
                  borderRadius: BorderRadius.circular(24),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.92),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 18,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLockIcon() {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFF0288D1),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0288D1).withValues(alpha: 0.35),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const Center(
        child: Icon(Icons.lock_rounded, color: Colors.white, size: 26),
      ),
    );
  }
}
