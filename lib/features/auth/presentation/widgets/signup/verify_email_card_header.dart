import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';

/// Phần tiêu đề và thông tin email nhận mã trong màn hình Xác thực Email
class VerifyEmailCardHeader extends StatelessWidget {
  const VerifyEmailCardHeader({super.key, required this.displayEmail});

  final String displayEmail;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 6),
        const Text(
          'Xác thực Email',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w900,
            color: Color(0xFF0F172A),
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Mã OTP xác thực 6 số đã được gửi đến:',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Color(0xFF64748B),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          displayEmail,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }
}
