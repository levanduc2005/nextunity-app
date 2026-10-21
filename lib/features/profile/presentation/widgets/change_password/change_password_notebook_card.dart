import 'package:flutter/material.dart';
import 'package:rental_car/features/profile/presentation/widgets/decorations/profile_stationery_decorations.dart';

/// Khung Card phong cách sổ tay có ghim đỏ và sticky note bảo mật
class ChangePasswordNotebookCard extends StatelessWidget {
  const ChangePasswordNotebookCard({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 10, bottom: 4),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.96),
            borderRadius: BorderRadius.circular(26),
            border: Border.all(color: Colors.white, width: 1.5),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF183A78).withValues(alpha: 0.08),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: CustomPaint(
              painter: const StitchedBorderPainter(),
              child: Container(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withValues(alpha: 0.95),
                      const Color(0xFFF8FBFF).withValues(alpha: 0.7),
                      const Color(0xFFF2F7FF).withValues(alpha: 0.4),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: child,
              ),
            ),
          ),
        ),

        // Ghim đỏ 3D Push Pin góc trên bên trái
        const Positioned(top: 0, left: 14, child: PushPinWidget()),

        // Thẻ Sticky Note góc trên bên phải
        const Positioned(
          top: -2,
          right: 2,
          child: ProfileStickyBadge(title: 'Bảo Mật ✦'),
        ),
      ],
    );
  }
}
