import 'package:flutter/material.dart';

/// Widget minh họa bì thư mở (Open Envelope Illustration) kèm phù hiệu tick xanh.
class EnvelopeIllustration extends StatelessWidget {
  final double width;
  final double height;

  const EnvelopeIllustration({super.key, this.width = 144, this.height = 112});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          // 1. Nắp bì thư mở phía sau (Back flap)
          Positioned(
            top: 4,
            left: 0,
            right: 0,
            child: CustomPaint(
              size: Size(width, height * 0.45),
              painter: _EnvelopeFlapPainter(),
            ),
          ),
          // 2. Tờ thư nhô lên bên trong (Letter sticking out)
          Positioned(
            top: 12,
            child: Container(
              width: width * 0.78,
              height: height * 0.55,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: const Color(0xFFE2E8F0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 44,
                    height: 4,
                    decoration: BoxDecoration(
                      color: const Color(0xFF94A3B8),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    width: 60,
                    height: 3.5,
                    decoration: BoxDecoration(
                      color: const Color(0xFF334155),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    width: 60,
                    height: 3.5,
                    decoration: BoxDecoration(
                      color: const Color(0xFF334155),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // 3. Mặt trước bì thư (Front pocket)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CustomPaint(
              size: Size(width, height * 0.65),
              painter: _EnvelopeFrontPocketPainter(),
            ),
          ),
          // 4. Huy hiệu Tick xanh Verified (Green Badge)
          Positioned(
            bottom: 0,
            right: 4,
            child: Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF10B981),
                border: Border.all(color: Colors.white, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF10B981).withValues(alpha: 0.35),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(
                Icons.check_rounded,
                color: Colors.white,
                size: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EnvelopeFlapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    path.moveTo(size.width * 0.08, size.height * 0.85);
    path.lineTo(size.width * 0.5, size.height * 0.15);
    path.lineTo(size.width * 0.92, size.height * 0.85);
    path.close();

    final paint = Paint()..color = const Color(0xFF2563EB);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _EnvelopeFrontPocketPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Lớp chính mặt trước (#60A5FA)
    final mainPocket = Path()
      ..moveTo(w * 0.05, h * 0.12)
      ..lineTo(w * 0.5, h * 0.62)
      ..lineTo(w * 0.95, h * 0.12)
      ..lineTo(w * 0.95, h * 0.92)
      ..quadraticBezierTo(w * 0.95, h, w * 0.90, h)
      ..lineTo(w * 0.10, h)
      ..quadraticBezierTo(w * 0.05, h, w * 0.05, h * 0.92)
      ..close();

    canvas.drawShadow(
      mainPocket,
      Colors.black.withValues(alpha: 0.15),
      4,
      false,
    );
    canvas.drawPath(mainPocket, Paint()..color = const Color(0xFF60A5FA));

    // Nếp gấp đổ bóng trái (#3B82F6)
    final leftFold = Path()
      ..moveTo(w * 0.05, h * 0.12)
      ..lineTo(w * 0.5, h * 0.62)
      ..lineTo(w * 0.05, h * 0.92)
      ..close();
    canvas.drawPath(
      leftFold,
      Paint()..color = const Color(0xFF3B82F6).withValues(alpha: 0.65),
    );

    // Nếp gấp đổ bóng phải (#2563EB)
    final rightFold = Path()
      ..moveTo(w * 0.95, h * 0.12)
      ..lineTo(w * 0.5, h * 0.62)
      ..lineTo(w * 0.95, h * 0.92)
      ..close();
    canvas.drawPath(
      rightFold,
      Paint()..color = const Color(0xFF2563EB).withValues(alpha: 0.55),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
