import 'package:flutter/material.dart';
import 'package:rental_car/features/auth/presentation/widgets/common/auth_common.dart';
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
          'Verify Your Email',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: Color(0xFF0F172A),
            letterSpacing: -0.4,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          "We've Sent A Verification Code To",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12.5,
            color: Color(0xFF475569),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          email,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w800,
            color: Color(0xFF0F172A),
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
