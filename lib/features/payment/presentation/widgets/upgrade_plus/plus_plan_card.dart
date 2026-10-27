import 'package:flutter/material.dart';
import 'package:rental_car/features/payment/presentation/widgets/upgrade_plus/plus_plan_floating_badge.dart';
import 'package:rental_car/features/payment/presentation/widgets/upgrade_plus/plus_plan_price_row.dart';

/// Interactive subscription plan selection card for NextUnity Plus.
/// Features smooth elevation pop (-3px lift), glowing blue drop shadows,
/// and bright white background when active.
class PlusPlanCard extends StatelessWidget {
  const PlusPlanCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.price,
    this.originalPrice,
    this.priceUnit,
    this.discountTag,
    this.badge,
    this.popularTag,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final String price;
  final String? originalPrice;
  final String? priceUnit;
  final String? discountTag;
  final String? badge;
  final String? popularTag;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOutCubic,
        transform: Matrix4.translationValues(0, isSelected ? -3 : 0, 0),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isSelected ? Colors.white : const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFFF59E0B)
                      : const Color(0xFFE2E8F0),
                  width: isSelected ? 2 : 1,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: const Color(
                            0xFFF59E0B,
                          ).withValues(alpha: 0.20),
                          blurRadius: 18,
                          offset: const Offset(0, 8),
                        ),
                        BoxShadow(
                          color: const Color(
                            0xFF0F172A,
                          ).withValues(alpha: 0.05),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : [
                        BoxShadow(
                          color: const Color(
                            0xFF64748B,
                          ).withValues(alpha: 0.06),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Radio indicator
                  Container(
                    width: 20,
                    height: 20,
                    margin: const EdgeInsets.only(top: 2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSelected
                          ? const Color(0xFFF59E0B)
                          : Colors.white,
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFFF59E0B)
                            : const Color(0xFFCBD5E1),
                        width: 2,
                      ),
                    ),
                    child: isSelected
                        ? const Center(
                            child: CircleAvatar(
                              radius: 4,
                              backgroundColor: Colors.white,
                            ),
                          )
                        : null,
                  ),
                  const SizedBox(width: 12),

                  // Content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          subtitle,
                          style: const TextStyle(
                            fontSize: 11,
                            color: Color(0xFF64748B),
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Price row
                        PlusPlanPriceRow(
                          price: price,
                          priceUnit: priceUnit,
                          originalPrice: originalPrice,
                          discountTag: discountTag,
                          isSelected: isSelected,
                        ),
                      ],
                    ),
                  ),

                  // Right badge
                  if (badge != null) ...[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 7,
                        vertical: 3.5,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFFFFFBEB)
                            : const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(8),
                        border: isSelected
                            ? Border.all(color: const Color(0xFFFDE68A))
                            : null,
                      ),
                      child: Text(
                        badge!,
                        style: TextStyle(
                          fontSize: 9.5,
                          fontWeight: isSelected
                              ? FontWeight.w700
                              : FontWeight.w600,
                          color: isSelected
                              ? const Color(0xFFB45309)
                              : const Color(0xFF475569),
                          letterSpacing: -0.2,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // Optional Floating Badge (e.g. Popular)
            if (popularTag != null)
              PlusPlanFloatingBadge(tag: popularTag!, isSelected: isSelected),
          ],
        ),
      ),
    );
  }
}
