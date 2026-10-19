import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Widget huy hiệu lượn sóng 12 cánh màu xanh lá (Green Scalloped Badge with Checkmark)
/// dùng cho màn hình Account Created thành công.
class GreenScallopedBadge extends StatelessWidget {
  final double size;

  const GreenScallopedBadge({super.key, this.size = 110});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00C82C).withValues(alpha: 0.35),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: CustomPaint(
        size: Size(size, size),
        painter: _ScallopedBadgePainter(),
      ),
    );
  }
}

class _ScallopedBadgePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final outerRadius = size.width * 0.48;
    final innerRadius = size.width * 0.40;
    const numPoints = 12;

    final path = Path();
    for (int i = 0; i < numPoints * 2; i++) {
      final angle = (i * math.pi) / numPoints - (math.pi / 2);
      final r = (i % 2 == 0) ? outerRadius : innerRadius;
      final x = center.dx + r * math.cos(angle);
      final y = center.dy + r * math.sin(angle);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        // Vẽ đường cong mềm mại tạo cánh hoa lượn sóng
        final prevAngle = ((i - 1) * math.pi) / numPoints - (math.pi / 2);
        final prevR = ((i - 1) % 2 == 0) ? outerRadius : innerRadius;
        final midAngle = (prevAngle + angle) / 2;
        final midR = (prevR + r) / 2 + size.width * 0.04;
        final cx = center.dx + midR * math.cos(midAngle);
        final cy = center.dy + midR * math.sin(midAngle);

        path.quadraticBezierTo(cx, cy, x, y);
      }
    }
    path.close();

    // 1. Tô màu nền xanh lá tươi #00C82C
    final fillPaint = Paint()
      ..color = const Color(0xFF00C82C)
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, fillPaint);

    // 2. Dấu tick trắng dày ở chính giữa
    final checkPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = size.width * 0.09
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final checkPath = Path();
    checkPath.moveTo(center.dx - size.width * 0.17, center.dy);
    checkPath.lineTo(
      center.dx - size.width * 0.05,
      center.dy + size.width * 0.13,
    );
    checkPath.lineTo(
      center.dx + size.width * 0.20,
      center.dy - size.width * 0.14,
    );

    canvas.drawPath(checkPath, checkPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
