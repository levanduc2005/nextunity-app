import 'package:flutter/material.dart';

/// Widget background lượn sóng mềm mại (Soft Fluid Waves) dùng chung cho màn hình Login & Sign Up.
class AuthBackgroundWaves extends StatelessWidget {
  const AuthBackgroundWaves({super.key});

  @override
  Widget build(BuildContext context) {
    return const Positioned.fill(
      child: CustomPaint(painter: AuthBackgroundWavesPainter()),
    );
  }
}

/// Painter vẽ các đường lượn sóng mềm mại hữu cơ nền.
class AuthBackgroundWavesPainter extends CustomPainter {
  const AuthBackgroundWavesPainter();

  @override
  void paint(Canvas canvas, Size size) {
    // 1. Sóng trên cùng bên trái (Top Left Soft Fluid Wave)
    final topPaint = Paint()
      ..color = const Color(0xFFC7E2FE).withValues(alpha: 0.85)
      ..style = PaintingStyle.fill;

    final topPath = Path();
    final sxTop = size.width / 450.0;
    const syTop = 1.0;

    topPath.moveTo(-80 * sxTop, -40 * syTop);
    topPath.cubicTo(
      -80 * sxTop,
      -40 * syTop,
      150 * sxTop,
      -10 * syTop,
      160 * sxTop,
      160 * syTop,
    );
    topPath.cubicTo(
      170 * sxTop,
      300 * syTop,
      20 * sxTop,
      370 * syTop,
      -80 * sxTop,
      390 * syTop,
    );
    topPath.close();
    canvas.drawPath(topPath, topPaint);

    // 2. Sóng dưới cùng bên phải/giữa (Bottom Right Fluid Wave)
    final bottomPaint = Paint()
      ..color = const Color(0xFFBFDBFE).withValues(alpha: 0.85)
      ..style = PaintingStyle.fill;

    final bottomPath = Path();
    final sxBot = size.width / 450.0;
    final baseBotY = size.height - 280.0;

    bottomPath.moveTo(-30 * sxBot, baseBotY + 180);
    bottomPath.cubicTo(
      80 * sxBot,
      baseBotY + 130,
      220 * sxBot,
      baseBotY + 180,
      290 * sxBot,
      baseBotY + 140,
    );
    bottomPath.cubicTo(
      360 * sxBot,
      baseBotY + 100,
      420 * sxBot,
      baseBotY + 40,
      480 * sxBot,
      baseBotY + 30,
    );
    bottomPath.lineTo(480 * sxBot, size.height + 20);
    bottomPath.lineTo(-30 * sxBot, size.height + 20);
    bottomPath.close();
    canvas.drawPath(bottomPath, bottomPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
