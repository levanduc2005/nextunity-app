import 'package:flutter/material.dart';

/// Nút đăng nhập qua mạng xã hội (Facebook, Gmail, Apple) thiết kế chuẩn theo HTML.
class SocialAuthButton extends StatelessWidget {
  final Widget icon;
  final String label;
  final VoidCallback onTap;

  const SocialAuthButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: double.infinity,
          height: 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFF1F5F9), width: 1.2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 4,
                offset: const Offset(0, 1),
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

/// Icon Facebook vector SVG-like
class FacebookBrandIcon extends StatelessWidget {
  const FacebookBrandIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: const BoxDecoration(
        color: Color(0xFF1877F2),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.bottomCenter,
      child: const Text(
        'f',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          height: 1.05,
        ),
      ),
    );
  }
}

/// Icon Gmail đa sắc chuẩn theo HTML
class GmailBrandIcon extends StatelessWidget {
  const GmailBrandIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24,
      height: 24,
      child: CustomPaint(painter: _GmailIconPainter()),
    );
  }
}

class _GmailIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final scale = size.width / 24.0;

    // Red roof & top line
    final redPaint = Paint()..color = const Color(0xFFEA4335);
    final bluePaint = Paint()..color = const Color(0xFF4285F4);
    final greenPaint = Paint()..color = const Color(0xFF34A853);
    final yellowPaint = Paint()..color = const Color(0xFFFBBC05);

    // Left blue pillar
    final leftPath = Path()
      ..moveTo(4 * scale, 6 * scale)
      ..lineTo(4 * scale, 18 * scale)
      ..lineTo(7 * scale, 18 * scale)
      ..lineTo(7 * scale, 8.5 * scale)
      ..lineTo(12 * scale, 12.5 * scale)
      ..close();
    canvas.drawPath(leftPath, bluePaint);

    // Right green pillar
    final rightPath = Path()
      ..moveTo(20 * scale, 6 * scale)
      ..lineTo(20 * scale, 18 * scale)
      ..lineTo(17 * scale, 18 * scale)
      ..lineTo(17 * scale, 8.5 * scale)
      ..lineTo(12 * scale, 12.5 * scale)
      ..close();
    canvas.drawPath(rightPath, greenPaint);

    // Top red V
    final topPath = Path()
      ..moveTo(4 * scale, 6 * scale)
      ..lineTo(12 * scale, 12.5 * scale)
      ..lineTo(20 * scale, 6 * scale)
      ..lineTo(18 * scale, 4.5 * scale)
      ..lineTo(12 * scale, 9.5 * scale)
      ..lineTo(6 * scale, 4.5 * scale)
      ..close();
    canvas.drawPath(topPath, redPaint);

    // Bottom left yellow accent
    final yellowPath = Path()
      ..moveTo(4 * scale, 15 * scale)
      ..lineTo(4 * scale, 18 * scale)
      ..lineTo(7 * scale, 18 * scale)
      ..close();
    canvas.drawPath(yellowPath, yellowPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Icon Apple logo
class AppleBrandIcon extends StatelessWidget {
  const AppleBrandIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return const Icon(Icons.apple, color: Colors.black, size: 24);
  }
}
