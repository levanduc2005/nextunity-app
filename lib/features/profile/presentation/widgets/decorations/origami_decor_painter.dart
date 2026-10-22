import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';

/// Origami họa tiết hình học nền cho giao diện profile
class OrigamiDecorPainter extends CustomPainter {
  const OrigamiDecorPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint1 = Paint()..color = AppColors.primaryBorder;
    final paint2 = Paint()..color = const Color(0xFF86EFAC);
    final paint3 = Paint()..color = AppColors.primaryLight;

    final path1 = Path()
      ..moveTo(size.width * 0.15, size.height * 0.45)
      ..lineTo(size.width * 0.9, size.height * 0.15)
      ..lineTo(size.width * 0.6, size.height * 0.85)
      ..close();
    canvas.drawPath(path1, paint1);

    final path2 = Path()
      ..moveTo(size.width * 0.45, size.height * 0.58)
      ..lineTo(size.width * 0.9, size.height * 0.15)
      ..lineTo(size.width * 0.6, size.height * 0.85)
      ..close();
    canvas.drawPath(path2, paint2);

    final path3 = Path()
      ..moveTo(size.width * 0.45, size.height * 0.58)
      ..lineTo(size.width * 0.6, size.height * 0.85)
      ..lineTo(size.width * 0.5, size.height * 0.7)
      ..close();
    canvas.drawPath(path3, paint3);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
