import 'package:flutter/material.dart';

import 'package:rental_car/core/theme/app_colors.dart';
/// Hàng giá gói cước kèm giá gốc gạch ngang và tag giảm giá
class PlusPlanPriceRow extends StatelessWidget {
  const PlusPlanPriceRow({
    super.key,
    required this.price,
    this.priceUnit,
    this.originalPrice,
    this.discountTag,
    required this.isSelected,
  });

  final String price;
  final String? priceUnit;
  final String? originalPrice;
  final String? discountTag;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 5,
      runSpacing: 2,
      children: [
        Text(
          price,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w900,
            color: isSelected
                ? AppColors.warningDark
                : AppColors.textDark,
          ),
        ),
        if (priceUnit != null)
          Text(
            priceUnit!,
            style: const TextStyle(fontSize: 11.5, color: AppColors.textSecondary),
          ),
        if (originalPrice != null)
          Text(
            originalPrice!,
            style: const TextStyle(
              fontSize: 11.5,
              color: AppColors.textMuted,
              decoration: TextDecoration.lineThrough,
            ),
          ),
        if (discountTag != null)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1.5),
            decoration: BoxDecoration(
              color: AppColors.warningLight,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: AppColors.warningBorder),
            ),
            child: Text(
              discountTag!,
              style: const TextStyle(
                fontSize: 9.5,
                fontWeight: FontWeight.w700,
                color: AppColors.warningDark,
              ),
            ),
          ),
      ],
    );
  }
}
