import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_car/app/router/app_routes.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/core/widgets/widgets.dart';
import 'package:rental_car/features/auth/presentation/providers/auth_controller.dart';
import 'package:rental_car/features/auth/presentation/widgets/common/auth_app_logo_badge.dart';
import 'package:rental_car/features/auth/presentation/widgets/common/auth_background_waves.dart';
import 'package:rental_car/features/auth/presentation/widgets/common/auth_card.dart';
import 'package:rental_car/features/auth/presentation/widgets/common/auth_floating_back_button.dart';
import 'package:rental_car/features/auth/presentation/widgets/common/auth_gradient_button.dart';
import 'package:rental_car/features/auth/presentation/widgets/common/auth_otp_row.dart';
import 'package:rental_car/features/auth/presentation/widgets/common/auth_resend_code.dart';
import 'package:rental_car/features/auth/presentation/widgets/signup/verify_email_card_header.dart';

/// Trang xác thực mã OTP gửi về Email (Verify Your Email).
class VerifyEmailPage extends ConsumerStatefulWidget {
  final String? email;

  const VerifyEmailPage({super.key, this.email});

  @override
  ConsumerState<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends ConsumerState<VerifyEmailPage> {
  static const int _otpLength = 6;
  final List<TextEditingController> _controllers = List.generate(
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
  void initState() {
    super.initState();
    _startCountdown();
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

  @override
  void dispose() {
    _timer?.cancel();
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  String get _currentOtp => _controllers.map((c) => c.text.trim()).join();

  String get _displayEmail {
    final stateEmail = ref.read(authControllerProvider).emailForOtp;
    return widget.email ?? stateEmail ?? 'your_email@gmail.com';
  }

  void _onDigitChanged(int index, String value) {
    if (value.length > 1) {
      final cleanDigits = value.replaceAll(RegExp(r'\D'), '');
      for (int i = 0; i < cleanDigits.length && (index + i) < _otpLength; i++) {
        _controllers[index + i].text = cleanDigits[i];
      }
      final nextIndex = (index + cleanDigits.length).clamp(0, _otpLength - 1);
      _focusNodes[nextIndex].requestFocus();
    } else if (value.isNotEmpty) {
      if (index < _otpLength - 1) {
        _focusNodes[index + 1].requestFocus();
      } else {
        _focusNodes[index].unfocus();
        _verifyCode();
      }
    }
    setState(() {});
  }

  Future<void> _verifyCode() async {
    final otp = _currentOtp;
    if (otp.length != _otpLength) return;

    final success = await ref
        .read(authControllerProvider.notifier)
        .verifyRegisterOtp(email: _displayEmail, otp: otp);

    if (!mounted) return;

    if (success) {
      context.goNamed(AppRoute.accountCreated.name);
    } else {
      final error = ref.read(authControllerProvider).errorMessage;
      context.showErrorSnackBar(
        error ?? 'Mã xác thực không chính xác hoặc đã hết hạn',
      );
    }
  }

  Future<void> _resendCode() async {
    if (_resendCountdown > 0) return;

    final success = await ref
        .read(authControllerProvider.notifier)
        .sendOtp(_displayEmail);

    if (!mounted) return;

    if (success) {
      context.showSuccessSnackBar('Đã gửi lại mã xác thực tới $_displayEmail');
      _startCountdown();
    } else {
      final error = ref.read(authControllerProvider).errorMessage;
      context.showErrorSnackBar(error ?? 'Không thể gửi lại mã OTP lúc này');
    }
  }

  void _handleBack() {
    if (context.canPop()) {
      context.pop();
    } else {
      context.goNamed(AppRoute.signUp.name);
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
                  vertical: 16,
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
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            VerifyEmailCardHeader(displayEmail: _displayEmail),
                            const SizedBox(height: 24),

                            // 6 ô nhập mã OTP
                            AuthOtpRow(
                              controllers: _controllers,
                              focusNodes: _focusNodes,
                              onChanged: _onDigitChanged,
                              onCompleted: _verifyCode,
                            ),
                            const SizedBox(height: 12),

                            // Dòng chú thích thời gian sống OTP
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.schedule_rounded,
                                  size: 14,
                                  color: Color(0xFF94A3B8),
                                ),
                                SizedBox(width: 4),
                                Text(
                                  'Mã xác thực có hiệu lực trong 5 phút',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF94A3B8),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),

                            // Nút xác thực
                            AuthGradientButton(
                              text: 'Xác nhận OTP',
                              isLoading: authState.isLoading,
                              onPressed: _verifyCode,
                              height: 50,
                            ),
                            const SizedBox(height: 18),

                            // Gửi lại mã OTP
                            AuthResendCode(
                              countdown: _resendCountdown,
                              isLoading: authState.isLoading,
                              onResend: _resendCode,
                            ),
                            const SizedBox(height: 12),

                            // Nút quay lại Đăng ký
                            TextButton.icon(
                              onPressed: _handleBack,
                              icon: const Icon(
                                Icons.arrow_back_rounded,
                                size: 16,
                                color: AppColors.primary,
                              ),
                              label: const Text(
                                'Quay lại Đăng ký',
                                style: TextStyle(
                                  fontSize: 13,
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
          AuthFloatingBackButton(onBack: _handleBack),
        ],
      ),
    );
  }
}
