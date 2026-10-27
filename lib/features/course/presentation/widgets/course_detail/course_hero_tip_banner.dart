import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';

/// Banner mẹo học tập chuẩn ApSkil Signature: 'Lộ trình đề xuất: Xem video, ghi chú và làm bài tập sau mỗi bài'
class CourseHeroTipBanner extends StatelessWidget {
  const CourseHeroTipBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
      decoration: BoxDecoration(
        color: AppColors.primaryContainer,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.primaryBorder),
      ),
      child: const Row(
        children: [
          Icon(
            Icons.lightbulb_outline_rounded,
            size: 18,
            color: AppColors.primary,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'Lộ trình đề xuất: Xem video, ghi chú và làm bài tập sau mỗi bài',
              style: TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
                color: AppColors.successForeground,
              ),
            ),
          ),
          Icon(Icons.chevron_right_rounded, size: 18, color: AppColors.primary),
        ],
      ),
    );
  }
}
