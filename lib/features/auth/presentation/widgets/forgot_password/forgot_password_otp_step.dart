import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/features/auth/presentation/widgets/common/auth_otp_row.dart';
import 'package:rental_car/features/auth/presentation/widgets/common/auth_resend_code.dart';
import 'package:rental_car/features/auth/presentation/widgets/decorations/envelope_illustration.dart';

/// Bước 2 của Quên mật khẩu: Nhập 6 ô OTP xác thực gửi về Email.
class ForgotPasswordOtpStep extends StatelessWidget {
  final String email;
  final List<TextEditingController> controllers;
  final List<FocusNode> focusNodes;
  final void Function(int index, String value) onChanged;
  final VoidCallback onVerify;
  final int resendCountdown;
  final bool isLoading;
  final VoidCallback onResend;

  const ForgotPasswordOtpStep({
    super.key,
    required this.email,
    required this.controllers,
    required this.focusNodes,
    required this.onChanged,
    required this.onVerify,
    required this.resendCountdown,
    required this.isLoading,
    required this.onResend,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 10),
        const EnvelopeIllustration(),
        const SizedBox(height: 16),
        const Text(
          'Nhập mã xác thực',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w900,
            color: AppColors.textPrimary,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Mã OTP 6 số đã được gửi đến địa chỉ:',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 13,
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          email,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 22),

        // 6 ô nhập mã OTP
        AuthOtpRow(
          controllers: controllers,
          focusNodes: focusNodes,
          onChanged: onChanged,
          onCompleted: onVerify,
        ),
        const SizedBox(height: 18),

        // Phần gửi lại mã OTP
        AuthResendCode(
          countdown: resendCountdown,
          isLoading: isLoading,
          onResend: onResend,
        ),
      ],
    );
  }
}
