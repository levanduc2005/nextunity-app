import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_car/app/router/app_routes.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/core/widgets/widgets.dart';
import 'package:rental_car/features/auth/presentation/providers/auth_controller.dart';
import 'package:rental_car/features/auth/presentation/widgets/common/auth_card.dart';
import 'package:rental_car/features/auth/presentation/widgets/forgot_password/forgot_password_email_step.dart';
import 'package:rental_car/features/auth/presentation/widgets/forgot_password/forgot_password_otp_step.dart';

/// Màn hình Quên mật khẩu:
/// - Bước 1: Nhập email nhận mã OTP.
/// - Bước 2: Nhập 6 ô OTP để verify.
/// - Bước 3: Chuyển sang trang Change Password.
class ForgotPasswordPage extends ConsumerStatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  ConsumerState<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends ConsumerState<ForgotPasswordPage> {
  final _emailFormKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  // 0: Nhập email, 1: Nhập 6 ô OTP
  int _step = 0;

  static const int _otpLength = 6;
  final List<TextEditingController> _otpControllers = List.generate(
    _otpLength,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(
    _otpLength,
    (_) => FocusNode(),
  );

  int _resendCountdown = 60;
  Timer? _timer;

  @override
  void dispose() {
    _emailController.dispose();
    for (final c in _otpControllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    _timer?.cancel();
    super.dispose();
  }

  void _startCountdown() {
    _timer?.cancel();
    setState(() => _resendCountdown = 60);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendCountdown > 0) {
        setState(() => _resendCountdown--);
      } else {
        timer.cancel();
      }
    });
  }

  String get _currentOtp => _otpControllers.map((c) => c.text).join();

  Future<void> _handleSendEmail() async {
    if (!_emailFormKey.currentState!.validate()) return;

    final email = _emailController.text.trim();
    final success = await ref
        .read(authControllerProvider.notifier)
        .forgotPassword(email);

    if (!mounted) return;

    if (success) {
      context.showSuccessSnackBar('Đã gửi mã xác thực đến $email');
      setState(() => _step = 1);
      _startCountdown();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _focusNodes[0].requestFocus();
      });
    } else {
      final error = ref.read(authControllerProvider).errorMessage;
      context.showErrorSnackBar(error ?? 'Không thể gửi mã xác thực lúc này');
    }
  }

  void _onOtpChanged(int index, String value) {
    if (value.length > 1) {
      final cleanDigits = value.replaceAll(RegExp(r'\D'), '');
      for (int i = 0; i < cleanDigits.length && (index + i) < _otpLength; i++) {
        _otpControllers[index + i].text = cleanDigits[i];
      }
      final nextIndex = (index + cleanDigits.length).clamp(0, _otpLength - 1);
      _focusNodes[nextIndex].requestFocus();
    } else if (value.isNotEmpty) {
      if (index < _otpLength - 1) {
        _focusNodes[index + 1].requestFocus();
      } else {
        _focusNodes[index].unfocus();
        _handleVerifyOtp();
      }
    }
    setState(() {});
  }

  Future<void> _handleVerifyOtp() async {
    final otp = _currentOtp;
    if (otp.length != _otpLength) return;

    final email = _emailController.text.trim();
    final success = await ref
        .read(authControllerProvider.notifier)
        .verifyForgotPasswordOtp(email: email, otp: otp);

    if (!mounted) return;

    if (success) {
      context.pushNamed(AppRoute.resetPassword.name, extra: email);
    } else {
      final error = ref.read(authControllerProvider).errorMessage;
      context.showErrorSnackBar(error ?? 'Mã OTP không hợp lệ hoặc đã hết hạn');
    }
  }

  Future<void> _resendCode() async {
    if (_resendCountdown > 0) return;

    final email = _emailController.text.trim();
    final success = await ref
        .read(authControllerProvider.notifier)
        .forgotPassword(email);

    if (!mounted) return;

    if (success) {
      context.showSuccessSnackBar('Đã gửi lại mã OTP tới $email');
      _startCountdown();
    } else {
      final error = ref.read(authControllerProvider).errorMessage;
      context.showErrorSnackBar(error ?? 'Không thể gửi lại mã OTP lúc này');
    }
  }

  void _handleBack() {
    if (_step == 1) {
      setState(() => _step = 0);
    } else if (context.canPop()) {
      context.pop();
    } else {
      context.goNamed(AppRoute.login.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);
    final email = _emailController.text.trim();

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Stack(
        children: [
          // 1. Ánh sáng loang nền
          _buildAmbientLights(),

          // 2. Nội dung chính
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
                      // Header logo
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

                      // Sân khấu chính với Card
                      AuthCard(
                        innerPadding: const EdgeInsets.symmetric(
                          horizontal: 22,
                          vertical: 24,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (_step == 0)
                              ForgotPasswordEmailStep(
                                formKey: _emailFormKey,
                                emailController: _emailController,
                                isLoading: authState.isLoading,
                                onSendCode: _handleSendEmail,
                              )
                            else
                              ForgotPasswordOtpStep(
                                email: email,
                                controllers: _otpControllers,
                                focusNodes: _focusNodes,
                                onChanged: _onOtpChanged,
                                onVerify: _handleVerifyOtp,
                                resendCountdown: _resendCountdown,
                                isLoading: authState.isLoading,
                                onResend: _resendCode,
                              ),
                            const SizedBox(height: 12),

                            // Nút quay lại đăng nhập
                            TextButton(
                              onPressed: () =>
                                  context.goNamed(AppRoute.login.name),
                              child: const Text(
                                'Quay lại Đăng nhập',
                                style: TextStyle(
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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

  Widget _buildAmbientLights() {
    return Positioned.fill(
      child: IgnorePointer(
        child: Stack(
          children: [
            Positioned(
              top: -60,
              right: -60,
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
              bottom: -50,
              left: -50,
              child: Container(
                width: 240,
                height: 240,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary.withValues(alpha: 0.03),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
