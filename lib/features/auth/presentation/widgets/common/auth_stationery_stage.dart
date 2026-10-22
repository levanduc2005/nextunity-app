import 'package:flutter/material.dart';
import 'package:rental_car/features/auth/presentation/widgets/common/auth_card.dart';
import 'package:rental_car/features/auth/presentation/widgets/decorations/paper_airplane.dart';
import 'package:rental_car/features/auth/presentation/widgets/decorations/pushpin_and_sticky.dart';
import 'package:rental_car/features/auth/presentation/widgets/decorations/stationery_pen.dart';

/// Khung sân khấu đồ dùng học tập / văn phòng phẩm (Stationery Stage)
/// bao gồm máy bay giấy Origami, bút bi 3D, đinh ghim và giấy note.
class AuthStationeryStage extends StatelessWidget {
  final Widget child;
  final bool showPaperPlane;
  final bool showPen;
  final bool showPushPin;
  final bool showStickyNote;
  final String stickyNoteText;
  final double? cardWidth;
  final double? penTop;
  final double? penBottom;
  final double penRight;
  final double penHeight;

  const AuthStationeryStage({
    super.key,
    required this.child,
    this.showPaperPlane = false,
    this.showPen = false,
    this.showPushPin = false,
    this.showStickyNote = false,
    this.stickyNoteText = '',
    this.cardWidth,
    this.penTop,
    this.penBottom = -15,
    this.penRight = -10,
    this.penHeight = 250,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          // 1. Máy bay giấy Origami và vệt nét đứt bên trái
          if (showPaperPlane)
            Positioned(
              left: -8,
              top: 15,
              child: SizedBox(
                width: 90,
                height: 290,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const Positioned.fill(
                      child: CustomPaint(
                        painter: DashedFlightTrailPainter(
                          color: Color(0xFF94A3B8),
                          strokeWidth: 1.8,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 6,
                      child: Transform.rotate(
                        angle: 10 * 3.14159 / 180,
                        child: const CustomPaint(
                          size: Size(56, 56),
                          painter: OrigamiPaperPlanePainter(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // 2. Cây bút bi xanh 3D bên phải
          if (showPen)
            Positioned(
              right: penRight,
              top: penTop,
              bottom: penTop == null ? penBottom : null,
              child: RealisticPenWidget(
                width: 30,
                height: penHeight,
                rotationDegrees: 22,
              ),
            ),

          // 3. Khung Card chính kẹp giấy và đinh ghim
          Container(
            width: cardWidth ?? double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 18),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Thẻ Card ApSkil
                AuthCard(
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF0F172A).withValues(alpha: 0.04),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ],
                  child: child,
                ),

                // Đinh ghim đỏ góc trên bên trái
                if (showPushPin)
                  const Positioned(
                    top: -12,
                    left: -8,
                    child: PushPinWidget(size: 32),
                  ),

                // Giấy ghi chú vàng góc trên bên phải
                if (showStickyNote)
                  Positioned(
                    top: -18,
                    right: -10,
                    child: TornStickyNoteWidget(
                      text: stickyNoteText,
                      height: 74,
                      rotationDegrees: 7,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
