import 'package:flutter/material.dart';

/// Widget hiển thị Logo icon chính thức của NextUnity từ file asset `public/Icon-app.png`.
class NextunityLogo extends StatelessWidget {
  const NextunityLogo({
    super.key,
    this.width,
    this.height = 80,
    this.fit = BoxFit.contain,
  });

  final double? width;
  final double? height;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'public/app_logo.png',
      width: width,
      height: height,
      fit: fit,
    );
  }
}

/// Header hiển thị biểu tượng Logo NextUnity & Lời chào mừng.
class NextUnityHeader extends StatelessWidget {
  const NextUnityHeader({
    super.key,
    this.logoHeight = 56,
    this.titleFontSize = 21,
    this.gap = 8,
  });

  final double logoHeight;
  final double titleFontSize;
  final double gap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Biểu tượng Logo NextUnity
        Image.asset(
          'public/app_logo.png',
          height: logoHeight,
          fit: BoxFit.contain,
        ),
        SizedBox(height: gap),
        // Lời chào mừng
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: TextStyle(
              fontSize: titleFontSize,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF111827),
              letterSpacing: -0.5,
            ),
            children: const [
              TextSpan(text: 'Welcome To '),
              TextSpan(
                text: 'NEXTUNITY',
                style: TextStyle(color: Color(0xFF008EFB)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
