import 'package:flutter/material.dart';

class PlusAmbientBackground extends StatelessWidget {
  const PlusAmbientBackground({super.key, this.height = 330});

  final double height;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      height: height,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1E1B16), Color(0xFF2E2214), Color(0xFF5A3207)],
          ),
        ),
      ),
    );
  }
}
