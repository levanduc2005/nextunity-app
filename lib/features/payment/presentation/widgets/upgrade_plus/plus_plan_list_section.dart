import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:rental_car/features/payment/domain/entities/subscription_plan_entity.dart';
import 'package:rental_car/features/payment/presentation/providers/payment_providers.dart';
import 'package:rental_car/features/payment/presentation/widgets/upgrade_plus/plus_plan_card.dart';
import 'package:rental_car/features/payment/presentation/widgets/upgrade_plus/plus_plan_state_views.dart';

class PlusPlanListSection extends ConsumerWidget {
  const PlusPlanListSection({
    super.key,
    required this.selectedPlanCode,
    required this.onSelectPlan,
  });

  final String? selectedPlanCode;
  final ValueChanged<String> onSelectPlan;

  Widget _buildPlanCard({
    required SubscriptionPlanEntity plan,
    required bool isSelected,
    required SubscriptionPlanEntity? monthlyPlan,
    required NumberFormat formatter,
    required VoidCallback onTap,
  }) {
    final isMultiMonth = plan.isSemester || plan.durationDays > 30;
    String? originalPrice;
    String? discountTag;
    String? popularTag;
    String? priceUnit;
    String? badge;

    if (isMultiMonth) {
      badge = 'Ưu đãi sinh viên';
      popularTag = 'PHỔ BIẾN NHẤT';
      final months = (plan.durationDays / 30).round();
      final effectiveMonths = months > 0 ? months : 1;

      if (monthlyPlan != null && monthlyPlan.price > 0) {
        final standardTotal = monthlyPlan.price * effectiveMonths;
        if (plan.price < standardTotal) {
          originalPrice = '${formatter.format(standardTotal)}đ';
          final discountPercent = ((1.0 - (plan.price / standardTotal)) * 100)
              .round();
          if (discountPercent > 0) {
            popularTag = 'TIẾT KIỆM $discountPercent%';
          }
        }
      }

      final monthlyEquivalent = (plan.price / effectiveMonths).round();
      discountTag = '~${formatter.format(monthlyEquivalent)}đ/tháng';
    } else if (plan.durationDays <= 30) {
      priceUnit = '/ tháng';
      badge = 'Gia hạn hàng tháng';
    } else {
      priceUnit = '/ ${plan.durationDays} ngày';
      badge = 'Gói ${plan.durationDays} ngày';
    }

    return PlusPlanCard(
      title: plan.name,
      subtitle: plan.description,
      price: '${formatter.format(plan.price)}đ',
      originalPrice: originalPrice,
      priceUnit: priceUnit,
      discountTag: discountTag,
      badge: badge,
      popularTag: popularTag,
      isSelected: isSelected,
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plansAsync = ref.watch(availablePlansProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  'Chọn gói đăng ký phù hợp',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0F172A),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(width: 8),
              Text(
                'Hủy bất cứ lúc nào',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF64748B),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),

        // Plans List Async
        plansAsync.when(
          loading: () => const Column(
            children: [
              PlanCardSkeleton(),
              SizedBox(height: 12),
              PlanCardSkeleton(),
            ],
          ),
          error: (error, _) => PlanErrorView(
            errorMessage: error.toString().replaceFirst('Exception: ', ''),
            onRetry: () => ref.invalidate(availablePlansProvider),
          ),
          data: (plans) {
            if (plans.isEmpty) {
              return const PlanEmptyView();
            }

            final effectiveSelectedPlan =
                selectedPlanCode != null &&
                    plans.any((p) => p.code == selectedPlanCode)
                ? selectedPlanCode!
                : (plans
                      .firstWhere(
                        (p) => p.isSemester,
                        orElse: () => plans.first,
                      )
                      .code);

            final monthlyPlan = plans
                .cast<SubscriptionPlanEntity?>()
                .firstWhere(
                  (p) =>
                      p != null &&
                      (p.durationDays == 30 || p.code.contains('MONTH')),
                  orElse: () => null,
                );

            final currencyFormatter = NumberFormat('#,###', 'vi_VN');

            return Column(
              children: [
                for (int i = 0; i < plans.length; i++) ...[
                  if (i > 0) const SizedBox(height: 12),
                  _buildPlanCard(
                    plan: plans[i],
                    isSelected: effectiveSelectedPlan == plans[i].code,
                    monthlyPlan: monthlyPlan,
                    formatter: currencyFormatter,
                    onTap: () => onSelectPlan(plans[i].code),
                  ),
                ],
              ],
            );
          },
        ),
      ],
    );
  }
}
