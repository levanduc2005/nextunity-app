import 'dart:math' as math;
import 'package:flutter/material.dart';

/// 3D Push Pin trang trí góc trên bên trái của thẻ hồ sơ
class PushPinWidget extends StatelessWidget {
  const PushPinWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 26,
      height: 26,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const RadialGradient(
          center: Alignment(-0.3, -0.3),
          colors: [Color(0xFFFF7A7A), Color(0xFFDC2626), Color(0xFF7F1D1D)],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF7F1D1D).withValues(alpha: 0.35),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.5),
          width: 1.2,
        ),
      ),
      child: Center(
        child: Container(
          width: 5,
          height: 5,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black.withValues(alpha: 0.25),
          ),
        ),
      ),
    );
  }
}

/// Giấy note vàng kèm kẹp giấy đỏ trang trí góc trên bên phải
class ProfileStickyBadge extends StatelessWidget {
  const ProfileStickyBadge({super.key, this.title = 'Hồ Sơ'});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Transform.rotate(
          angle: 5.5 * math.pi / 180,
          child: Container(
            width: 72,
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFFFEF08A),
                  Color(0xFFFDE047),
                  Color(0xFFEAB308),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(4),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFB47814).withValues(alpha: 0.25),
                  blurRadius: 8,
                  offset: const Offset(2, 4),
                ),
              ],
              border: Border.all(
                color: const Color(0xFFCA8A04).withValues(alpha: 0.45),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Align(
                  alignment: Alignment.topRight,
                  child: Icon(
                    Icons.bookmark_rounded,
                    size: 10,
                    color: Color(0xFF78350F),
                  ),
                ),
                const SizedBox(height: 1),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF451A03),
                    letterSpacing: -0.3,
                  ),
                ),
                Container(
                  width: 44,
                  height: 1.5,
                  margin: const EdgeInsets.only(top: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFFB45309).withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Kẹp giấy đỏ nổi bật
        Positioned(
          top: -6,
          left: 4,
          child: CustomPaint(
            size: const Size(12, 28),
            painter: _PaperclipPainter(),
          ),
        ),
      ],
    );
  }
}

class _PaperclipPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFE11D48)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final path = Path()
      ..moveTo(size.width * 0.3, size.height * 0.7)
      ..lineTo(size.width * 0.3, size.height * 0.25)
      ..arcToPoint(
        Offset(size.width * 0.85, size.height * 0.25),
        radius: Radius.circular(size.width * 0.28),
      )
      ..lineTo(size.width * 0.85, size.height * 0.8)
      ..arcToPoint(
        Offset(size.width * 0.05, size.height * 0.8),
        radius: Radius.circular(size.width * 0.4),
      )
      ..lineTo(size.width * 0.05, size.height * 0.35);

    final shadowPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.2
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1);

    canvas.drawPath(path.shift(const Offset(0.5, 1)), shadowPaint);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Khung viền chỉ may đứt nét (Stitched / Dashed Border)
class StitchedBorderPainter extends CustomPainter {
  const StitchedBorderPainter({
    this.color = const Color(0xFF94A9C9),
    this.strokeWidth = 1.4,
    this.dashWidth = 5.0,
    this.dashSpace = 3.5,
    this.radius = 18.0,
  });

  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withValues(alpha: 0.65)
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        strokeWidth / 2,
        strokeWidth / 2,
        size.width - strokeWidth,
        size.height - strokeWidth,
      ),
      Radius.circular(radius),
    );

    final path = Path()..addRRect(rrect);
    final metrics = path.computeMetrics();

    for (final metric in metrics) {
      double distance = 0.0;
      while (distance < metric.length) {
        final length = math.min(dashWidth, metric.length - distance);
        final extractPath = metric.extractPath(distance, distance + length);
        canvas.drawPath(extractPath, paint);
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant StitchedBorderPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.radius != radius;
  }
}
