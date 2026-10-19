import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Painter vẽ đường viền nét đứt bên trong AuthCard.
class DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double radius;
  final double dashWidth;
  final double dashSpace;

  const DashedBorderPainter({
    this.color = const Color(0xFF9AA4AF),
    this.strokeWidth = 3.5,
    this.radius = 12.0,
    this.dashWidth = 6.0,
    this.dashSpace = 4.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
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
    final dashedPath = _createDashedPath(path, dashWidth, dashSpace);
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
  bool shouldRepaint(covariant DashedBorderPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.radius != radius ||
        oldDelegate.dashWidth != dashWidth ||
        oldDelegate.dashSpace != dashSpace;
  }
}

/// Card màu trắng viền nét đứt dùng chung cho các màn hình Auth.
class AuthCard extends StatelessWidget {
  final Widget child;
  final double? width;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry innerPadding;
  final double borderRadius;
  final Color backgroundColor;
  final Color? borderColor;
  final Color dashColor;
  final double dashStrokeWidth;
  final double dashRadius;
  final List<BoxShadow>? boxShadow;

  const AuthCard({
    super.key,
    required this.child,
    this.width,
    this.padding = const EdgeInsets.all(12),
    this.innerPadding = const EdgeInsets.symmetric(
      horizontal: 18,
      vertical: 24,
    ),
    this.borderRadius = 24.0,
    this.backgroundColor = Colors.white,
    this.borderColor,
    this.dashColor = const Color(0xFF9CA3AF),
    this.dashStrokeWidth = 1.8,
    this.dashRadius = 14.0,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: borderColor != null
            ? Border.all(color: borderColor!, width: 1.5)
            : null,
        boxShadow:
            boxShadow ??
            [
              BoxShadow(
                color: const Color(0xFF2563EB).withValues(alpha: 0.08),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
      ),
      padding: padding,
      child: CustomPaint(
        painter: DashedBorderPainter(
          color: dashColor,
          strokeWidth: dashStrokeWidth,
          radius: dashRadius,
        ),
        child: Padding(padding: innerPadding, child: child),
      ),
    );
  }
}
