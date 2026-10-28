import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';

class PaymentMethodOptionCard extends StatelessWidget {
  const PaymentMethodOptionCard({
    super.key,
    required this.title,
    required this.badge,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
    required this.child,
  });

  final String title;
  final String badge;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isSelected ? AppColors.primary : AppColors.border,
          width: isSelected ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: isSelected
                ? AppColors.primary.withValues(alpha: 0.08)
                : Colors.black.withValues(alpha: 0.02),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Radio indicator
                    Container(
                      width: 18,
                      height: 18,
                      margin: const EdgeInsets.only(top: 2),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isSelected ? AppColors.primary : Colors.white,
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.borderMedium,
                          width: 2,
                        ),
                      ),
                      child: isSelected
                          ? const Center(
                              child: CircleAvatar(
                                radius: 3.5,
                                backgroundColor: Colors.white,
                              ),
                            )
                          : null,
                    ),
                    const SizedBox(width: 10),

                    // Title & Description
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                title,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 1.5,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryContainer,
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                    color: AppColors.primaryBorder,
                                  ),
                                ),
                                child: Text(
                                  badge,
                                  style: const TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.primaryForeground,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Text(
                            subtitle,
                            style: const TextStyle(
                              fontSize: 11,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (isSelected) ...[
                  const Divider(height: 20, color: AppColors.surfaceSubtle),
                  child,
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
