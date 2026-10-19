import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Painter vẽ đường vệt bay uốn lượn phong cách may vẽ (#9BB6D3).
class CurvedFlightTrailPainter extends CustomPainter {
  const CurvedFlightTrailPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF9BB6D3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;

    final path = Path();
    path.moveTo(size.width * 0.32, size.height);
    path.cubicTo(
      size.width * 0.35,
      size.height * 0.85,
      size.width * 0.12,
      size.height * 0.75,
      size.width * 0.10,
      size.height * 0.65,
    );
    path.cubicTo(
      size.width * 0.08,
      size.height * 0.55,
      size.width * 0.38,
      size.height * 0.45,
      size.width * 0.24,
      size.height * 0.38,
    );
    path.cubicTo(
      size.width * 0.16,
      size.height * 0.32,
      size.width * 0.35,
      size.height * 0.28,
      size.width * 0.40,
      size.height * 0.22,
    );

    // Vẽ nét đứt 6, 6
    final dashPath = Path();
    for (final metric in path.computeMetrics()) {
      double distance = 0.0;
      while (distance < metric.length) {
        final len = math.min(6.0, metric.length - distance);
        dashPath.addPath(
          metric.extractPath(distance, distance + len),
          Offset.zero,
        );
        distance += 12.0;
      }
    }

    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
