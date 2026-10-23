import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Nút đăng nhập qua mạng xã hội (Facebook, Google, Apple) thiết kế chuẩn theo HTML.
class SocialAuthButton extends StatelessWidget {
  final Widget icon;
  final String label;
  final VoidCallback onTap;
  final double height;

  const SocialAuthButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.height = 50,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: double.infinity,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFE2E8F0), width: 1.2),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF0F172A).withValues(alpha: 0.03),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(left: 16, child: icon),
              Text(
                label,
                style: const TextStyle(
                  color: Color(0xFF111827),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Icon Google chính thức đa sắc chuẩn SVG từ `public/google_logo.svg`
class GoogleBrandIcon extends StatelessWidget {
  const GoogleBrandIcon({super.key, this.size = 22});

  final double size;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'public/google_logo.svg',
      width: size,
      height: size,
    );
  }
}
