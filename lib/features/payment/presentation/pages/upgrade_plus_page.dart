import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_car/core/widgets/widgets.dart';
import 'package:rental_car/features/payment/domain/entities/subscription_plan_entity.dart';
import 'package:rental_car/features/payment/presentation/pages/payment_page.dart';
import 'package:rental_car/features/payment/presentation/providers/payment_providers.dart';
import 'package:rental_car/features/payment/presentation/widgets/common/payment_trust_badges.dart';
import 'package:rental_car/features/payment/presentation/widgets/upgrade_plus/plus_ambient_background.dart';
import 'package:rental_car/features/payment/presentation/widgets/upgrade_plus/plus_benefits_card.dart';
import 'package:rental_car/features/payment/presentation/widgets/upgrade_plus/plus_checkout_button.dart';
import 'package:rental_car/features/payment/presentation/widgets/upgrade_plus/plus_hero_section.dart';
import 'package:rental_car/features/payment/presentation/widgets/upgrade_plus/plus_plan_list_section.dart';
import 'package:rental_car/features/payment/presentation/widgets/upgrade_plus/upgrade_plus_header.dart';

class UpgradePlusPage extends ConsumerStatefulWidget {
  const UpgradePlusPage({super.key});

  @override
  ConsumerState<UpgradePlusPage> createState() => _UpgradePlusPageState();
}

class _UpgradePlusPageState extends ConsumerState<UpgradePlusPage>
    with SingleTickerProviderStateMixin {
  String? _selectedPlan;

  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.04).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  Future<void> _handleProceedPayment(
    SubscriptionPlanEntity selectedPlan,
  ) async {
    final paymentState = ref.read(paymentControllerProvider);
    if (paymentState.isLoading) return;

    final result = await ref
        .read(paymentControllerProvider.notifier)
        .createPayment(selectedPlan.code);

    if (!mounted) return;

    if (result != null) {
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) =>
              PaymentPage(paymentResult: result, planName: selectedPlan.name),
        ),
      );
    } else {
      final errorMsg =
          ref.read(paymentControllerProvider).errorMessage ??
          'Không thể tạo giao dịch thanh toán. Vui lòng thử lại sau.';
      context.showSnackBar(errorMsg);
    }
  }

  @override
  Widget build(BuildContext context) {
    final plansAsync = ref.watch(availablePlansProvider);
    final paymentState = ref.watch(paymentControllerProvider);

    final List<SubscriptionPlanEntity>? loadedPlans = plansAsync.asData?.value;
    final bool hasValidPlans = loadedPlans != null && loadedPlans.isNotEmpty;

    final effectiveSelectedPlan = hasValidPlans
        ? (_selectedPlan != null &&
                  loadedPlans.any((p) => p.code == _selectedPlan)
              ? _selectedPlan!
              : (loadedPlans
                    .firstWhere(
                      (p) => p.isSemester,
                      orElse: () => loadedPlans.first,
                    )
                    .code))
        : null;

    final selectedEntity = hasValidPlans && effectiveSelectedPlan != null
        ? loadedPlans.firstWhere(
            (p) => p.code == effectiveSelectedPlan,
            orElse: () => loadedPlans.first,
          )
        : null;

    final bool canProceed =
        hasValidPlans && !paymentState.isLoading && selectedEntity != null;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: const Color(0xFFF9F8F5),
        body: Stack(
          children: [
            const PlusAmbientBackground(),
            SafeArea(
              child: Column(
                children: [
                  const UpgradePlusHeader(),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                      child: Column(
                        children: [
                          PlusHeroSection(pulseAnimation: _pulseAnimation),
                          const SizedBox(height: 16),
                          const PlusBenefitsCard(),
                          const SizedBox(height: 16),
                          PlusPlanListSection(
                            selectedPlanCode: effectiveSelectedPlan,
                            onSelectPlan: (code) {
                              setState(() => _selectedPlan = code);
                            },
                          ),
                          const SizedBox(height: 20),
                          PlusCheckoutButton(
                            canProceed: canProceed,
                            isLoading: paymentState.isLoading,
                            onTap: canProceed
                                ? () => _handleProceedPayment(selectedEntity)
                                : null,
                          ),
                          const SizedBox(height: 16),
                          const PaymentTrustBadges(),
                          const SizedBox(height: 12),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
