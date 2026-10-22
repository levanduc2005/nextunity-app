import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Top hero section on the NextUnity Plus upgrade page, showing the golden crown,
/// PRO tag, headline, and value proposition.
class PlusHeroSection extends StatelessWidget {
  const PlusHeroSection({
    super.key,
    this.pulseAnimation,
  });

  final Animation<double>? pulseAnimation;

  @override
  Widget build(BuildContext context) {
    final badgeWidget = Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            gradient: const LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                Color(0xFFF59E0B), // amber-500
                Color(0xFFFBBF24), // amber-400
                Color(0xFFFDE68A), // amber-200
              ],
            ),
          ),
          child: Center(
            child: SvgPicture.string(
              '''<svg viewBox="0 0 24 24" width="32" height="32" fill="#451A03">
                <path d="M5 16L3 5l5.5 5L12 4l3.5 6L21 5l-2 11H5zm14 3c0 .55-.45 1-1 1H6c-.55 0-1-.45-1-1v-1h14v1z"/>
              </svg>''',
              width: 32,
              height: 32,
            ),
          ),
        ),

        // Floating PRO Badge
        Positioned(
          top: -6,
          right: -8,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 7,
              vertical: 2,
            ),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFFF59E0B),
                  Color(0xFFD97706),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'PRO',
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
      ],
    );

    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 4),
      child: Column(
        children: [
          // Golden Crown in Amber Badge (Clean, sharp, no outer glow)
          if (pulseAnimation != null)
            ScaleTransition(
              scale: pulseAnimation!,
              child: badgeWidget,
            )
          else
            badgeWidget,
          const SizedBox(height: 12),

          // Headline
          const Text(
            'Mở khóa toàn bộ tiềm năng học tập',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              letterSpacing: -0.3,
              height: 1.25,
            ),
          ),
          const SizedBox(height: 6),

          // Value proposition subtitle
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Trải nghiệm học tập thông minh không giới hạn cùng trợ lý AI & kho đề thi FPTU độc quyền',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFFDCFCE7),
                height: 1.4,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
