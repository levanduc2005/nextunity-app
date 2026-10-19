import 'package:flutter/material.dart';

/// Widget vẽ cây bút bi xanh bóng thực tế (Realistic Stationery Pen).
class RealisticPenWidget extends StatelessWidget {
  final double width;
  final double height;
  final double rotationDegrees;

  const RealisticPenWidget({
    super.key,
    this.width = 40,
    this.height = 280,
    this.rotationDegrees = 20,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: rotationDegrees * 3.1415926535 / 180,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF14284B).withValues(alpha: 0.3),
              blurRadius: 18,
              offset: const Offset(14, 14),
            ),
          ],
        ),
        child: CustomPaint(size: Size(width, height), painter: _PenPainter()),
      ),
    );
  }
}

class _PenPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final centerX = w * 0.5;

    // 1. Nút bấm trên cùng & Khuyên bạc (Top Clicker)
    final clickerPaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFFCBD5E1), Color(0xFFFFFFFF), Color(0xFF94A3B8)],
      ).createShader(Rect.fromLTWH(centerX - 5, 0, 10, h * 0.06));
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(centerX - 5, 0, 10, h * 0.06),
        const Radius.circular(2),
      ),
      clickerPaint,
    );

    // 2. Vòng kim loại trên (Upper metallic ring)
    final ringPaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFFCBD5E1), Color(0xFFFFFFFF), Color(0xFF64748B)],
      ).createShader(Rect.fromLTWH(centerX - 8, h * 0.06, 16, h * 0.03));
    canvas.drawRect(
      Rect.fromLTWH(centerX - 8, h * 0.06, 16, h * 0.03),
      ringPaint,
    );

    // 3. Thân bút chính (Main Royal Blue Barrel)
    final barrelRect = Rect.fromLTWH(centerX - 8, h * 0.09, 16, h * 0.52);
    final barrelPaint = Paint()
      ..shader = const LinearGradient(
        colors: [
          Color(0xFF1E3A8A),
          Color(0xFF2563EB),
          Color(0xFF60A5FA),
          Color(0xFF1D4ED8),
          Color(0xFF0F172A),
        ],
        stops: [0.0, 0.25, 0.45, 0.75, 1.0],
      ).createShader(barrelRect);
    canvas.drawRect(barrelRect, barrelPaint);

    // 4. Highlight bóng sọc trắng trên thân bút
    final highlightPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.6)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;
    canvas.drawLine(
      Offset(centerX - 4, h * 0.09),
      Offset(centerX - 4, h * 0.61),
      highlightPaint,
    );

    // 5. Vòng điểm xuyết vàng kim (Golden Accent Rings)
    final goldPaint1 = Paint()..color = const Color(0xFFE5C158);
    canvas.drawRect(
      Rect.fromLTWH(centerX - 8.5, h * 0.61, 17, h * 0.015),
      goldPaint1,
    );

    final goldPaint2 = Paint()..color = const Color(0xFFC99E32);
    canvas.drawRect(
      Rect.fromLTWH(centerX - 8.2, h * 0.63, 16.4, h * 0.01),
      goldPaint2,
    );

    // 6. Phần tay cầm dưới (Lower Barrel Grip)
    final gripRect = Rect.fromLTWH(centerX - 8, h * 0.645, 16, h * 0.20);
    final gripPaint = Paint()
      ..shader = const LinearGradient(
        colors: [
          Color(0xFF172554),
          Color(0xFF1D4ED8),
          Color(0xFF3B82F6),
          Color(0xFF1E3A8A),
        ],
        stops: [0.0, 0.3, 0.6, 1.0],
      ).createShader(gripRect);
    canvas.drawRect(gripRect, gripPaint);

    // 7. Đầu nón kim loại (Silver Cone Tip)
    final conePath = Path()
      ..moveTo(centerX - 7.5, h * 0.845)
      ..lineTo(centerX + 7.5, h * 0.845)
      ..lineTo(centerX + 3, h * 0.95)
      ..lineTo(centerX - 3, h * 0.95)
      ..close();
    final conePaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFFCBD5E1), Color(0xFFFFFFFF), Color(0xFF64748B)],
      ).createShader(Rect.fromLTWH(centerX - 7.5, h * 0.845, 15, h * 0.105));
    canvas.drawPath(conePath, conePaint);

    // 8. Đầu bi viết (Ballpoint tip)
    final ballpointPaint = Paint()..color = const Color(0xFF1E293B);
    canvas.drawCircle(Offset(centerX, h * 0.965), 2.0, ballpointPaint);

    // 9. Cài bút (Pen Clip - Metallic Silver)
    final clipPath = Path()
      ..moveTo(centerX - 9, h * 0.05)
      ..lineTo(centerX - 13, h * 0.05)
      ..lineTo(centerX - 13, h * 0.38)
      ..quadraticBezierTo(centerX - 11, h * 0.40, centerX - 9, h * 0.38)
      ..close();
    final clipPaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0xFFE2E8F0), Color(0xFFFFFFFF), Color(0xFF94A3B8)],
      ).createShader(Rect.fromLTWH(centerX - 13, h * 0.05, 5, h * 0.35));
    canvas.drawPath(clipPath, clipPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
