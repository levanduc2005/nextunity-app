import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';

/// Đoạn văn bản Điều khoản & Chính sách bảo mật (Terms of Service & Privacy Policy).
class AuthTermsText extends StatelessWidget {
  final VoidCallback? onTermsTap;
  final VoidCallback? onPrivacyTap;

  const AuthTermsText({super.key, this.onTermsTap, this.onPrivacyTap});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: const TextStyle(
          fontSize: 12,
          color: AppColors.textMuted,
          height: 1.45,
        ),
        children: [
          const TextSpan(text: 'Bằng việc tiếp tục, bạn đồng ý với '),
          WidgetSpan(
            alignment: PlaceholderAlignment.baseline,
            baseline: TextBaseline.alphabetic,
            child: GestureDetector(
              onTap: onTermsTap,
              child: const Text(
                'Điều khoản',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          const TextSpan(text: ' & '),
          WidgetSpan(
            alignment: PlaceholderAlignment.baseline,
            baseline: TextBaseline.alphabetic,
            child: GestureDetector(
              onTap: onPrivacyTap,
              child: const Text(
                'Chính sách quyền riêng tư',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
