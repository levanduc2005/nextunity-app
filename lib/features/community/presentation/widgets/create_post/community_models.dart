import 'package:flutter/material.dart';
import 'package:rental_car/core/theme/app_colors.dart';
import 'package:rental_car/core/widgets/widgets.dart';

/// Modal chọn quyền riêng tư / phạm vi bài viết
void showPrivacyPickerModal({
  required BuildContext context,
  required String currentPrivacy,
  required ValueChanged<String> onSelect,
}) {
  showModalBottomSheet<void>(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (ctx) => SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const Gap(12),
            const Text(
              'Chọn đối tượng xem bài viết',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Color(0xFF0F172A),
              ),
            ),
            const Gap(8),
            ListTile(
              leading: const Icon(
                Icons.public_rounded,
                color: Color(0xFF10B981),
              ),
              title: const Text('Công khai cho sinh viên toàn trường'),
              trailing: currentPrivacy == 'Công khai'
                  ? const Icon(
                      Icons.check_circle_rounded,
                      color: AppColors.primary,
                    )
                  : null,
              onTap: () {
                onSelect('Công khai');
                Navigator.pop(ctx);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.school_rounded,
                color: Color(0xFF3B82F6),
              ),
              title: const Text('Chỉ sinh viên cùng chuyên ngành'),
              trailing: currentPrivacy == 'Cùng chuyên ngành'
                  ? const Icon(
                      Icons.check_circle_rounded,
                      color: AppColors.primary,
                    )
                  : null,
              onTap: () {
                onSelect('Cùng chuyên ngành');
                Navigator.pop(ctx);
              },
            ),
          ],
        ),
      ),
    ),
  );
}
