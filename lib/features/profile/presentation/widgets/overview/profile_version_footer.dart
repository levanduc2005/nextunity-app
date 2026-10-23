import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/core/widgets/widgets.dart';

/// Chân trang hiển thị thông tin phiên bản NextUnity và liên kết điều khoản
class ProfileVersionFooter extends StatelessWidget {
  const ProfileVersionFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'NEXTUNITY Studio v2.4',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.textMuted,
            ),
          ),
          const SizedBox(width: 6),
          const Text(
            '•',
            style: TextStyle(color: AppColors.borderMedium, fontSize: 12),
          ),
          const SizedBox(width: 6),
          GestureDetector(
            onTap: () {
              context.showSnackBar('Điều khoản sử dụng NextUnity 2026');
            },
            child: const Text(
              'Điều khoản',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
