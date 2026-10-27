import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';

/// Huy hiệu logo NextUnity trên đầu các trang xác thực
class AuthAppLogoBadge extends StatelessWidget {
  const AuthAppLogoBadge({super.key, this.size = 68});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: AppColors.primaryContainer,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: AppColors.primaryBorder, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.12),
              blurRadius: 18,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        padding: const EdgeInsets.all(12),
        child: Center(
          child: Image.asset('public/app_logo.png', fit: BoxFit.contain),
        ),
      ),
    );
  }
}
