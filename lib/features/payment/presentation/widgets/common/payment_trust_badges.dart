import 'package:flutter/material.dart';

import 'package:rental_car/core/theme/app_colors.dart';
/// Trust and security badges displayed on payment and upgrade screens.
class PaymentTrustBadges extends StatelessWidget {
  const PaymentTrustBadges({super.key});

  @override
  Widget build(BuildContext context) {
    return const Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 6,
      runSpacing: 4,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.verified_user_rounded,
              color: AppColors.successDark,
              size: 14,
            ),
            SizedBox(width: 4),
            Text(
              'Bảo mật 100%',
              style: TextStyle(
                fontSize: 10.5,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        Text('•', style: TextStyle(color: AppColors.borderMedium, fontSize: 10.5)),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.bolt_rounded, color: AppColors.successDark, size: 15),
            SizedBox(width: 3),
            Text(
              'Kích hoạt tức thì',
              style: TextStyle(
                fontSize: 10.5,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        Text('•', style: TextStyle(color: AppColors.borderMedium, fontSize: 10.5)),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.sync_rounded, color: AppColors.warning, size: 14),
            SizedBox(width: 4),
            Text(
              'Hoàn tiền 48h',
              style: TextStyle(
                fontSize: 10.5,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
