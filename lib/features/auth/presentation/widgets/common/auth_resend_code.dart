import 'package:flutter/material.dart';

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
          style: const TextStyle(fontSize: 12.5, color: Color(0xFF64748B)),
        ),
        const SizedBox(height: 4),
        InkWell(
          onTap: canResend ? onResend : null,
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: canResend
                    ? const Color(0xFF2563EB)
                    : const Color(0xFF94A3B8),
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
