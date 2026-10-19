import 'package:flutter/material.dart';

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
          fontSize: 11.5,
          color: Color(0xFF64748B),
          height: 1.4,
        ),
        children: [
          const TextSpan(text: 'By Creating An Account, You Agree To Our\n'),
          WidgetSpan(
            alignment: PlaceholderAlignment.baseline,
            baseline: TextBaseline.alphabetic,
            child: GestureDetector(
              onTap: onTermsTap,
              child: const Text(
                'Terms Of Service',
                style: TextStyle(
                  color: Color(0xFF0284C7),
                  fontWeight: FontWeight.w600,
                  fontSize: 11.5,
                ),
              ),
            ),
          ),
          const TextSpan(text: ' And '),
          WidgetSpan(
            alignment: PlaceholderAlignment.baseline,
            baseline: TextBaseline.alphabetic,
            child: GestureDetector(
              onTap: onPrivacyTap,
              child: const Text(
                'Privacy Policy',
                style: TextStyle(
                  color: Color(0xFF0284C7),
                  fontWeight: FontWeight.w600,
                  fontSize: 11.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
