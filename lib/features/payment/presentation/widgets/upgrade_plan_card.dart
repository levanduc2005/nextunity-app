import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_car/app/router/app_routes.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/core/theme/app_spacing.dart';
import 'package:rental_car/core/theme/app_text_styles.dart';
import 'package:rental_car/core/widgets/widgets.dart';

/// Card gói đăng ký Plus (1 tháng, 6 tháng, 1 năm)
class UpgradePlanCard extends StatelessWidget {
  const UpgradePlanCard({
    super.key,
    required this.title,
    required this.price,
    required this.period,
    this.isPopular = false,
  });

  final String title;
  final String price;
  final String period;
  final bool isPopular;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: InkWell(
        onTap: () => context.push(AppRoute.payosQr.path),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(title, style: AppTextStyles.heading3),
                      if (isPopular) ...[
                        const Gap.h(AppSpacing.xs),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text(
                            'Tiết kiệm nhất',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const Gap(4),
                  Text(
                    period,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  price,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppColors.primary,
                  ),
                ),
                const Gap(4),
                const Text(
                  'Thanh toán PayOS >',
                  style: TextStyle(fontSize: 11, color: Colors.blue),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
