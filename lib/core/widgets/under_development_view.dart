import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/core/theme/app_spacing.dart';
import 'package:rental_car/core/widgets/app_button.dart';
import 'package:rental_car/core/widgets/gap.dart';

/// Màn hình thông báo tính năng đang trong quá trình phát triển (Coming Soon).
/// Thiết kế hiện đại, tinh tế để hiển thị thay cho các dữ liệu mock khi đưa lên Store.
class UnderDevelopmentView extends StatelessWidget {
  const UnderDevelopmentView({
    super.key,
    required this.featureName,
    this.description,
    this.icon = Icons.construction_rounded,
    this.showBackButton = true,
  });

  final String featureName;
  final String? description;
  final IconData icon;
  final bool showBackButton;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon Badge
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary.withValues(alpha: 0.15),
                    const Color(0xFF6366F1).withValues(alpha: 0.08),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.25),
                  width: 2,
                ),
              ),
              child: Icon(icon, size: 46, color: AppColors.primary),
            ),
            const Gap(AppSpacing.lg),

            // Tag status
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFCBD5E1)),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.schedule_rounded,
                    size: 14,
                    color: Color(0xFF475569),
                  ),
                  SizedBox(width: 6),
                  Text(
                    'ĐANG PHÁT TRIỂN',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF475569),
                      letterSpacing: 0.6,
                    ),
                  ),
                ],
              ),
            ),
            const Gap(AppSpacing.md),

            // Feature Name
            Text(
              featureName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: Color(0xFF0F172A),
                letterSpacing: -0.3,
              ),
            ),
            const Gap(AppSpacing.sm),

            // Description
            Text(
              description ??
                  'Tính năng này đang được đội ngũ kỹ thuật hoàn thiện và tối ưu để mang lại trải nghiệm tốt nhất. Vui lòng đón chờ trong bản cập nhật tới!',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13.5,
                color: Color(0xFF64748B),
                height: 1.5,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Gap(AppSpacing.xl),

            // Optional Back Button
            if (showBackButton && context.canPop())
              SizedBox(
                width: 160,
                child: AppButton(
                  label: 'Quay lại',
                  variant: AppButtonVariant.secondary,
                  onPressed: () => context.pop(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
