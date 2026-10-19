import 'package:flutter/material.dart';

/// Origami họa tiết hình học nền cho giao diện profile
class OrigamiDecorPainter extends CustomPainter {
  const OrigamiDecorPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint1 = Paint()..color = const Color(0xFF93C5FD);
    final paint2 = Paint()..color = const Color(0xFF60A5FA);
    final paint3 = Paint()..color = const Color(0xFF3B82F6);

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
