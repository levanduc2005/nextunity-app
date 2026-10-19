import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Widget ghim bấm 3D màu đỏ (Red 3D Pushpin).
class PushPinWidget extends StatelessWidget {
  final double size;

  const PushPinWidget({super.key, this.size = 28});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Bóng của ghim
          Positioned(
            left: size * 0.35,
            top: size * 0.45,
            child: Transform.rotate(
              angle: 45 * math.pi / 180,
              child: Container(
                width: size * 0.45,
                height: size * 0.22,
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(size * 0.2),
                ),
              ),
            ),
          ),
          // Đầu ghim (Pin Head)
          Center(
            child: Container(
              width: size * 0.75,
              height: size * 0.75,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const RadialGradient(
                  center: Alignment(-0.35, -0.35),
                  colors: [
                    Color(0xFFFF5252),
                    Color(0xFFC62828),
                    Color(0xFF850B0B),
                  ],
                  stops: [0.0, 0.7, 1.0],
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF850B0B).withValues(alpha: 0.4),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Align(
                alignment: const Alignment(-0.4, -0.4),
                child: Container(
                  width: size * 0.22,
                  height: size * 0.22,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.45),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Widget Kẹp giấy màu đỏ (Red Paperclip).
class RedPaperclipPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;

  const RedPaperclipPainter({
    this.color = const Color(0xFFDC2626),
    this.strokeWidth = 2.4,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final w = size.width;
    final h = size.height;

    // Đường cong kẹp giấy uốn lượn
    final path = Path();
    path.moveTo(w * 0.25, h * 0.35);
    path.lineTo(w * 0.25, h * 0.75);
    path.arcToPoint(
      Offset(w * 0.75, h * 0.75),
      radius: Radius.circular(w * 0.25),
      clockwise: false,
    );
    path.lineTo(w * 0.75, h * 0.20);
    path.arcToPoint(
      Offset(w * 0.08, h * 0.20),
      radius: Radius.circular(w * 0.33),
      clockwise: false,
    );
    path.lineTo(w * 0.08, h * 0.85);
    path.arcToPoint(
      Offset(w * 0.92, h * 0.85),
      radius: Radius.circular(w * 0.42),
      clockwise: false,
    );
    path.lineTo(w * 0.92, h * 0.35);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Widget giấy ghi chú dính vàng có mép rách răng cưa (Torn-edge Sticky Note).
class TornStickyNoteWidget extends StatelessWidget {
  final String text;
  final double width;
  final double height;
  final double rotationDegrees;

  const TornStickyNoteWidget({
    super.key,
    required this.text,
    this.width = 96,
    this.height = 76,
    this.rotationDegrees = 6,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: rotationDegrees * math.pi / 180,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Thân giấy vàng với mép xé răng cưa
          ClipPath(
            clipper: _TornBottomEdgeClipper(),
            child: Container(
              width: width,
              height: height,
              padding: const EdgeInsets.fromLTRB(8, 14, 8, 8),
              decoration: BoxDecoration(
                color: const Color(0xFFFDE047),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.12),
                    blurRadius: 8,
                    offset: const Offset(-2, 4),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'Caveat',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1E293B),
                    height: 1.1,
                  ),
                ),
              ),
            ),
          ),
          // Kẹp giấy đỏ phía trên
          const Positioned(
            left: 12,
            top: -10,
            child: CustomPaint(
              size: Size(18, 32),
              painter: RedPaperclipPainter(),
            ),
          ),
        ],
      ),
    );
  }
}

class _TornBottomEdgeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height * 0.88);

    // Mép răng cưa tự nhiên ở đáy
    final points = [
      Offset(size.width * 0.95, size.height * 0.94),
      Offset(size.width * 0.88, size.height * 0.90),
      Offset(size.width * 0.80, size.height * 0.98),
      Offset(size.width * 0.72, size.height * 0.91),
      Offset(size.width * 0.60, size.height * 0.97),
      Offset(size.width * 0.48, size.height * 0.90),
      Offset(size.width * 0.35, size.height * 0.96),
      Offset(size.width * 0.20, size.height * 0.91),
      Offset(size.width * 0.10, size.height * 0.98),
      Offset(0, size.height * 0.92),
    ];

    for (final pt in points) {
      path.lineTo(pt.dx, pt.dy);
    }
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
