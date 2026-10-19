import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_spacing.dart';
import 'package:rental_car/core/widgets/widgets.dart';
import 'package:rental_car/features/payment/presentation/widgets/upgrade_benefit_item.dart';

/// Banner màu tím giới thiệu quyền lợi mở khóa của NextUnity Plus
class UpgradeHeaderBanner extends StatelessWidget {
  const UpgradeHeaderBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Column(
        children: [
          Icon(Icons.workspace_premium_rounded, color: Colors.white, size: 56),
          Gap(AppSpacing.sm),
          Text(
            'NextUnity Plus',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          Gap(AppSpacing.xs),
          Text(
            'Mở khóa toàn bộ sức mạnh học tập thông minh',
            style: TextStyle(color: Colors.white70),
          ),
          Gap(AppSpacing.lg),
          UpgradeBenefitItem(
            text: 'Không giới hạn lượt tạo AI Study Set mỗi ngày',
          ),
          UpgradeBenefitItem(text: 'Tải lên slide & tài liệu PDF lên tới 50MB'),
          UpgradeBenefitItem(
            text: 'Tạo đề thi Quiz không giới hạn số lượng câu hỏi',
          ),
          UpgradeBenefitItem(
            text: 'Tính năng xuất Mindmap sang ảnh chất lượng cao',
          ),
        ],
      ),
    );
  }
}
