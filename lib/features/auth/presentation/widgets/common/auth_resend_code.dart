import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';

/// Widget đếm ngược và gửi lại mã OTP (Resend Code).
class AuthResendCode extends StatelessWidget {
  final int countdown;
  final bool isLoading;
  final VoidCallback onResend;
  final String questionText;

  const AuthResendCode({
    super.key,
    required this.countdown,
    this.isLoading = false,
    required this.onResend,
    this.questionText = "Didn't receive the code ?",
  });

  @override
  Widget build(BuildContext context) {
    final formattedTime = '00:${countdown.toString().padLeft(2, '0')}';
    final canResend = countdown == 0 && !isLoading;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          questionText,
          style: const TextStyle(fontSize: 12.5, color: AppColors.textSecondary),
        ),
        const SizedBox(height: 4),
        InkWell(
          onTap: canResend ? onResend : null,
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: canResend ? AppColors.primary : AppColors.textMuted,
              ),
              children: [
                const TextSpan(text: 'Resend Code '),
                TextSpan(
                  text: '[$formattedTime]',
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
