import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';

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
            colors: [
              AppColors.primaryDark,
              AppColors.primaryForeground,
              AppColors.primary,
            ],
          ),
        ),
      ),
    );
  }
}
