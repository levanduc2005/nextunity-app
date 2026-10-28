import 'package:flutter/material.dart';

import 'package:rental_car/core/theme/app_colors.dart';
/// Thẻ thông báo trạng thái rỗng khi không có môn học đang học hoặc đã hoàn thành
class OngoingEmptyStateCard extends StatelessWidget {
  const OngoingEmptyStateCard({super.key, required this.showCompleted});

  final bool showCompleted;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              showCompleted
                  ? Icons.verified_outlined
                  : Icons.auto_stories_outlined,
              color: AppColors.textMuted,
              size: 26,
            ),
            const SizedBox(height: 6),
            Text(
              showCompleted
                  ? 'Chưa có môn học nào hoàn thành'
                  : 'Không có môn học nào đang diễn ra',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              showCompleted
                  ? 'Tiếp tục hoàn thành bài giảng để nhận chứng chỉ nhé!'
                  : 'Hãy đăng ký các môn học ở danh sách bên dưới.',
              style: const TextStyle(fontSize: 10.5, color: AppColors.textMuted),
            ),
          ],
        ),
      ),
    );
  }
}
