import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Painter vẽ máy bay giấy origami với các mảng đa giác đổ bóng 3D.
class OrigamiPaperPlanePainter extends CustomPainter {
  final double rotation;

  const OrigamiPaperPlanePainter({this.rotation = 0.0});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    if (rotation != 0) {
      canvas.translate(size.width / 2, size.height / 2);
      canvas.rotate(rotation);
      canvas.translate(-size.width / 2, -size.height / 2);
    }

    final scaleX = size.width / 64.0;
    final scaleY = size.height / 64.0;

    Path scalePath(List<Offset> points) {
      final path = Path()..moveTo(points[0].dx * scaleX, points[0].dy * scaleY);
      for (int i = 1; i < points.length; i++) {
        path.lineTo(points[i].dx * scaleX, points[i].dy * scaleY);
      }
      path.close();
      return path;
    }

    // 1. Cánh chính bên trái (#75A8F9)
    final wingLeft = scalePath([
      const Offset(4, 28),
      const Offset(58, 10),
      const Offset(26, 44),
    ]);
    final paintWing = Paint()..color = const Color(0xFF75A8F9);
    canvas.drawPath(wingLeft, paintWing);

    // 2. Nếp gấp đáy trung tâm (#4B86E8)
    final foldCenter = scalePath([
      const Offset(26, 44),
      const Offset(58, 10),
      const Offset(32, 56),
    ]);
    final paintFold = Paint()..color = const Color(0xFF4B86E8);
    canvas.drawPath(foldCenter, paintFold);

    // 3. Nếp gấp bóng bên trong (#2D60B6)
    final foldShadow = scalePath([
      const Offset(26, 44),
      const Offset(32, 56),
      const Offset(24, 54),
    ]);
    final paintShadow = Paint()
      ..color = const Color(0xFF2D60B6).withValues(alpha: 0.85);
    canvas.drawPath(foldShadow, paintShadow);

    // 4. Cánh sau highlight (#8CB7FC)
    final backFin = scalePath([
      const Offset(18, 32),
      const Offset(58, 10),
      const Offset(26, 44),
    ]);
    final paintFin = Paint()..color = const Color(0xFF8CB7FC);
    canvas.drawPath(backFin, paintFin);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant OrigamiPaperPlanePainter oldDelegate) {
    return oldDelegate.rotation != rotation;
  }
}

/// Painter vẽ đường bay lượn nét đứt uốn cong (Dashed Flight Trail).
class DashedFlightTrailPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;

  const DashedFlightTrailPainter({
    this.color = const Color(0xFF7E8DA0),
    this.strokeWidth = 2.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withValues(alpha: 0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final path = Path();
    // Đường cong bezier uốn lượn phỏng theo quỹ đạo bay của máy bay
    path.moveTo(size.width * 0.75, 0);
    path.cubicTo(
      size.width * 0.35,
      size.height * 0.15,
      size.width * 0.20,
      size.height * 0.32,
      size.width * 0.32,
      size.height * 0.48,
    );
    path.cubicTo(
      size.width * 0.44,
      size.height * 0.64,
      size.width * 0.15,
      size.height * 0.74,
      size.width * 0.05,
      size.height * 0.85,
    );
    path.cubicTo(
      -size.width * 0.08,
      size.height * 0.94,
      size.width * 0.18,
      size.height * 1.02,
      size.width * 0.55,
      size.height * 1.05,
    );

    final dashedPath = _createDashedPath(path, 5.0, 6.0);
    canvas.drawPath(dashedPath, paint);
  }

  Path _createDashedPath(Path source, double dashWidth, double dashSpace) {
    final dest = Path();
    for (final metric in source.computeMetrics()) {
      double distance = 0.0;
      while (distance < metric.length) {
        final length = math.min(dashWidth, metric.length - distance);
        dest.addPath(
          metric.extractPath(distance, distance + length),
          Offset.zero,
        );
        distance += dashWidth + dashSpace;
      }
    }
    return dest;
  }

  @override
  bool shouldRepaint(covariant DashedFlightTrailPainter oldDelegate) => false;
}
