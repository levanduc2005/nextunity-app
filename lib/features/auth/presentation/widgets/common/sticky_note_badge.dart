import 'dart:math' as math;
import 'package:flutter/material.dart';

import 'package:rental_car/core/theme/app_colors.dart';
/// Ngòi bút máy vẽ bằng vector canvas.
class FountainPenWidget extends StatelessWidget {
  final double size;

  const FountainPenWidget({super.key, this.size = 32});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(painter: _FountainPenPainter()),
    );
  }
}

class _FountainPenPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final scale = size.width / 40.0;

    // Thân bút
    final bodyPaint = Paint()
      ..color = AppColors.primaryDark
      ..style = PaintingStyle.fill;
    final bodyRRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(18 * scale, 4 * scale, 4 * scale, 20 * scale),
      Radius.circular(2 * scale),
    );
    canvas.drawRRect(bodyRRect, bodyPaint);

    // Vòng kim loại
    final bandPaint = Paint()
      ..color = AppColors.borderMedium
      ..style = PaintingStyle.fill;
    canvas.drawRect(
      Rect.fromLTWH(17.5 * scale, 24 * scale, 5 * scale, 3 * scale),
      bandPaint,
    );

    // Ngòi bút
    final nibPaint1 = Paint()
      ..color = AppColors.textSecondary
      ..style = PaintingStyle.fill;
    final nibPath1 = Path()
      ..moveTo(20 * scale, 38 * scale)
      ..lineTo(17.5 * scale, 27 * scale)
      ..lineTo(22.5 * scale, 27 * scale)
      ..close();
    canvas.drawPath(nibPath1, nibPaint1);

    // Rãnh mực ngòi bút
    final nibPaint2 = Paint()
      ..color = AppColors.textLabel
      ..style = PaintingStyle.fill;
    final nibPath2 = Path()
      ..moveTo(20 * scale, 38 * scale)
      ..lineTo(19 * scale, 30 * scale)
      ..lineTo(21 * scale, 30 * scale)
      ..close();
    canvas.drawPath(nibPath2, nibPaint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Giấy Sticky Note "Join Now Start Learning!" dán ở góc trên bên trái thẻ AuthCard.
class StickyNoteBadge extends StatelessWidget {
  const StickyNoteBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Transform.rotate(
        angle: -10 * math.pi / 180,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            // Giấy ghi chú hình chữ nhật nhỏ nhắn
            Container(
              width: 86,
              margin: const EdgeInsets.only(top: 5),
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.surfaceLight,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: AppColors.borderMedium),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.10),
                    blurRadius: 8,
                    offset: const Offset(2, 4),
                  ),
                ],
              ),
              child: const Text(
                'Join Now\nStart Learning!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  fontStyle: FontStyle.italic,
                  color: AppColors.textLabel,
                  height: 1.2,
                  letterSpacing: -0.2,
                ),
              ),
            ),

            // Mảnh băng dính vàng dán phía trên
            Positioned(
              top: 0,
              child: Transform.rotate(
                angle: 2 * math.pi / 180,
                child: Container(
                  width: 32,
                  height: 11,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEF08A).withValues(alpha: 0.88),
                    borderRadius: BorderRadius.circular(2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.08),
                        blurRadius: 2,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Cây bút nghiêng 45 độ góc dưới
            Positioned(
              right: -10,
              bottom: -8,
              child: Transform.rotate(
                angle: 45 * math.pi / 180,
                child: const FountainPenWidget(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
